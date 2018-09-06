//
//  HeaderCardView.m
//  Ana Vodafone
//
//  Created by Taha on 1/22/18.
//  Copyright © 2018 VIS. All rights reserved.
//

#import "HeaderCardView.h"
#import "AnaVodafoneLabel.h"
#import "BaseCardView+Protected.h"
#define BtnVerticalMargin 16
#define BtnHorizontalMargin 30
@interface HeaderCardView(){
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewHeighConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *buttonViewContainer;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *filterViews;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subttileLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterSeparator;

@end
@implementation HeaderCardView

#pragma Setters

-(void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.txt = titleString;
    
    [self layoutIfNeeded];
    [self initialize];

}

-(void)setSubTitleAttributedString:(NSAttributedString *)subTitleAttributedString{
    
    _subTitleAttributedString = subTitleAttributedString;
    
    _subttileLabelTopConstraint.constant = 15;
    
    if ([_descAttributedString length] > 0) {
        
        _descLabelTopConstraint.constant = 0;
    }else{
        
    _descLabelTopConstraint.constant = 15;
    }
    _subtitleLabel.attributedText = subTitleAttributedString;
    
    for (UIView * v in _filterViews) {
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.69];
    }
    [self layoutIfNeeded];
    [self initialize];
}

-(void)setDescAttributedString:(NSAttributedString *)descAttributedString{
    
    _descAttributedString = descAttributedString;
    _descLabelBottomConstraint.constant = 15;
    _descLabelTopConstraint.constant = 15;

    _descLabel.attributedText = descAttributedString;
    for (UIView * v in _filterViews) {
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.69];
    }
    
    self.filterSeparator.constant = 1;
    [self layoutIfNeeded];
    [self initialize];
}

- (void)setButtons:(NSArray *)buttons{
    
    _buttons = buttons;
    
    if (_buttons.count > 0) {
        _buttonsViewBottomConstraint.constant = 10;
        [self initializeButtonsView];
        [self layoutIfNeeded];

    }
}

- (void) initializeButtonsView{
    
    [_buttonViewContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat btnsHeight = 0;
    
    for (UIButton* btn in self.buttons) {
        
        btn.frame = CGRectMake(BtnHorizontalMargin, btnsHeight, _buttonViewContainer.frame.size.width - 60, btn.frame.size.height);
        
        btnsHeight+= BtnVerticalMargin+btn.frame.size.height;
        
        [btn layoutIfNeeded];
        [_buttonViewContainer addSubview:btn];
    }
    
    btnsHeight += BtnVerticalMargin;
    
    _buttonsViewHeighConstraint.constant = (self.buttons.count > 0) ? btnsHeight-BtnVerticalMargin : 0 ;
    [_buttonViewContainer layoutIfNeeded];
    [self initialize];
    [self layoutIfNeeded];
}

-(void)setTitleTopConstraintConstant:(int)titleTopConstraintConstant{
    
    _titleTopConstraintConstant = titleTopConstraintConstant;

    _titleLabelTopConstraint.constant = titleTopConstraintConstant;

    [self layoutIfNeeded];
    [self initialize];

}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark height adjustment

-(void)initializeContentView{

    contentViewHeight = 77;

    if ([_titleString length] > 0){

        [_titleLabel adjustHeight];
        contentViewHeight += _titleLabel.frame.size.height;
    }
    if ([_subTitleAttributedString length] > 0){

        [_subtitleLabel adjustHeight];
        contentViewHeight += _subtitleLabel.frame.size.height;
    }
    if ([_descAttributedString length] > 0){

        [_descLabel adjustHeight];
        contentViewHeight += _descLabel.frame.size.height;
    }
    contentViewHeight += _subttileLabelTopConstraint.constant + _descLabelTopConstraint.constant + _descLabelBottomConstraint.constant + _titleLabelTopConstraint.constant +_buttonsViewHeighConstraint.constant + _buttonsViewBottomConstraint.constant;
}
-(void)commonInit{
    
    [super commonInit];
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"HeaderCardView" owner:self options:nil][0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.filterSeparator.constant = 0 ;
    _buttonsViewBottomConstraint.constant = 16;

    [self addSubview:view];
}
@end
