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

/**
A generic Table View Controller.
This Controller **doesn't** support `pull to refresh`
*/
public class TableViewController: UITableViewController {
    /**
     The dataSource of the view controller
     */
    public var dataSource: DataSourceType!

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.sections.count
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.sections[section].count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionIndex = indexPath.section
        let section = self.dataSource.sections[sectionIndex]

        return section.cellForRowAtIndexPath(tableView, indexPath: indexPath)
    }

    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.dataSource.sections[section]
        return section.headerTitle
    }

    public override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = self.dataSource.sections[section]
        return section.footerTitle
    }
}
