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
import GTTableView

class RedditTableViewController: FetchMoreTableViewController {

    private var threadsSection = TableViewSection<Thread, ThreadTableViewCell>()
    private var lastThreadType: ThreadType?
    private let controller = RedditController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadData(_ completed: @escaping () -> ()) {
        let threadType: ThreadType

        if let
            selectedIndex = self.tableView.indexPathForSelectedRow
        {
            switch selectedIndex.row {
            case 0:
                threadType = .Hot
            case 1:
                threadType = .Top
            default:
                threadType = .New
            }

            self.lastThreadType = threadType
        } else if let lastThreadType = self.lastThreadType {
            threadType = lastThreadType
        } else {
            return
        }

        controller.fetchThreads(threadType: threadType) { threads in
            self.threadsSection.items = threads
            completed()
        }
    }

    override func sectionsForTableView() -> [TableViewSectionType] {
        let staticSection = TableViewSection<String, StaticTableViewCell>()
        { (item, indexPath) -> String in
            return "staticCell"
        }

        staticSection.items = [
            "Hot", "Top", "New"
        ]

        staticSection.headerTitle = "Please select one"

        return [
            staticSection,
            self.threadsSection
        ]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataSource.reloadData()
    }

    override func fetchMore(_ finished: @escaping (_ animation: UITableViewRowAnimation, _ newItemsCount: Int) -> ()) {
        guard let
            after = self.threadsSection.items.last?.after
        else {
            finished(.fade, 0)
            return
        }

        controller.fetchMoreThreads(threadType: self.lastThreadType!, after: after) { threads in
            threads.forEach() { self.threadsSection.items.append($0) }
            finished(.fade, threads.count)
        }
    }
}
