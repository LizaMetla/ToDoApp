//
//  Model.swift
//  ToDoApp
//
//  Created by Елизавета Метла on 5/26/20.
//  Copyright © 2020 Елизавета Метла. All rights reserved.
//

import Foundation

///logic of app

var toDoList:[[String : Any]] = [[ "Name" : "Поцеловать Максима", "isCompleted" : true], [ "Name" : "Приготовить овощи", "isCompleted" : false]]

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoList.append(["Name" : nameItem, "isCompleted" : false])
    saveData()
}

func removeItem(at index: Int) {
    toDoList.remove(at: index)
    saveData()
}

func changeState(at item: Int) -> Bool {
    toDoList[item]["isCompleted"] = !(toDoList[item]["isCompleted"] as! Bool)
   
    //save
    saveData()
    
    //return data
    return toDoList[item]["isCompleted"] as! Bool
}

func saveData() {
    //бывают проблемы с UD в плане сохранения данных
    
    //словарь для записи данных
    UserDefaults.standard.set(toDoList, forKey: "toDoDataKey")
    
    //синхронизация
    UserDefaults.standard.synchronize()
    
    print("saved data")
    
}

func loadData() {
    //чтобы загрузить данные (получаем словарь)
    //as? [[String : Any]] для преобразования типов
    if let array = UserDefaults.standard.array(forKey: "toDoDataKey") as? [[String : Any]] {
        toDoList = array
    } else {
        toDoList = []
    }
    
}
