//
//  FadwaBaseCardView.swift
//  Ana Vodafone
//
//  Created by Fadwa Zaghloul on 8/8/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import UIKit

class FadwaBaseCardView: UIView {

    var contentViewHeight: CGFloat!
    
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        clipsToBounds = true
    }
    
    //    TODO
    func initialize() {
        initializeContentView()
    }
    
    func initializeContentView() {
        contentViewHeight = 0;
        contentView.isHidden = true;
    }
    
    func makeAttributedText(txt: String, lineSpacing: CGFloat, currentDirection: DirectionType, fontFamily: String, fontSize: CGFloat, fontColorHex: String) -> NSMutableAttributedString {
        
        let txtStyle = NSMutableParagraphStyle()
        txtStyle.lineSpacing = lineSpacing
        
        if currentDirection == RTL {
            txtStyle.alignment = NSTextAlignment.right
            
        } else {
            txtStyle.alignment = NSTextAlignment.left
        }
        
        var txtAttributes = [NSAttributedStringKey : Any]()
        txtAttributes = [
            NSAttributedStringKey.font: UIFont.init(name: LanguageHandler.sharedInstance().string(forKey: fontFamily), size: fontSize) as Any,
            NSAttributedStringKey.foregroundColor: UIColor.init(hexString: fontColorHex)]
        
        let attributedTxt = NSMutableAttributedString.init(string: txt, attributes: txtAttributes)
        attributedTxt.addAttribute(NSAttributedStringKey.paragraphStyle, value: txtStyle, range:NSMakeRange(0, attributedTxt.length))
        
        return attributedTxt
    }

    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.35
    }
}
