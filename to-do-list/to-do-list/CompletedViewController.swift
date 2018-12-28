//
//  CompletedViewController.swift
//  to-do-list
//
//  Created by Nick Kazan on 2018-12-28.
//  Copyright © 2018 Nick Kazan. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableList2: UITableView!
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    let defaults = UserDefaults.standard;
    var completeTasks = [FirstViewController.Item]();
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1;
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeTasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("TEST")
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellCompleted");
        cell.textLabel?.text = (completeTasks[indexPath.row]).title;
        cell.backgroundColor = UIColor (red: 0.18, green: 0.71, blue: 1.0, alpha: 1.0);
        return cell;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableList2.delegate = self
        tableList2.dataSource = self
        //Completed Tasks
        guard let data = UserDefaults.standard.data(forKey: "completeTasks") else {
            self.completeTasks = []
            return
        }
        do {
            self.completeTasks = try JSONDecoder().decode([FirstViewController.Item].self, from: data)
        } catch {
            print(error)
            self.completeTasks = []
        }
    }
}
