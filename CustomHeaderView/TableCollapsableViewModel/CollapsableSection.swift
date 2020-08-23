//
//  CollapsableSection.swift
//  CustomHeaderFooterView
//
//  Created by Shankar B S on 23/08/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import Foundation

struct CollapsableSection {
    private(set) var sectionIndexPath: Int
    private(set) var isCollapsed: Bool
    
    init(withSection indexPath: Int, isCollapsed: Bool = false) {
        self.sectionIndexPath = indexPath
        self.isCollapsed = isCollapsed
    }
    
    mutating func toggleCollapseSection() {
        self.isCollapsed.toggle()
    }
}
