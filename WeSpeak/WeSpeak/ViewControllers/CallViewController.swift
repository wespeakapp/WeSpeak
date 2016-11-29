//
//  CallViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/15/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import OpenTok

class CallViewController: UIViewController {
    @IBOutlet weak var hangUpButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var videoCallButton: UIButton!
    @IBOutlet weak var partnerNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var subcriberView: UIView!
    @IBOutlet weak var publisherView: UIView!
    
    var countdownSecond = 600
    var apiKey: String = "45711502"
    var sessionId: String!
    var token: String!
    var session: OTSession!
    var publisher: OTPublisher!
    var subscriber: OTSubscriber!
    var isPublish = false
    var isSubscribe = false
    let dialog = Dialog()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup hang up button
        hangUpButton.layer.cornerRadius = hangUpButton.frame.height / 2
        // setup mute button
        microphoneButton.layer.cornerRadius = microphoneButton.frame.height / 2
        videoCallButton.layer.cornerRadius = videoCallButton.frame.height / 2
        microphoneButton.layer.borderColor = #colorLiteral(red: 0.6606677175, green: 0.660764873, blue: 0.6606466174, alpha: 1).cgColor
        microphoneButton.layer.borderWidth = 2
        // set partner's name
        partnerNameLabel.text = Singleton.sharedInstance.partner.name
        // set countdown
        countdownLabel.text = "10:00"
        
        dialog.frame = view.bounds
        view.addSubview(dialog)
    }
    
    @IBAction func onHangUpButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()! as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countdown()
        session = OTSession(apiKey: apiKey, sessionId: sessionId, delegate: self)
        doConnect()
    }
    
    func countdown() {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
                self.countdownSecond -= 1
                let m = self.countdownSecond / 60
                let s = self.countdownSecond - 60 * m
                self.countdownLabel.text = "0\(m):" + (s > 9 ? "\(s)" : "0\(s)")
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doConnect() {
        session.connect(withToken: token, error: nil)
    }
    
    func doPublish() {
        publisher = OTPublisher(delegate: self, name: UIDevice.current.name)
        session.publish(publisher, error: nil)
        publisherView.addSubview((publisher?.view)!)
        let witdhPublisherView = (150 / publisherView.frame.height) * publisherView.frame.width
        publisher?.view.frame = CGRect(x: publisherView.frame.width - witdhPublisherView - 20, y: publisherView.frame.height - 170, width: witdhPublisherView, height: 150)
    }
    
    func connected() {
        if isSubscribe && isPublish {
            dialog.showStartButton()
        }
    }
    @IBAction func onTouchHangUpButton(_ sender: UIButton) {
        session.disconnect(nil)
    }
    @IBAction func onMicrophoneButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func onVideoCallButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

extension CallViewController: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession!) {
        print("connect success")
        doPublish()
    }
    
    func sessionDidDisconnect(_ session: OTSession!) {
        print("session disconnect")
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        present(vc, animated: true, completion: nil)
    }
    
    func session(_ session: OTSession!, didFailWithError error: OTError!) {
        print("fail \(error.description)")
    }
    
    func session(_ session: OTSession!, streamCreated stream: OTStream!) {
        subscriber = OTSubscriber(stream: stream, delegate: self)
        session.subscribe(subscriber, error: nil)
    }
    
    func session(_ session: OTSession!, streamDestroyed stream: OTStream!) {
        print("stream destroyed")
        session.disconnect(nil)
    }
}

extension CallViewController: OTPublisherDelegate {
    func publisher(_ publisher: OTPublisherKit!, didFailWithError error: OTError!) {
        print("publish fail")
    }
    func publisher(_ publisher: OTPublisherKit!, streamCreated stream: OTStream!) {
        isPublish = true
        connected()
    }
}

extension CallViewController: OTSubscriberDelegate {
    func subscriberDidConnect(toStream subscriber: OTSubscriberKit!) {
        print("subscribe connect")
        isSubscribe = true
        connected()
    }
    func subscriber(_ subscriber: OTSubscriberKit!, didFailWithError error: OTError!) {
        print("subscibe fail")
    }
    func subscriberVideoDataReceived(_ subscriber: OTSubscriber!) {
        subscriber.view.frame = CGRect(x: 0, y: 0, width: subcriberView.frame.width, height: subcriberView.frame.height)
        subcriberView.addSubview(subscriber.view)
    }
}

