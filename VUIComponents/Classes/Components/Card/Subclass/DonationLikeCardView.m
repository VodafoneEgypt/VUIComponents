//
//  DonationLikeCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/30/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "DonationLikeCardView.h"
#import "BaseCardView+Protected.h"
#import "LanguageHandler.h"
#import "UIColor+Hex.h"
#import "SignpostCardView.h"

@interface DonationLikeCardView(){

    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UILabel *descLabel;
    
    __weak IBOutlet SignpostCardView *signpostCardView;
    
    __weak IBOutlet NSLayoutConstraint *signpostCardViewHeight;
}

@end

@implementation DonationLikeCardView

#pragma mark setter
-(void)setTargetBlock:(TargetBlock)targetBlock{
    
    _targetBlock = targetBlock;
    
    signpostCardView.targetBlock = targetBlock;
}

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:28], NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[LanguageHandler sharedInstance] stringForKey:title]] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
}

-(void)setDesc:(NSString *)desc{
    
    _desc = desc;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18], NSForegroundColorAttributeName:[UIColor colorWithCSS:@"aaaaaa"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[LanguageHandler sharedInstance] stringForKey:desc]] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    descLabel.attributedText = attrStr1;
}

-(void)setShowMoreText:(NSString *)showMoreText{
    
    _showMoreText = showMoreText;
    
    signpostCardView.title = showMoreText;
}
-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    imageView.image = image;
}


-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"DonationLikeCardView" owner:self options:nil] firstObject];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
}

@end
