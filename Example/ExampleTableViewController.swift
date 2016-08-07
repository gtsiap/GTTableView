// Copyright (c) 2016 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
