//
//  SectionType.swift
//  GTDataSources
//
//  Created by Giorgos Tsiapaliokas on 07/08/16.
//  Copyright © 2016 Giorgos Tsiapaliokas. All rights reserved.
//

public protocol SectionType {
    associatedtype T

    var cellIdentifierHandler: (item: T, indexPath: NSIndexPath) -> String { get }

    /**
     The items of this section
     */
    var items: [T] { get set }

    /**
     The number of items for this section
     */
    var count: Int { get }
}