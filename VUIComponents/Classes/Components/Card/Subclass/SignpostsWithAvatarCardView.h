//
//  SignpostsWithAvatarView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableBaseCardView.h"

typedef void(^TargetBlock)(void);
IB_DESIGNABLE
@interface SignpostsWithAvatarCardView : ExpandableBaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;
    
    __weak IBOutlet UIView *verticalLineView;
    
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet UILabel *subTitleLabel;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    
    __weak IBOutlet UIButton *viewButton;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@property (nonatomic, strong) NSArray* buttons;

@property (nonatomic) IBInspectable BOOL verticalLine;

@property (nonatomic,strong)IBInspectable NSString* title;

@property (nonatomic,strong) IBInspectable NSString* subTitle;

@property (strong ,nonatomic) TargetBlock targetBlock;

@property(nonatomic,strong) IBInspectable NSString* secondTitle;

@property(nonatomic,strong) IBInspectable UIImage* avatarImage;

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) IBInspectable BOOL isExpandable;

@property (nonatomic) IBInspectable BOOL withoutCircleImage;

-(void)setSecondTitle:(NSString *)secondTitle WithFontSize:(int)fontSize;

-(void)setSubTitle:(NSString *)subTitle WithFontSize:(int)fontSize;

-(void)setTitle:(NSString *)title WithFontSize:(int)fontSize;

-(void)setSubTitleLabelAdjustsFontSizeToFitWidth:(Boolean)F andNumberOfLine:(NSInteger)N;

@end
