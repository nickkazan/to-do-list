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
    var list = [Item]();
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
                let item = Item(title: (textField?.text)!, completed: true);
                self.list.append(item);
                do {
                    let itemData = try JSONEncoder().encode(self.list)
                    UserDefaults.standard.set(itemData, forKey: "list")
                } catch {
                    print(error)
                }
                self.tableList.reloadData();
            }
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell");
        cell.textLabel?.text = (list[indexPath.row]).title;
        cell.backgroundColor = UIColor (red: 0.18, green: 0.71, blue: 1.0, alpha: 1.0);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.list.remove(at: indexPath.row);
            tableList.reloadData();
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = UserDefaults.standard.data(forKey: "list") else {
            self.list = []
            return
        }
        do {
            self.list = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print(error)
            self.list = []
        }
    }
}
