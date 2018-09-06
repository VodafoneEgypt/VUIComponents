//
//  FadwaSimpleTextCardView.swift
//  Ana Vodafone
//
//  Created by Fadwa Zaghloul on 8/9/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import UIKit

class FadwaSimpleTextCardView: FadwaBaseCardView {
    
    @IBOutlet weak var txtLbl: UILabel!
    
    override func commonInit() {
        super.commonInit()
        
        let view: UIView = Bundle.main.loadNibNamed("FadwaSimpleTextCardView", owner: self, options: nil)![0] as! UIView
        self.bounds = view.frame

        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        self.addSubview(view)
        contentViewHeight = self.frame.height        
    }
    
    func setSimpleCardText(simpleCardText: String) {
        
        let fontFamily = LanguageHandler.sharedInstance().string(forKey: "regularFont")
        let currentDirection = LanguageHandler.sharedInstance().currentDirection
        let attributedTxt = makeAttributedText(txt: simpleCardText, lineSpacing: 5, currentDirection: currentDirection , fontFamily: fontFamily!, fontSize: 16, fontColorHex: "#333333")
        
        txtLbl?.attributedText = attributedTxt
        
    }

}
