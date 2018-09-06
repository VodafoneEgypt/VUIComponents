//
//  ExpandableBaseCard.swift
//  Ana Vodafone
//
//  Created by Fadwa Zaghloul on 8/8/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import UIKit

class FadwaExpandableBaseCardView: FadwaBaseCardView {
    
    @IBOutlet weak var expandedViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expandedView: UIView!
    
    var isViewExpanded: Bool!
    
    override func commonInit() {
        isViewExpanded = false
    }
    
    override func initialize() {
        
        expandedView.isHidden = !isViewExpanded

        if !isViewExpanded {
            expandedViewHeightConstraint.constant = 0;
        }
    }
    
    func performExpandingAnimation() {
        isViewExpanded = !isViewExpanded
        initialize()

    }

}
