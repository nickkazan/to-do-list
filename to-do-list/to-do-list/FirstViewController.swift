//
//  FirstViewController.swift
//  to-do-list
//
//  Created by Nick Kazan on 2018-11-30.
//  Copyright © 2018 Nick Kazan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    struct Item: Codable {
        
        var title : String
        var completed : Bool
    }
    
    let defaults = UserDefaults.standard;
    var tasks = [Item]();
    var buttonStatus = 1;
    var completeTasks = [Item]();
    @IBOutlet weak var tableList: UITableView!
    
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add an item", message: "", preferredStyle: .alert);
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter Task";
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0];
            print("Text field: \(textField?.text ?? "")")
            if (textField?.text?.count)! > 0 {
                let item = Item(title: (textField?.text)!, completed: false)
                self.tasks.append(item);
                do {
                    let itemData = try JSONEncoder().encode(self.tasks)
                    UserDefaults.standard.set(itemData, forKey: "tasks")
                } catch {
                    print(error)
                }
                self.tableList.reloadData();
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tasks.count)
        return tasks.count;
    }
    
    //Toggle the star button
    @objc func starClicked(_ sender:UIButton) {
        if buttonStatus == 1 {
            sender.setImage(UIImage(named: "starC.png"), for: .normal)
            buttonStatus = 0
        }
        else if buttonStatus == 0 {
            sender.setImage(UIImage(named: "starU.png"), for: .normal)
            buttonStatus = 1
        }
    }

    //Handle the button and text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell");
        let label = UILabel(frame: CGRect(x: 60, y: 0, width: 100, height: 30))
        let cellButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        label.text = tasks[indexPath.row].title
        label.tag = indexPath.row
        cell.contentView.addSubview(label)
        cellButton.frame = CGRect(x: 10, y: 0, width: 30, height: 30);
        cellButton.setImage(UIImage(named: "starU.png"), for: .normal)
        cellButton.addTarget(self, action: #selector(starClicked), for: .touchUpInside)

        cell.contentView.addSubview(cellButton);

        
        cell.backgroundColor = UIColor (red: 0.18, green: 0.71, blue: 1.0, alpha: 1.0);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.tasks[indexPath.row].completed = true
            completeTasks.append(tasks[indexPath.row]);
            self.tasks.remove(at: indexPath.row);
            do {
                let itemData = try JSONEncoder().encode(self.tasks)
                let itemData2 = try JSONEncoder().encode(self.completeTasks)
                UserDefaults.standard.set(itemData, forKey: "tasks")
                UserDefaults.standard.set(itemData2, forKey: "completeTasks")
            } catch {
                
                print(error)
            }
            tableList.reloadData();
        }
        
    }
    override func viewDidLoad() {
        //Load
        super.viewDidLoad()
        
        //Current Tasks
        guard let data = UserDefaults.standard.data(forKey: "tasks") else {
            self.tasks = []
            return
        }
        do {
            self.tasks = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print(error)
            self.tasks = []
        }
        guard let dataCompleted = UserDefaults.standard.data(forKey: "completeTasks") else {
            self.completeTasks = []
            return
        }
        do {
            self.completeTasks = try JSONDecoder().decode([Item].self, from: dataCompleted)
        } catch {
            print(error)
            self.completeTasks = []
        }
    }
}
