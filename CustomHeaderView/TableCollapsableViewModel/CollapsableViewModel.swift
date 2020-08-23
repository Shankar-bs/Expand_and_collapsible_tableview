//
//  CollapsableViewModel.swift
//  CustomHeaderFooterView
//
//  Created by Shankar B S on 22/08/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import Foundation

//1
protocol CollapsableSectionDataSource: AnyObject {
    func numberOfCollapsableSection() -> Int
}

//2
protocol CollapsableSectionDelegate: AnyObject {
    func reloadSectionAtIndexPath(indexPath: IndexPath)
}

public class CollapsableViewModel {
    
    //3
    private(set) var sectionMappers: [CollapsableSection] = []
    weak var collapsableDataSource: CollapsableSectionDataSource?
    weak var collapsableDelegate: CollapsableSectionDelegate?
    
    //4
    init(with collapsableViewDataSource: CollapsableSectionDataSource) {
        self.collapsableDataSource = collapsableViewDataSource
        setupSectionMappers()
    }
    
    private func setupSectionMappers() {
        let sectionsCount = self.collapsableDataSource?.numberOfCollapsableSection()
        guard let sections = sectionsCount, sections > 0 else { return }
        self.sectionMappers = (0..<sections).map({ (section) -> CollapsableSection in
            return CollapsableSection(withSection: section)
        })
    }
    
    //5
    public func isSectionCollapsedAt(index: Int) -> Bool {
        return self.sectionMappers[index].isCollapsed
    }
    
    //6
    public func collapseSectionAt(index: Int) {
        guard index < self.sectionMappers.count else { return }
        self.sectionMappers[index].toggleCollapseSection()
        let indexPath = IndexPath(row: 0, section: index)
        self.collapsableDelegate?.reloadSectionAtIndexPath(indexPath: indexPath)
    }
}
