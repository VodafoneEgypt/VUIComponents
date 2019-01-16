//
//  ScratchCardView.m
//  Ana Vodafone
//
//  Created by Taha on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "ScratchCardView.h"
#import "BaseCardView+Protected.h"
#import "HexColor.h"
#import "AnaVodafoneLabel.h"
#import <Languagehandlerpod/LanguageHandler.h>

@interface ScratchCardView ()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dropDownImageView;
@property (weak, nonatomic) IBOutlet UITextField *scratchCardTextField;
@property (weak, nonatomic) IBOutlet CustomButton *rechargeBtn;

@end

@implementation ScratchCardView

- (IBAction)expandAction:(id)sender {
    
    [_scratchCardTextField resignFirstResponder];
    
    if (_expandActionBlock)
    {
        _expandActionBlock();
    }else
    {
    self.expanded = !self.expanded;
    }
    [self initialize];
}

#pragma mark setter

-(void)setExpanded:(BOOL)expanded{
    
    _dropDownImageView.transform = (expanded == true) ? CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    _dropDownImageView.hidden = (expanded == true) ? true:false;

    contentView.backgroundColor = (expanded == true) ? [UIColor colorWithHexString:@"F4F4F4"] : [UIColor whiteColor];
    
    [super setExpanded:expanded];
    [self setTitleString:_titleString];
    
}

- (void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:(self.expanded == true)?@"boldFont":@"regularFont"] size:16];
    _titleLabel.textColor = (self.expanded == true)? [UIColor purpleColor]:[UIColor
                                                                            colorWithHexString:@"333333"];
    _titleLabel.text = _titleString;
    [self initialize];
}

-(void)setScratchCardString:(NSString *)scratchCardString{
    
    _scratchCardTextField.text = scratchCardString;
}

-(void)setscratchCardTextFieldPlaceholder:(NSString *)scratchCardTextFieldPlaceholder{
    
    _scratchCardTextField.placeholder = scratchCardTextFieldPlaceholder;
}

-(NSString *)scratchCardString{
    
    return _scratchCardTextField.text;
}

-(void)setRechargeBtnString:(NSString *)rechargeBtnString{
    
    _rechargeBtnString = rechargeBtnString;
    
    _rechargeBtn.txt = rechargeBtnString;
}

-(void)setScratchCardTextFieldPlaceholder:(NSString *)scratchCardTextFieldPlaceholder{
    
    _scratchCardTextFieldPlaceholder = scratchCardTextFieldPlaceholder;
 
    _scratchCardTextField.placeholder = scratchCardTextFieldPlaceholder;
}

- (IBAction)scanCardAction:(id)sender {
    
    if (_scanCardActionBlock) {
        
        [_scratchCardTextField resignFirstResponder];

        _scanCardActionBlock();
    }
}

- (IBAction)rechargeAction:(id)sender {
    
    [_scratchCardTextField resignFirstResponder];

    if (_rechargeActionBlock) {
        _rechargeActionBlock();
    }
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    [_rechargeBtn layoutIfNeeded];
    
    if ([_titleString length] > 0) {
        
        [_titleLabel adjustHeight];
        
        contentViewHeight += 45;
        contentViewHeight += _titleLabel.frame.size.height;
    }
}

- (void)initializeExpandedView{
    
    if (self.expanded){
        
        expandedViewHeightConstraint.constant = 16 + 45 + 16 + 45 + 16 ;
        
    }else{
        expandedViewHeightConstraint.constant = 0 ;
    }
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ScratchCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    self.expanded = false;
    
    _scratchCardTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _scratchCardTextField.textAlignment = ([LanguageHandler sharedInstance].currentLanguage == ENGLISH) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    _scratchCardTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    [self addSubview:view];
}
@end
