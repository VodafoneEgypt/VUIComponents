//
//  ConfirmationAlertCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ConfirmationAlertCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/LanguageHandler.h>
#import "UIColor+Hex.h"
#import <VUIComponents/AnaVodafoneLabel.h>
#import <VUIComponents/Utilities.h>

@interface ConfirmationAlertCardView ()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@end

@implementation ConfirmationAlertCardView

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLabel.text = titleText;
    
    [self layoutIfNeeded];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    
    _attributedText = attributedText;
    
    CGFloat width = self.frame.size.width - 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    contentViewHeight = 40;
    
    contentViewHeight += rect.size.height;
    
    _titleLabel.attributedText = attributedText;
    
    [self initialize];
}

#pragma mark height adjustment
-(void)initializeContentView{
    
        contentViewHeight = 30;
    
        CGFloat width = self.frame.size.width - 30;
    
        CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
        CGRect rect = [_titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
        contentViewHeight += rect.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle] loadNibNamed:@"ConfirmationAlertCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}


@end
