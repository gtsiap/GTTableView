// Copyright (c) 2015-2016 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
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
open class TableViewController: UITableViewController {
    /**
     The dataSource of the view controller
     */
    open var dataSource: DataSourceType!

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.sections.count
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.sections[section].count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = (indexPath as NSIndexPath).section
        let section = self.dataSource.sections[sectionIndex]

        return section.cellForRowAtIndexPath(tableView, indexPath: indexPath)
    }

    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.dataSource.sections[section]
        return section.headerTitle
    }

    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = self.dataSource.sections[section]
        return section.footerTitle
    }
}
