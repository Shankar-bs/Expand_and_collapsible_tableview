//
//  CustomFooterView.swift
//  CustomHeaderView
//
//  Created by Shankar B S on 14/06/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

protocol FooterViewDelegate: AnyObject {
    func viewMoreButtonTappedInFooter(view: CustomFooterView, inSection section: Int)
}

class CustomFooterView: UITableViewHeaderFooterView, MaskedCorner {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var viewMoreButton: UIButton!
    weak var delegate: FooterViewDelegate?
    var footerSection: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskBottomOnlyRoundedCorner(for: self.borderView)
    }
    
    func updateFooterButton(isCollapsed: Bool) {
        let footerBottonTitle = isCollapsed ? "Show more" : "Show less"
        self.viewMoreButton.setTitle(footerBottonTitle, for: .normal)
    }
    
    
    @IBAction func viewMoreButtonAction(_ sender: Any) {
        self.delegate?.viewMoreButtonTappedInFooter(view: self, inSection: footerSection)
    }
}

extension CustomFooterView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}

