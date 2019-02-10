//
//  SignpostsWithAvatarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by NTG on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostsWithAvatarCardView.h"
#import "BaseCardView+Protected.h"
#import "TableSignpostWithAvatarCardView.h"
#import "LanguageHandler.h"
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>

@interface SignpostsWithAvatarCardView (){
    
    CAShapeLayer *dashedViewShapeLayer;
}

@property (weak, nonatomic) IBOutlet TableSignpostWithAvatarCardView *tableSignpostWithAvatarCardView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *dashedView;

@end

@implementation SignpostsWithAvatarCardView

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_expandable == true){
        
        self.expanded = !self.expanded;
        
        [self initialize];
    }else{
        
        if(_targetBlock){
            
            _targetBlock();
        }
    }
}

#pragma mark setters

-(void)setWithoutArrowImageView:(BOOL)withoutArrowImageView{
    
    _withoutArrowImageView = withoutArrowImageView;
    arrowImgView.hidden = withoutArrowImageView ;
}

-(void)setCellHeight:(CGFloat)cellHeight{
    
    _cellHeight = cellHeight;
    _tableSignpostWithAvatarCardView.cellHeight = cellHeight;
}

-(void)setExpandTableViewColor:(UIColor*)expandTableViewColor{
    
    _expandTableViewColor = expandTableViewColor;
    _tableSignpostWithAvatarCardView.cellBGColor = expandTableViewColor;
}

-(void)setWithDashedViewCell:(BOOL)withDashedViewCell{
    
    _withDashedViewCell = withDashedViewCell;
    _tableSignpostWithAvatarCardView.withDashedViewCell = withDashedViewCell ;
}

-(void)setWithDashedView:(BOOL)withDashedView{
    
    _withDashedView = withDashedView;
}

-(void)setCellColor:(UIColor*)cellColor{
    
    _cellColor = cellColor;
    _containerView.backgroundColor = cellColor ;
}

-(UIImageView *)getAvatarImageView {
    return _avatarImgView;
}

-(void)setAvatarImageView:(UIImageView *)imageView {
    _avatarImgView = imageView;
}

-(void)setSubTitleLabelAdjustsFontSizeToFitWidth:(Boolean)F andNumberOfLine:(NSInteger)N{
    
    subTitleLabel.numberOfLines = N;
    [subTitleLabel setAdjustsFontSizeToFitWidth:F];
    [self initialize];
    
}

-(void)setWithoutCircleImage:(BOOL)withoutCircleImage{
    
    _withoutCircleImage = withoutCircleImage;
    
    _avatarImgView.layer.cornerRadius =(withoutCircleImage)?0:_avatarImgView.frame.size.height / 2;
    
}

-(void)setWithRadioButtons:(BOOL)withRadioButtons{
    
    _tableSignpostWithAvatarCardView.isRadioButton = withRadioButtons;
    
    _withRadioButtons = withRadioButtons;
    
}

