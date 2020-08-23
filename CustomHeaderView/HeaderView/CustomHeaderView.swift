//
//  CustomTableHeaderView.swift
//  CustomHeaderView
//
//  Created by Shankar B S on 14/06/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

//MARK: Protocol to get reuse ID
public protocol Reuseable {
    static func ReuseID() -> String
}

//MARK: Protocol to make Views to rounded corners
protocol MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView)
    func maskBottomOnlyRoundedCorner(for view: UIView)
}

//MARK: default implementation for MaskedCorner protocol
extension MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func maskBottomOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}


class CustomHeaderView: UITableViewHeaderFooterView, MaskedCorner {
    
    // 1 - outlets
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskTopOnlyRoundedCorner(for: self.borderView)
    }
}

//Reusable protocol for views
extension CustomHeaderView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
