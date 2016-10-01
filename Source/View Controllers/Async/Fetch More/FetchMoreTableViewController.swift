//
//  FetchMoreTableViewController.swift
//  GTTableView
//
//  Created by Giorgos Tsiapaliokas on 03/01/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

open class DefaultFetchMoreActivityIndicator: UIActivityIndicatorView {
    open override func didMoveToSuperview() {
        self.activityIndicatorViewStyle = .whiteLarge
        self.color = UIColor.black
        self.startAnimating()
    }
}

open class FetchMoreTableViewController: AsyncTableViewController {
    private enum FetchingState {
        case starting
        case started
        case fetching
        case notFetching
    }
    private var fetchingState: FetchingState = .notFetching

    /**
     This view will be used as an indicator.
     If `fetchΜοreActivityIndicator` is nil then a
     default instance of `DefaultFetchMoreActivityIndicator`
     will be used
     */
    open var fetchΜοreActivityIndicator: UIView?

    /**
     Fetch your new data here.
     - NOTE: You are responsible for adding the new data to your section
     - parameter finished: It must be called when the operation finishes
     */
    open func fetchMore(_ finished: @escaping (_ animation: UITableViewRowAnimation, _ newItemsCount: Int) -> ()) {
        fatalError("Missing Implementation")
    }

    override open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard case .starting = self.fetchingState else {
            print(self.fetchingState)
            print("return")
            return
        }

        self.fetchingState = .fetching

        if let indicator = self.fetchΜοreActivityIndicator {
            self.tableView.tableFooterView = indicator
        } else {
            let size = self.tableView.bounds.height * 0.2
            let rect = CGRect(x: 0, y: 0, width: size, height: size)
            let indicator = DefaultFetchMoreActivityIndicator(frame: rect)
            self.tableView.tableFooterView = indicator
        }

        guard let
            indexPath = self.tableView.indexPathsForVisibleRows?.last
        else { return }

        let sectionIndex = (indexPath as NSIndexPath).section

        fetchMore() { (animation, newItemsCount) in
            defer {
                self.tableView.tableFooterView = nil
                self.fetchingState = .notFetching
            }

            if newItemsCount == 0 {
                print("zero items have been added")
                return
            }

            var newIndexPaths = [IndexPath]()

            let currentRow = (indexPath as NSIndexPath).row
            for index in 1...newItemsCount {
                // If we had 25 rows and if we are in the first
                // loop, then we have:
                // 25 old rows
                // and the index is 1
                // so the position of the new index is 26 which equals to 26 = (25 + 1)
                let newRow = currentRow + index
                newIndexPaths.append(IndexPath(row: newRow, section: sectionIndex))
            }

            self.tableView.beginUpdates()
            self.tableView.insertRows(at: newIndexPaths, with: animation)
            self.tableView.endUpdates()
        }
    }

    override open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            // we have reached bottom
            if case .notFetching = self.fetchingState {
                self.fetchingState = .starting
            }
        } else {
            return
        }

        if let indicator = self.fetchΜοreActivityIndicator {
            self.tableView.tableFooterView = indicator
        } else {
            let size = self.tableView.bounds.height * 0.2
            let rect = CGRect(x: 0, y: 0, width: size, height: size)
            let indicator = DefaultFetchMoreActivityIndicator(frame: rect)
            self.tableView.tableFooterView = indicator
        }
    }

}