-(void)setVerticalLine:(BOOL)verticalLine{
    
    _verticalLine = verticalLine;
    
    verticalLineViewWidthConstraint.constant = verticalLine ? 6:0;
    
    [self initialize];
}

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(_titleFontSize)?_titleFontSize:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = subTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(_subTitleFontSize)?_subTitleFontSize:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSecondTitle:(NSString *)secondTitle{
    
    _secondTitle = secondTitle;
    
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

- (void)setAvatarImgSize:(CGSize)avatarImgSize{
    
    _avatarImgSize = avatarImgSize;
    
    self.avatarImageWidthConstraint.constant = _avatarImgSize.width;

    if (_avatarImage) {
        
        [self  setAvatarImage:_avatarImage];
    }
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    self.avatarImageWidthConstraint.constant = (_avatarImgSize.width > 0)? _avatarImgSize.width : 45;
    
    _avatarImage = avatarImage;
    
    _avatarImgView.image = avatarImage;
    
    if (!_withoutCircleImage) {
        
        _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    }
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    _tableSignpostWithAvatarCardView.expandTableArray = expandTableArray;
}

-(void)setExpandable:(BOOL)expandable{
    
    _expandable = expandable;
    
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
    
    _tableViewSelectedIndexRow = tableViewSelectedIndexRow;
    
    _tableSignpostWithAvatarCardView.selecetdIndexRow = _tableViewSelectedIndexRow;
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;
    
    if(_expandable == false){
        
        value = false;
    }
    
    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
    
    [super setExpanded:value];
}

-(void)setSubTitleFontSize:(float)subTitleFontSize{
    
    _subTitleFontSize = subTitleFontSize;
    
    if (_subTitle) {
        
        [self setSubTitle:_subTitle];
    }
}

- (void)setTitleFontSize:(float)titleFontSize{
    
    _titleFontSize = titleFontSize;
    
    if (_title) {
        
        [self setTitle:_title];
    }
}

-(void)setButtons:(NSArray *)buttons{
    
    _tableSignpostWithAvatarCardView.buttons = buttons;
}

-(void)setWithoutAvatarImage:(BOOL)withoutAvatarImage{
    
    _withoutAvatarImage = withoutAvatarImage;
    
    if (withoutAvatarImage) {
        self.avatarImageWidthConstraint.constant = 0;
    }else{
        self.avatarImageWidthConstraint.constant = 45;
        
    }
    [self initialize];
}

-(void)setVerticalLinColor:(UIColor *)verticalLinColor{
    
    _verticalLinColor = verticalLinColor;
    
    verticalLineView.backgroundColor  = verticalLinColor;
}

-(void)setAvatarImgViewBGColor:(UIColor *)avatarImgViewBGColor{
    
    _avatarImgViewBGColor = avatarImgViewBGColor;
    _avatarImgView.backgroundColor = avatarImgViewBGColor;
    _avatarImgView.contentMode = UIViewContentModeCenter;
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 0;
    
    //TODO:: localize
    
    
    [titleLabel adjustHeight];
    height += titleLabel.frame.size.height;
    
    if(self.subTitle.length > 0){
        
        titleLabelTopConstraint.constant = 25;
        
        paddingHeight = 50;
        
        [subTitleLabel adjustHeight];
        height += subTitleLabel.frame.size.height+4;
    }else{
        
        titleLabelTopConstraint.constant = 30;
        
        paddingHeight = 60;
    }
    
    if(self.secondTitle.length > 0){
        
        titleLabelTopConstraint.constant = 20;
        
        paddingHeight = 40;
        
        [_secondTitleLabel adjustHeight];
        height += _secondTitleLabel.frame.size.height+5;
    }
    
    contentViewHeight = height+paddingHeight;
    
}

- (void)initializeExpandedView{
    
    [_tableSignpostWithAvatarCardView initialize];
    
    _tableSignpostWithAvatarCardView.heightDidChangedBlock = ^(CGFloat height) {
        self->expandedViewHeightConstraint.constant = height;
    };
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_withDashedView){
        
        [self drawDashedLineBottom];
    }
}

-(void)drawDashedLineBottom {
    
    dashedViewShapeLayer = [CAShapeLayer layer];
    dashedViewShapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    dashedViewShapeLayer.fillColor = nil;
    dashedViewShapeLayer.lineDashPattern = @[@7, @3];
    dashedViewShapeLayer.frame = self.dashedView.bounds;
    dashedViewShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0 ,414 , 0) cornerRadius:0].CGPath;
    self.dashedView.backgroundColor = UIColor.clearColor ;
    [self.dashedView.layer addSublayer:dashedViewShapeLayer];
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL) {
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.verticalLine = false;
    _tableSignpostWithAvatarCardView.selectionBlock = ^(int index) {
        
        if (self.selectionBlock) {
            self.selectionBlock(index);
        }
    };
    
    self.expandable = false;
    self.avatarImageWidthConstraint.constant = 0;
    }

@end
