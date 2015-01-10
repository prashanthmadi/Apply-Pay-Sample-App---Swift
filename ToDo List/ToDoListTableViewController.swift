//
//  ToDoListTableViewController.swift
//  ToDo List
//
//  Created by prashanth on 11/8/14.
//  Copyright (c) 2014 prashanth. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    let phonesList = ["iphone6","nexus6","iphone5","MotoX"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phonesList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text=phonesList[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let payMent  = ViewController(nibName:nil,bundle:nil)
        payMent.selectedPhone = phonesList[indexPath.row]
        self.navigationController?.pushViewController(payMent, animated: true)
    }


}
