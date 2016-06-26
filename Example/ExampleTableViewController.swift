//
//  TableViewController.swift
//  GTTableViewExample
//
//  Created by Giorgos Tsiapaliokas on 26/06/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit
import GTTableView

class ExampleTableViewController: UIViewController {
    let section = TableViewSection<String, BaseTableViewCell>(items: [
        "One", "two", "three", "four", "five", "six"
    ])


    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = TableView(section: self.section, style: .Plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(BaseTableViewCell.self, forCellReuseIdentifier: "myCell")

        self.view.addSubview(tableView)

        tableView.frame = self.view.frame

        tableView.reloadData()
    }

}
