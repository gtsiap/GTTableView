//
//  TableView.swift
//  GTTableView
//
//  Created by Giorgos Tsiapaliokas on 26/06/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

open class TableView: UITableView, UITableViewDataSource {
    private var tableViewDataSource: DataSourceType!

    open var canEditRowAtIndexPath: (
        _ tableView: UITableView,
        _ indexPath: IndexPath) -> Bool =
    { (_, _) in
        return false
    }

    open var canMoveRowAtIndexPath: (
        _ tableView: UITableView,
        _ indexPath: IndexPath) -> Bool =
    { (_, _) in
        return false
    }

    open var moveRowAtIndexPath: (
        _ tableView: UITableView,
        _ sourceIndexPath: IndexPath,
        _ destinationIndexPath: IndexPath) -> () =
    { (_, _, _) in
    }

    open var commitEditingStyle: (
        _ tableView: UITableView,
        _ commitEditingStyle: UITableViewCellEditingStyle,
        _ indexPath: IndexPath) -> () =
    { (_, _, _) in
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Missing Implementation")
    }

    public init(sections: [TableViewSectionType], style: UITableViewStyle) {
        super.init(frame: CGRect.zero, style: style)
        commonInit(sections)
    }

    public init(section: TableViewSectionType, style: UITableViewStyle) {
        super.init(frame: CGRect.zero, style: style)
        commonInit([section])
    }

    private func commonInit(_ sections: [TableViewSectionType]) {
        self.tableViewDataSource = DataSource(tableView: self, sections: sections)
        self.dataSource = self
    }

    open func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.tableViewDataSource.sections[section].count
    }

    open func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        let section = self.tableViewDataSource.sections[section]
        return section.headerTitle
    }

    open func tableView(
        _ tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        let section = self.tableViewDataSource.sections[section]
        return section.footerTitle
    }

    open func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        return self.canEditRowAtIndexPath(tableView, indexPath)
    }

    open func tableView(
        _ tableView: UITableView,
        canMoveRowAt indexPath: IndexPath
    ) -> Bool {
        return self.canMoveRowAtIndexPath(tableView, indexPath)
    }

    open func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let sectionIndex = (indexPath as NSIndexPath).section
        let section = self.tableViewDataSource.sections[sectionIndex]

        return section.cellForRowAtIndexPath(tableView, indexPath: indexPath)
    }

    open func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        self.moveRowAtIndexPath(
            tableView,
            sourceIndexPath,
            destinationIndexPath
        )
    }

    open func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCellEditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        self.commitEditingStyle(
            tableView,
            editingStyle,
            indexPath
        )
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewDataSource.sections.count
    }

}
