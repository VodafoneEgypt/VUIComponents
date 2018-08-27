//
//  StatusConfirmationCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StatusConfirmationCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/LanguageHandler.h>
#import "UIColor+Hex.h"

@interface StatusConfirmationCardView (){
    
    __weak IBOutlet NSLayoutConstraint *ButtonWidthConstraint;
    __weak IBOutlet UILabel *textLabel;
    
    __weak IBOutlet NSLayoutConstraint *buttolRightPadding;
    __weak IBOutlet UIImageView *imageView;
    
}
@property (nonatomic) BOOL hideFlag;
@end

@implementation StatusConfirmationCardView

#pragma mark setter

- (void)setCustomButton:(CustomButton *)customButton{
    
    _customButton = customButton;
    buttolRightPadding.constant = 15;
    
    CGSize titleSize =
    [customButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]}];
    
    ButtonWidthConstraint.constant = (_buttonWidth)?_buttonWidth:titleSize.width + 25;
    [self layoutIfNeeded];
}

-(void)setButtonWidth:(float)buttonWidth{
    
    if (buttonWidth>0) {
        buttolRightPadding.constant = 15;

    }else{
        buttolRightPadding.constant = 0;

    }
    ButtonWidthConstraint.constant = buttonWidth;
    [self layoutIfNeeded];
    
}
-(void)setText:(NSString *)text{
    
    _text = text;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    textLabel.attributedText = attrStr1;
    
//    [self initialize];
}

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    imageView.image = image;
    
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    
    imageView.layer.masksToBounds = YES;
    
    imageView.layer.borderWidth = 0;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
//    contentViewHeight = 46;
//
//    CGFloat width = self.frame.size.width - 75;
//
//    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
//
//    CGRect rect = [textLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
//
//    contentViewHeight += rect.size.height;
}

-(void)hideAfterSec:(float)seconeds{
    
    _hideFlag = true;
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * seconeds);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        
        if (_hideFlag) {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self setAlpha:0];
            }];
        }

        
    });
}

-(void)removeAfterSec:(float)seconeds{
   
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * seconeds);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        
        [self removeFromSuperview];
    });
}

-(void)show{
    
    _hideFlag = false;
    [UIView animateWithDuration:0.5 animations:^{
        
        [self setAlpha:1];
    }];}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view ;
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL ) {
        
        view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"StatusConfirmationCardViewRTL" owner:self options:nil][0];
    }else{
        
        view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"StatusConfirmationCardView" owner:self options:nil][0];
    }
    
    self.bounds = view.frame;

    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    buttolRightPadding.constant = 0;
    ButtonWidthConstraint.constant = 0;
    _hideFlag = true;
    [self addSubview:view];
}

@end
