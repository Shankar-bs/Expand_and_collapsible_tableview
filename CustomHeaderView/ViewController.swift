//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Shankar B S on 14/06/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

struct Constants {
    static let stdCornerRadius: CGFloat = 12.0
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    //1
    lazy var collapsableViewModel: CollapsableViewModel = {
        CollapsableViewModel(with: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //2
        self.collapsableViewModel.collapsableDelegate = self
        registerViewsToTableView()
    }
    
    private func registerViewsToTableView() {
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier:CustomTableCell.ReuseID())
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomHeaderView.ReuseID())
        tableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomFooterView.ReuseID())
    }
}

//3
extension ViewController: CollapsableSectionDataSource {
    func numberOfCollapsableSection() -> Int {
        return 5
    }
}

//4
extension ViewController: CollapsableSectionDelegate {
    func reloadSectionAtIndexPath(indexPath: IndexPath) {
        self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    //5
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collapsableViewModel.isSectionCollapsedAt(index: section) {
            return 1
        } else {
            return  5 //  Int.random(in: 3...5)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.ReuseID())
        guard let customCell = cell as? CustomTableCell else { return UITableViewCell() }
        return customCell
    }
    
    //MARK: Section View Handling
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.ReuseID()) as? CustomHeaderView  else { return nil }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomFooterView.ReuseID()) as? CustomFooterView  else { return nil }
        //Make sure to set delegate
        footerView.delegate = self
        footerView.footerSection = section
        //6
        let isCollapsed = self.collapsableViewModel.isSectionCollapsedAt(index: section)
        footerView.updateFooterButton(isCollapsed: isCollapsed)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
}

extension ViewController: FooterViewDelegate {
    func viewMoreButtonTappedInFooter(view: CustomFooterView, inSection section: Int) {
        //Handle Action
        //7
        self.collapsableViewModel.collapseSectionAt(index: section)
        print("Handle Action for footer in section:\(section)")
    }
}
