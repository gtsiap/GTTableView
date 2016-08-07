//
//  Section.swift
//  GTDataSources
//
//  Created by Giorgos Tsiapaliokas on 07/08/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

public class Section<
    T,
    Cell: ViewCellType
where
    Cell.ModelType == T>: SectionType
{

    /**
     The items of this section
     */
    public var items: [T] = [T]()

    public var count: Int {
        return self.items.count
    }

    /**
     - parameter item: the current item of the section for which
     a cell identifier has been requested
     - parameter indexPath: the current indexPath
     - returns: returns the cell identifier that will be used
     for the cell reuse
     */
    public typealias CellIdentifierHandler = (item: T, indexPath: NSIndexPath) -> String
    public let cellIdentifierHandler: CellIdentifierHandler

    /**
     - parameter items: The items of this section
     - parameter cellIdentifierHandler: the cellIdentifierHandler handler
     */
    public required init(items: [T], cellIdentifierHandler: CellIdentifierHandler) {
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
    public convenience init(cellIdentifierHandler: CellIdentifierHandler) {
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
}
