//
//  SystemMessage.swift
//  WeSpeak
//
//  Created by Girge on 11/29/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import SwiftMessages

class SystemMessage {
    class func show(body: String) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.success)
        view.configureContent(body: body)
        SwiftMessages.show(view: view)
    }
}
