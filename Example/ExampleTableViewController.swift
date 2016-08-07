//
//  TableViewController.swift
//  GTTableViewExample
//
//  Created by Giorgos Tsiapaliokas on 26/06/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit
import GTDataSources

class ColoredTableViewCell: BaseTableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureCell(model: String) {
        super.configureCell(model)

        self.detailTextLabel?.text = "This cell has red background"
    }
}

class ExampleTableViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        let items = [
            "One", "two", "three", "four", "five", "six"
        ]

        let section1 = TableViewSection<String, BaseTableViewCell>(items: items)
        section1.headerTitle = "Section 1"

        let section2 = TableViewSection<String, BaseTableViewCell>(items: items)
        { item, indexPath -> String in
            if indexPath.row % 2 == 0 {
                return "myCell2"
            }

            return "myCell"
        }
        section2.headerTitle = "Section 2"
        section2.footerTitle = "Footer"

        let tableView = TableView(sections: [section1, section2], style: .Plain)
        tableView.registerClass(BaseTableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.registerClass(ColoredTableViewCell.self, forCellReuseIdentifier: "myCell2")

        self.view.addSubview(tableView)

        tableView.frame = self.view.frame

        tableView.reloadData()
    }

}
