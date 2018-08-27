//
//  AddonAlertCardView.m
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 8/3/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "AddonAlertCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface AddonAlertCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;

@end

@implementation AddonAlertCardView

#pragma mark setter

-(void)setAlertText:(NSString *)alertText {
    _alertText = alertText;
    _alertLabel.txt = alertText;
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    _alertLabel.attributedText = attributedText;
}

-(void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;    
    _alertImgView.image = alertImage;
}

-(void)commonInit{
        
    UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"AddonAlertCardView" owner:self options:nil] firstObject];
    
    self.bounds = view.frame;
        
    [self addSubview:view];
}

@end
