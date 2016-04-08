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

public class AsyncTableViewController: TableViewController, AsyncDataSourceDelegate {

    public var shouldPerformPullToRefresh: Bool { return true }

    public override var dataSource: DataSourceType! {
        didSet {
            let errorMessage = "This TableView requires a AsyncDataSource." +
                               "Maybe you should use TableViewController instead." +
                               "Also you don't have to create this dataSource, just use sectionsForTableView"

            guard let _ = self.dataSource as? AsyncDataSource else {
                fatalError(errorMessage)
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        var dataSource = AsyncDataSource(
            tableView: self.tableView,
            sections: self.sectionsForTableView()
        )

        dataSource.delegate = self

        defer { self.dataSource = dataSource }
        
        if self.shouldPerformPullToRefresh {

            self.refreshControl = UIRefreshControl()

            self.refreshControl?.addTarget(
                self,
                action: #selector(refreshControlValueDidChange),
                forControlEvents: .ValueChanged
            )

            self.refreshControl?.attributedTitle =
                NSAttributedString(string: "Pull Me..")

            self.refreshControl?.beginRefreshing()
            self.refreshControl?.endRefreshing()

            dataSource.pullToRefreshDidEnd = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.refreshControl?.attributedTitle =
                    NSAttributedString(string: "Pull Me..")

                weakSelf.refreshControl?.endRefreshing()
            }
        }
    }

    /**
     This method will be called before "pull to refresh"
     calls `loadData`
     */
    public func pullToRefreshWillStart() {

    }

    public func willLoadData() {}

    public func loadData(completed: () -> ()) {
        fatalError("Implementation is missing \(self.dynamicType)")
    }

    public func didLoadData() {}

    public func sectionsForTableView() -> [TableViewSectionType] {
        fatalError("Missing Implementation \(self.dynamicType)")
    }

    @objc private func refreshControlValueDidChange() {
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Loading..")
        pullToRefreshWillStart()
        self.dataSource.reloadData()
    }
}
