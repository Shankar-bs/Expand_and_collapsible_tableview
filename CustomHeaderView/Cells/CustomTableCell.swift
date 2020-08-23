//
//  CustomTableCell.swift
//  CustomHeaderView
//
//  Created by Shankar B S on 14/06/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension CustomTableCell: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}

