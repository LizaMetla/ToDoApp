//
//  Model.swift
//  ToDoApp
//
//  Created by Елизавета Метла on 5/26/20.
//  Copyright © 2020 Елизавета Метла. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
///logic of app

var toDoList:[[String : Any]] {
    set {
        //бывают проблемы с UD в плане сохранения данных (могут НЕ сохраняться)
        
        //словарь для записи данных
        UserDefaults.standard.set(newValue, forKey: "toDoDataKey")
        
        //синхронизация
        UserDefaults.standard.synchronize()
        
        print("saved data")
    }
    get {
        //чтобы загрузить данные (получаем словарь)
        //as? [[String : Any]] для преобразования типов
        if let array = UserDefaults.standard.array(forKey: "toDoDataKey") as? [[String : Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoList.append(["Name" : nameItem, "isCompleted" : false])
    setBadge()
}

func removeItem(at index: Int) {
    toDoList.remove(at: index)
    setBadge()
}

func moveItemInRow(fromIndex: Int, toIndex: Int) {
    
    let from = toDoList[fromIndex]
    toDoList.remove(at: fromIndex)
    toDoList.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool {
    toDoList[item]["isCompleted"] = !(toDoList[item]["isCompleted"] as! Bool)
    
    setBadge()
    
    //return data
    return toDoList[item]["isCompleted"] as! Bool
}

//запрашивать разреешение на уведомление в делегате
func requesForNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled{
            print("approved for notifications")
        } else {
            print("disabled for notifications")
        }
    }
}

//функция для создания иконки уведомления
func setBadge() {
    
    var totalBadgeNumber: Int = 0
    for items in toDoList {
        if (items["isCompleted"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
