//
//  TableViewController.swift
//  ToDoApp
//
//  Created by Елизавета Метла on 5/26/20.
//  Copyright © 2020 Елизавета Метла. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    // MARK: - редактирование записей (кнопка)
    @IBAction func pushEditing(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        //после смены режима редактирования обновляем таблицу, чтобы отработали методы делегатов
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - добавление записей (кнопка)
    @IBAction func pushAddAction(_ sender: Any) {
        let allertController = UIAlertController(title: "Create new note", message: nil, preferredStyle: .alert)
        allertController.addTextField { (textField) in
            textField.placeholder = "New note"
        }
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        
        // MARK: - добавление новой записи
        let alertActionCreate = UIAlertAction(title: "Create", style: .default) { (alert) in
            
            //доступ к текстовому полю после нажатия кнопки
            let newNote = allertController.textFields![0].text
            addItem(nameItem: newNote!)//разворачиваем значение
            self.tableView.reloadData()
            
            //self чтобы обращались к самому классу
        }
        //print(toDoList)
        allertController.addAction(alertActionCancel)
        allertController.addAction(alertActionCreate)
        present(allertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.layer.cornerRadius = 5
        tableView.layer.shadowColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
  
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoList.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = toDoList[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        // Configure the cell...
        
        //галочка для вида отмеченного задания
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "checkk.png")
            
        } else {
            cell.imageView?.image = UIImage(named: "circle.png")
        }
        
        if tableView.isEditing{
            //cell.textLabel?.alpha = 0.4
            cell.textLabel?.textColor = .gray
            cell.imageView?.alpha = 0.4
        } else {
            //cell.textLabel?.alpha = 1
            cell.textLabel?.textColor = .black
            cell.imageView?.alpha = 1
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
      
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "checkk.png")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "circle.png")
        }
        
        //обновление таблицы
       // tableView.reloadData()
        
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        
        
        //сохранение перемещения ячеек
        //реализация в Model
        moveItemInRow(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }
    
    
    //2 функции чтобы убрать удаление в режиме редактирования
    //оставила удаление только по свайпу
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
        
        //переназначим
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
