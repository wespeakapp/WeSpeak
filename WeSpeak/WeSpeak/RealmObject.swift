//
//  RealmObject.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/17/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift

class Task: Object{
    dynamic var name:String?
    dynamic var age:Int = 5
}

class ListTask: Object{
    dynamic var category:String?
    let tasks = List<Task>()
}

class StorageData{
    static func write(){
        let realm = try! Realm()
        try! realm.write {
            let task1 = Task(value:["Huy",22])
            let task2 = Task(value:["Huy1",23])
            let task3 = Task(value:["Huy2",24])
            let task4 = Task(value:["Huy3",25])
            let task5 = Task(value:["Huy4",26])
            let taskList = ListTask()
            taskList.tasks.append(task1)
            taskList.tasks.append(task2)
            taskList.tasks.append(task3)
            taskList.category = "Mrri"
            
            //realm.add(taskList)
        }
    }
    static func read(){
        let tasks = try! Realm().objects(ListTask)
        if tasks.count > 0{
            for task in tasks{
                print(task.category)
                for t in task.tasks{
                    print(t.name)
                }
               
            }
        }
        
    }
}
