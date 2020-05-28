//
//  Model.swift
//  ToDoApp
//
//  Created by Елизавета Метла on 5/26/20.
//  Copyright © 2020 Елизавета Метла. All rights reserved.
//

import Foundation

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
}

func removeItem(at index: Int) {
    toDoList.remove(at: index)
}

func changeState(at item: Int) -> Bool {
    toDoList[item]["isCompleted"] = !(toDoList[item]["isCompleted"] as! Bool)
    
    //return data
    return toDoList[item]["isCompleted"] as! Bool
}


