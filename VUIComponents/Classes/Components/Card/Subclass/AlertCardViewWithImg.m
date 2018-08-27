//
//  AlertCardViewWithImg.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <VUIComponents/AlertCardViewWithImg.h>
#import "BaseCardView+Protected.h"
#import "KVNProgress.h"
//#import "CenterViewController.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface AlertCardViewWithImg(){
    BOOL isInitWithFrame;
}
    
    @property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertTitleLabel;
    @property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *alertImgView;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstraint;
    @property (weak, nonatomic) IBOutlet UIView *backgroundView;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewTop;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
    
    @end

@implementation AlertCardViewWithImg
    
#pragma mark setter
-(instancetype)initWithFrame:(CGRect)frame{
    isInitWithFrame = true;
    self = [super initWithFrame:frame];
    
    if(self){
        
        _alertImageTopConstraint = 70;
        _alertLabelTopConstraint = 30;
        
        UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"AlertCardViewWithImgWithFrame" owner:self options:nil] firstObject];
        
        self.bounds = view.frame;
        
        [self addSubview:view];
        
    }
    
    return self;
}
-(void)setAlertString:(NSString *)alertString {
    _alertString = alertString;
    _alertLabel.txt = alertString;
}

-(void)setAlertTitleString:(NSString *)alertTitleString {
    _alertTitleString = alertTitleString;
    _alertTitleLabel.text = alertTitleString;
    
    if ([alertTitleString isEqualToString:@""]) {
        _titleLabelHeightConstraint.constant = 0;
    } else {
        _titleLabelTopConstraint.constant = 80;
        _titleLabelHeightConstraint.constant = 40;
    }
}
    
-(void)setAlertText:(NSAttributedString *)alertText {
    _alertText = alertText;
    _alertLabel.attributedText = alertText;
}
    
-(void)setAlertTitleAttributedText:(NSAttributedString *)alertTitleAttributedText {
    _alertTitleAttributedText = alertTitleAttributedText;
    _alertTitleLabel.attributedText = alertTitleAttributedText;
    
    if ([alertTitleAttributedText.string isEqualToString:@""]) {
        _titleLabelHeightConstraint.constant = 0;
    } else {
        _titleLabelTopConstraint.constant = 80;
        _titleLabelHeightConstraint.constant = 40;
    }
}
    
-(void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;
    _alertImgView.image = alertImage;
}
    
-(void)setAlertImageSize:(CGSize)alertImageSize{
    _alertImageSize  = alertImageSize;
    _imageHeight.constant = alertImageSize.height;
    _imageWidth.constant = alertImageSize.width;
}
    
-(void)setAlertImageTopConstraint:(float)alertImageTopConstraint{
    _alertImageTopConstraint = alertImageTopConstraint;
    _imageTopConstraint.constant = alertImageTopConstraint;
}
    
-(void)setAlertLabelTopConstraint:(float)alertLabelTopConstraint {
    _alertLabelTopConstraint = alertLabelTopConstraint;
    _lableTopConstraint.constant = alertLabelTopConstraint;
}
    
-(void)setImageWithCornerRadius:(CGFloat)radius {
    _alertImgView.layer.cornerRadius = radius;
}
-(void)showBackgroundView:(BOOL)show{
    [self.backgroundView setHidden:!show];
}
-(void)setBackgroundViewTopConstraint:(float)constraint{
    self.backgroundViewTop.constant = constraint;
}
    
-(void)commonInit{
    if(!isInitWithFrame){
        _alertImageTopConstraint = 70;
        _alertLabelTopConstraint = 30;
        
        UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"AlertCardViewWithImg" owner:self options:nil] firstObject];
        
        self.bounds = view.frame;
        
        [self addSubview:view];
    }
    
}
    
    @end
