//
//  PaymentDetailsSignPostCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//


#import "PaymentDetailsSignPostCardView.h"
#import "BaseCardView+Protected.h"
#import "ExpandSignpostWithAvatarCardView.h"
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>
#import <Languagehandlerpod/LanguageHandler.h>

@interface PaymentDetailsSignPostCardView ()

@property (weak, nonatomic) IBOutlet ExpandSignpostWithAvatarCardView *expandSignpostWithAvatarCardView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageWidthConstraint;

@end

@implementation PaymentDetailsSignPostCardView

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).expandable == true){
        
        self.expanded = !self.expanded;
        
        [self initialize];
    }else{
        
        if(((PaymentDetailsSignPostCardViewModel*)self.model).targetBlock){
        
            ((PaymentDetailsSignPostCardViewModel*)self.model).targetBlock();
        }
    }
}

#pragma mark setters

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    if (((PaymentDetailsSignPostCardViewModel*)self.model).withRadioButtons) {
        _expandSignpostWithAvatarCardView.isRadioButton = (((PaymentDetailsSignPostCardViewModel*)self.model).withRadioButtons);
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).verticalLine)) {
        
        verticalLineViewWidthConstraint.constant = (((PaymentDetailsSignPostCardViewModel*)self.model).verticalLine) ? 6:0;

    }
    
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).title)) {
        
        [self setTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).title)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).subTitle)) {
        
        [self setSubTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).subTitle)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle)) {
        
        [self setSecondTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle)];
        
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray)) {
        
        [self setExpandTableArray:(((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).expandable)) {
        
        [self setExpandable:(((PaymentDetailsSignPostCardViewModel*)self.model).expandable)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow)) {
        
        [self setTableViewSelectedIndexRow:(((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).subTitleFontSize)) {
        
        [self setSubTitleFontSize:(((PaymentDetailsSignPostCardViewModel*)self.model).subTitleFontSize)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)) {
        
        [self setTitleFontSize:(((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).subButtons)) {
        
        [self setSubButtons:(((PaymentDetailsSignPostCardViewModel*)self.model).subButtons)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).withoutAvatarImage)) {
        
        [self setWithoutAvatarImage:(((PaymentDetailsSignPostCardViewModel*)self.model).withoutAvatarImage)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).verticalLinColor)) {
        
        [self setVerticalLinColor:(((PaymentDetailsSignPostCardViewModel*)self.model).verticalLinColor)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).avatarImage)) {
        
        [self setAvatarImage:(((PaymentDetailsSignPostCardViewModel*)self.model).avatarImage)];
    }
    
}

//-(void)setWithRadioButtons:(BOOL)withRadioButtons{
//
//
//    _withRadioButtons = withRadioButtons;
//
//}
//
//-(void)setVerticalLine:(BOOL)verticalLine{
//
//    _verticalLine = verticalLine;
//
//
//    [self initialize];
//}

-(void)setTitle:(NSString *)title{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)?((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(((PaymentDetailsSignPostCardViewModel*)self.model).subTitleFontSize)?((PaymentDetailsSignPostCardViewModel*)self.model).subTitleFontSize:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSecondTitle:(NSString *)secondTitle{
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secondTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _secondTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    _avatarImageWidthConstraint.constant = 45;
    
    _avatarImgView.image = avatarImage;
    
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandSignpostWithAvatarCardView.expandTableArray = ((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray;
}

-(void)setExpandable:(BOOL)expandable{
    
    self.expanded = false;
    
    if(expandable){
        
        arrowImgView.image = [UIImage imageNamed:@"expandCardArrow"];
    }else{
        if([LanguageHandler sharedInstance].currentDirection ==RTL){
            
            arrowImgView.image = [UIImage imageNamed:@"CardArrowRTL"];
        }else{
            
            arrowImgView.image = [UIImage imageNamed:@"cardArrow"];
        }
    }
}

-(void)setTableViewSelectedIndexRow:(int)tableViewSelectedIndexRow{
    
    _expandSignpostWithAvatarCardView.selecetdIndexRow = ((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow;
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).expandable == false){
        
        value = false;
    }
    
    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
        
    [super setExpanded:value];
}

-(void)setSubTitleFontSize:(float)subTitleFontSize{
    
    
    if (((PaymentDetailsSignPostCardViewModel*)self.model).subTitle) {
        
        [self setSubTitle:((PaymentDetailsSignPostCardViewModel*)self.model).subTitle];
    }
}

- (void)setTitleFontSize:(float)titleFontSize{
    
    
    if (((PaymentDetailsSignPostCardViewModel*)self.model).title) {
        
        [self setTitle:((PaymentDetailsSignPostCardViewModel*)self.model).title];
    }
}

-(void)setSubButtons:(NSArray *)subButtons{
    
    _expandSignpostWithAvatarCardView.buttons = subButtons;

}
-(void)setWithoutAvatarImage:(BOOL)withoutAvatarImage{
    
    
    if (withoutAvatarImage) {
        self.avatarImageWidthConstraint.constant = 0;
    }else{
        self.avatarImageWidthConstraint.constant = 45;

    }
    [self initialize];
}

-(void)setVerticalLinColor:(UIColor *)verticalLinColor{
    
    verticalLineView.backgroundColor  = verticalLinColor;
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 0;
    
    //TODO:: localize
    
    CGFloat width = self.frame.size.width  - 86 - (((PaymentDetailsSignPostCardViewModel*)self.model).verticalLine ? 6 : 0) - _avatarImageWidthConstraint.constant;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).subTitle.length > 0){
        
        titleLabelTopConstraint.constant = 25;
        
        paddingHeight = 50;
        
        rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        height += rect.size.height+4;
    }else{
        
        titleLabelTopConstraint.constant = 30;
        
        paddingHeight = 60;
    }
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle.length > 0){
        
        titleLabelTopConstraint.constant = 20;
        
        CGSize size = CGSizeMake(width, CGFLOAT_MAX);
        
        CGRect rect = [_secondTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        paddingHeight = 40;
        
        height += rect.size.height+5;
    }
    
    contentViewHeight = height+paddingHeight;
}

- (void)initializeExpandedView{
    
    [_expandSignpostWithAvatarCardView initialize];
    
    _expandSignpostWithAvatarCardView.heightDidChangedBlock = ^(CGFloat height) {
        self->expandedViewHeightConstraint.constant = height;
    };
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"PaymentDetailsSignPostCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"PaymentDetailsSignPostCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.expandable = false;
}

@end
