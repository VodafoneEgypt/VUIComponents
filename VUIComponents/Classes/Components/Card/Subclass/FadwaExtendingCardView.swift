//
//  FadwaExtendingCardView.swift
//  Ana Vodafone
//
//  Created by Fadwa Zaghloul on 8/9/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import UIKit

class FadwaExtendingCardView: FadwaExpandableBaseCardView {
    
    @IBOutlet fileprivate weak var extendingCardView: UIView!
    
    @IBOutlet fileprivate weak var cardArrow: UIImageView!
    
    @IBOutlet fileprivate weak var horizontalSeperatorView: UIView!
    
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    
    @IBOutlet fileprivate weak var subtitleLbl: UILabel!
    
    @IBOutlet fileprivate weak var descriptionTxtCardView: FadwaSimpleTextCardView!
    
    @IBOutlet fileprivate weak var verticalLine: UIView!
    
    override func commonInit() {
        super.commonInit()
        
        let view: UIView = Bundle.main.loadNibNamed("FadwaExtendingCardView", owner: self, options: nil)![0] as! UIView
        self.bounds = view.frame
        
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self.addSubview(view)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(expandCard))
        extendingCardView.addGestureRecognizer(gesture)
        
        horizontalSeperatorView.isHidden = true
        contentViewHeight = extendingCardView.frame.height
        
        print("ContentViewHeight: \(extendingCardView.frame.height)")

        initialize()
    }
    
    @objc fileprivate func expandCard(sender : UITapGestureRecognizer) {
        
        expandedViewHeightConstraint.constant = descriptionTxtCardView.contentViewHeight
    
        print("ContentViewHeight: \(descriptionTxtCardView.contentViewHeight!)")
        print("ContentViewHeight: \(descriptionTxtCardView.txtLbl.frame.height)")

        performExpandingAnimation()
        
//        Change Arrow Image
        if isViewExpanded {
            cardArrow.image = UIImage.init(named: "chevron-up-arrow")
            horizontalSeperatorView.isHidden = false
        
        } else {
            cardArrow.image = UIImage.init(named: "chevron-down-arrow")
            horizontalSeperatorView.isHidden = true

        }
    }
    
    func setExtendingCardTitle(extendingCardTitle: String) {
        
        let fontFamily = LanguageHandler.sharedInstance().string(forKey: "regularFont")
        let currentDirection = LanguageHandler.sharedInstance().currentDirection
        let attributedTxt = makeAttributedText(txt: extendingCardTitle, lineSpacing: 4, currentDirection: currentDirection , fontFamily: fontFamily!, fontSize: 20, fontColorHex: "#333333")
        
        titleLbl?.attributedText = attributedTxt
    }
    
    
    func setExtendingCardSubtitle(extendingCardSubtitle: String) {
        
        let fontFamily = LanguageHandler.sharedInstance().string(forKey: "regularFont")
        let currentDirection = LanguageHandler.sharedInstance().currentDirection
        let attributedTxt = makeAttributedText(txt: extendingCardSubtitle, lineSpacing: 5, currentDirection: currentDirection , fontFamily: fontFamily!, fontSize: 16, fontColorHex: "#333333")
        
        subtitleLbl?.attributedText = attributedTxt
    }
    
    func setExtendingCardDescription(extendingCardDescription: String) {
        
        descriptionTxtCardView?.setSimpleCardText(simpleCardText: extendingCardDescription)
    }
    
}
