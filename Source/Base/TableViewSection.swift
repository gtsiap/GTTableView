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
 It provides a section which can have multiple cell identifiers.
*/
open class TableViewSection<
    T,
    Cell: TableViewCellType>: TableViewSectionType
    where Cell.ModelType == T,
    Cell: UITableViewCell {

    /**
     The items of this section
     */
    open var items: [T] = [T]()

    open var headerTitle: String?
    open var footerTitle: String?

    open var count: Int {
        return self.items.count
    }

    /**
     - parameter item: the current item of the section for which
                       a cell identifier has been requested
     - parameter indexPath: the current indexPath
     - returns: returns the cell identifier that will be used
                for the cell reuse
     */
    public typealias CellIdentifierHandler = (_ item: T, _ indexPath: IndexPath) -> String
    open let cellIdentifierHandler: CellIdentifierHandler

    /**
     - parameter items: The items of this section
     - parameter cellIdentifierHandler: the cellIdentifierHandler handler
     */
    public init(items: [T], cellIdentifierHandler: @escaping CellIdentifierHandler) {
        self.items = items
        self.cellIdentifierHandler = cellIdentifierHandler
    }

    /**
     A convenience initializer which sets **myCell** as the cell reuse identifier
     */
    public convenience init(items: [T]) {
        self.init(items: items) { (_, _) -> String in
            return "myCell"
        }
    }

    /**
     A convenience initializer which sets an empty list for items.
     */
    public convenience init(cellIdentifierHandler: @escaping CellIdentifierHandler) {
        self.init(items: [T](), cellIdentifierHandler: cellIdentifierHandler)
    }

    /**
     A convenience initializer which sets **myCell**
     as the cell reuse identifier and it sets an
     empty list for items.
     */
    public convenience init() {
        self.init(items: [T]()) { (_, _) -> String in
            return "myCell"
        }
    }

    open func cellForRowAtIndexPath(
        _ tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        let rowIndex = (indexPath as NSIndexPath).row

        let item = self.items[rowIndex]

        let cellIdentifier = self.cellIdentifierHandler(item, indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        cell.configureCell(item)

        return cell
    }
}
