// Copyright (c) 2015 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
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
import GTTableView

class BaseTableViewCell: UITableViewCell, TableViewCellType {

    func configureCell(model: String) {
        self.textLabel?.text = model
    }
}

class StaticTableViewCell: BaseTableViewCell {}

class ColoredStaticTableViewCell: BaseTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.redColor()
    }

    override func configureCell(model: String) {
        super.configureCell(model)

        self.detailTextLabel?.text = "This cell has red background"
    }
}

class ViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [
            "Reddit",
            "Dummy cell"
        ]

        let section = TableViewSection<String, BaseTableViewCell>(items: items)
        { (item, indexPath) -> String in
            if indexPath.row == 0 {
                return "myCell"
            }

            return "myCell2"
        }

        section.headerTitle = "A reddit Table View Controller"
        section.footerTitle = "Footer"

        self.dataSource = DataSource(tableView: self.tableView, sections: [section])
        self.dataSource.reloadData()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("goToReddit", sender: self)
    }
}

