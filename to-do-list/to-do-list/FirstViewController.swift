//
//  FirstViewController.swift
//  to-do-list
//
//  Created by Nick Kazan on 2018-11-30.
//  Copyright © 2018 Nick Kazan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var list = ["Go to Grocery Store", "Grind for 2 hours", "Workout out"];
    let alert = UIAlertController(title: "Add an item", message: "", preferredStyle: .alert);
    
    
    @IBOutlet weak var tableList: UITableView!
    
    @IBAction func addItem(_ sender: Any) {
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        });
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0];
            print("Text field: \(textField?.text ?? "")")
            if (textField?.text?.count)! > 0 {
                self.list.append((textField?.text)!);
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
        cell.textLabel?.text = list[indexPath.row];
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
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

