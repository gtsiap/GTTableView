//
//  TableView.swift
//  GTTableView
//
//  Created by Giorgos Tsiapaliokas on 26/06/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

public class TableView<S: TableViewSectionType>: UITableView, UITableViewDataSource {
    private var sections = [S]()

    public var canEditRowAtIndexPath: (
        tableView: UITableView,
        indexPath: NSIndexPath) -> Bool =
    { (_, _) in
        return false
    }

    public var canMoveRowAtIndexPath: (
        tableView: UITableView,
        indexPath: NSIndexPath) -> Bool =
    { (_, _) in
        return false
    }

    public var moveRowAtIndexPath: (
        tableView: UITableView,
        sourceIndexPath: NSIndexPath,
        destinationIndexPath: NSIndexPath) -> () =
    { (_, _, _) in
    }

    public var commitEditingStyle: (
        tableView: UITableView,
        commitEditingStyle: UITableViewCellEditingStyle,
        indexPath: NSIndexPath) -> () =
    { (_, _, _) in
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Missing Implementation")
    }

    public init(sections: [S], style: UITableViewStyle) {
        super.init(frame: CGRectZero, style: style)
        commonInit(sections)
    }

    public init(section: S, style: UITableViewStyle) {
        super.init(frame: CGRectZero, style: style)
        commonInit([section])
    }

    private func commonInit(sections: [S]) {
        self.dataSource = self
        self.sections = sections
    }

    public func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.sections[section].count
    }

    public func tableView(
        tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        let section = self.sections[section]
        return section.headerTitle
    }

    public func tableView(
        tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        let section = self.sections[section]
        return section.footerTitle
    }

    public func tableView(
        tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath
    ) -> Bool {
        return self.canEditRowAtIndexPath(tableView: tableView, indexPath: indexPath)
    }

    public func tableView(
        tableView: UITableView,
        canMoveRowAtIndexPath indexPath: NSIndexPath
    ) -> Bool {
        return self.canMoveRowAtIndexPath(tableView: tableView, indexPath: indexPath)
    }

    public func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let sectionIndex = indexPath.section
        let section = self.sections[sectionIndex]
        return section.cellForRowAtIndexPath(tableView, indexPath: indexPath)
    }

    public func tableView(
        tableView: UITableView,
        moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath
    ) {
        self.moveRowAtIndexPath(
            tableView: tableView,
            sourceIndexPath: sourceIndexPath,
            destinationIndexPath: destinationIndexPath
        )
    }

    public func tableView(
        tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath
    ) {
        self.commitEditingStyle(
            tableView: tableView,
            commitEditingStyle: editingStyle,
            indexPath: indexPath
        )
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }

}
