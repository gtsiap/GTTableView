//
//  FetchMoreTableViewController.swift
//  GTTableView
//
//  Created by Giorgos Tsiapaliokas on 03/01/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

public class DefaultFetchMoreActivityIndicator: UIActivityIndicatorView {
    public override func didMoveToSuperview() {
        self.activityIndicatorViewStyle = .WhiteLarge
        self.color = UIColor.blackColor()
        self.startAnimating()
    }
}

public class FetchMoreTableViewController: AsyncTableViewController {
    private enum FetchingState {
        case Starting
        case Started
        case Fetching
        case NotFetching
    }
    private var fetchingState: FetchingState = .NotFetching

    /**
     This view will be used as an indicator.
     If `fetchΜοreActivityIndicator` is nil then a
     default instance of `DefaultFetchMoreActivityIndicator`
     will be used
     */
    public var fetchΜοreActivityIndicator: UIView?

    /**
     Fetch your new data here.
     - NOTE: You are responsible for adding the new data to your section
     - parameter finished: It must be called when the operation finishes
     */
    public func fetchMore(finished: (animation: UITableViewRowAnimation, newItemsCount: Int) -> ()) {
        fatalError("Missing Implementation")
    }

    override public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        guard case .Starting = self.fetchingState else {
            print(self.fetchingState)
            print("return")
            return
        }

        self.fetchingState = .Fetching

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

        let sectionIndex = indexPath.section

        fetchMore() { (animation, newItemsCount) in
            defer {
                self.tableView.tableFooterView = nil
                self.fetchingState = .NotFetching
            }

            if newItemsCount == 0 {
                print("zero items have been added")
                return
            }

            var newIndexPaths = [NSIndexPath]()

            let currentRow = indexPath.row
            for index in 1...newItemsCount {
                // If we had 25 rows and if we are in the first
                // loop, then we have:
                // 25 old rows
                // and the index is 1
                // so the position of the new index is 26 which equals to 26 = (25 + 1)
                let newRow = currentRow + index
                newIndexPaths.append(NSIndexPath(forRow: newRow, inSection: sectionIndex))
            }

            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(newIndexPaths, withRowAnimation: animation)
            self.tableView.endUpdates()
        }
    }

    override public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {

        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            // we have reached bottom
            if case .NotFetching = self.fetchingState {
                self.fetchingState = .Starting
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
