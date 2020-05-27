//
//  Model.swift
//  ToDoApp
//
//  Created by Елизавета Метла on 5/26/20.
//  Copyright © 2020 Елизавета Метла. All rights reserved.
//

import Foundation

///logic of app

var toDoList:[[String : Any]] = [[ "Name" : "Поцеловать Максима", "isCompleted" : false], [ "Name" : "Приготовить овощи", "isCompleted" : false]]

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoList.append(["Name" : nameItem, "isCompleted" : false])
    saveData()
}

func removeItem(at index: Int) {
    toDoList.remove(at: index)
    saveData()
}

func saveData() {
    
}

func loadData() {
    
}
