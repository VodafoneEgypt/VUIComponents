//
//  SignpostsWithAvatarView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostsWithAvatarCardView.h"
#import "BaseCardView+Protected.h"
#import "ExpandSignpostWithAvatarCardView.h"
#import "LanguageHandler.h"
#import "UIColor+Hex.h"

@interface SignpostsWithAvatarCardView ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet ExpandSignpostWithAvatarCardView *expandSignpostWithAvatarCardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelBottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;

@end

@implementation SignpostsWithAvatarCardView

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_isExpandable == true){

        self.expanded = !self.expanded;
        [self performExpandingAnimation:!self.isExpandable];

        [self initialize];
    }else{

        if(_targetBlock){

            _targetBlock();
        }
    }
}

#pragma mark setters
-(void)setSubTitleLabelAdjustsFontSizeToFitWidth:(Boolean)F andNumberOfLine:(NSInteger)N{
    
    subTitleLabel.numberOfLines = N;
    [subTitleLabel setAdjustsFontSizeToFitWidth:F];
    [self initialize];

}

-(void)setVerticalLine:(BOOL)verticalLine{
    
    _verticalLine = verticalLine;
    
    verticalLineViewWidthConstraint.constant = verticalLine ? 6:0;
    
   [self initialize];
}

-(void)setTitle:(NSString *)title{
    
    _title = [[LanguageHandler sharedInstance]stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
   [self initialize];
}

-(void)setTitle:(NSString *)title WithFontSize:(int)fontSize{
    
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
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:fontSize],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
    
}
-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = [[LanguageHandler sharedInstance]stringForKey:subTitle];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle WithFontSize:(int)fontSize{
    
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
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:fontSize],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSecondTitle:(NSString *)secondTitle{
    
    _secondTitle = [[LanguageHandler sharedInstance]stringForKey:secondTitle];
    
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
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_secondTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _secondTitleLabel.attributedText = attrStr1;
    
   [self initialize];
}

-(void)setSecondTitle:(NSString *)secondTitle WithFontSize:(int)fontSize{
    
    _secondTitle = secondTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([LanguageHandler sharedInstance].currentDirection ==RTL){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:fontSize],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secondTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _secondTitleLabel.attributedText = attrStr1;
    
    [self initialize];
    
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    _avatarImage = avatarImage;
    
    _avatarImgView.image = avatarImage;
    
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}
-(void)setWithoutCircleImage:(BOOL)withoutCircleImage{
    
    _withoutCircleImage = withoutCircleImage;
    
    _avatarImgView.layer.cornerRadius =(withoutCircleImage)?0:_avatarImgView.frame.size.height / 2;

}
-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    _expandSignpostWithAvatarCardView.expandTableArray = expandTableArray;
}
-(void)setIsExpandable:(BOOL)isExpandable{
//    if(isExpandable){
//
//        arrowImgView.image = [UIImage imageNamed:@"downArrow"];
//    }else{
//        if([LanguageHandler sharedInstance].currentDirection ==RTL){
//
//            arrowImgView.image = [UIImage imageNamed:@"CardArrowRTL"];
//        }else{
//
//            arrowImgView.image = [UIImage imageNamed:@"cardArrow"];
//        }
//    }
    
   // [expandedView setHidden:!isExpandable];
    [self performExpandingAnimation:isExpandable];
   
    
}
-(void)performExpandingAnimation:(BOOL)expand{
    _isExpandable = expand;
    [UIView animateWithDuration:1 animations:^{
        [expandedView setHidden:!expand];
    }];
}

-(void)setButtons:(NSArray *)buttons{
    
    _expandSignpostWithAvatarCardView.buttons = buttons;
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 0;
    
    //TODO:: localize
    
    CGFloat width = self.frame.size.width  - 111 - (self.verticalLine ? 6 : 0);
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    if(self.subTitle.length > 0){
        
        titleLabelTopConstraint.constant = 25;
        
        paddingHeight = 50;
        
        rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        height += rect.size.height+4;
    }else{
        
        titleLabelTopConstraint.constant = 30;
        _titleLabelBottomConstraint.constant = 9;
        paddingHeight = 60;
    }
    
    if(self.secondTitle.length > 0){
        
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
    
    expandedViewHeightConstraint.constant = _expandSignpostWithAvatarCardView.frame.size.height;
}

- (void)adjustDescViewHeightTo:(CGFloat)height{
    
    expandedViewHeightConstraint.constant = height;
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostsWithAvatarCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostsWithAvatarCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    _secondTitleLabel.text = nil;
    subTitleLabel.text = nil ;
    titleLabel.text = nil;
    
   // self.verticalLine = false;
    
}


@end
