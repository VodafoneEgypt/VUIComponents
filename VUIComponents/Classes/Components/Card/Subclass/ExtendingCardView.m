//
//  SingleLineExtendingCard.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/8/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExtendingCardView.h"
#import "BaseCardView+Protected.h"
#import "SimpleTextCardView.h"
#import <VUIComponents/LanguageHandler.h>
#import "UIColor+Hex.h"

@interface  ExtendingCardView(){
    BOOL animate;
}

@property (strong, nonatomic) IBOutlet SimpleTextCardView* descView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;

@property (strong, nonatomic) IBOutlet UIView *verticalLineView;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *separator;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ExtendingCardView

#pragma mark actions

- (IBAction)changeExpandStatus:(id)sender {
    
    //self.isExpanded = !self.isExpanded;
    animate = true;
    [self performExpandingAnimation:!self.isExpanded];
    
    //[self initialize];
}

#pragma mark setters

-(void)setVerticalLine:(BOOL)verticalLine{
    
    _verticalLine = verticalLine;
    
    _verticalLineViewWidthConstraint.constant = verticalLine ? 6:0;
    
    [self initialize];
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
    
    // create attributed string
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.titleLabel.attributedText = attrStr1;
    
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
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setDesc:(NSString *)desc{
    
    _desc = desc;
    
    _descView.text = desc;
    
    [self initialize];
}
-(void)setIsExpanded:(BOOL)isExpanded{
    //_arrowImgView.transform = (isExpanded == true) ? CGAffineTransformRotate(_arrowImgView.transform, M_PI):CGAffineTransformIdentity;
    
    // [_verticalLineView setHidden:expanded];
    [self performExpandingAnimation:isExpanded];
    
    
}
-(void)performExpandingAnimation:(BOOL)expand{
    _isExpanded = expand;
    if (!animate){
        //handle interface builder
        [expandedView setHidden:!expand];

    }else{
        //perform animation
        [UIView animateWithDuration:0.2 animations:^{
            [expandedView setHidden:!expand];

        } completion:^(BOOL finished) {
            [_separator setHidden:!expand];

        }];
        
//        if(expand){
//            [expandedView setHidden:true];
//            [_stackView addArrangedSubview:expandedView];
//            [UIView animateWithDuration:1 animations:^{
//                [expandedView setHidden:false];
//                [_separator setExclusiveTouch:false];
//
//            }];
//        }else{
//            [_separator setHidden:true];
//            [UIView animateWithDuration:1 animations:^{
//                [expandedView setHidden:true];
//
//            } completion:^(BOOL finished) {
//                [_stackView removeArrangedSubview:expandedView];
//            }];
//
//        }
    }
    
   
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    //TODO:: localize
    
    CGFloat width = self.frame.size.width - 60 - (_verticalLine ? 6 : 0);
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    if(self.expanded == true){
        
        _titleLabelTopConstraint.constant = 25;
        
        height += 45;
        
        /*calculate title height*/
        CGRect rect = [self.titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        height += rect.size.height;
        
        /*calculate desc height*/
        
        if(self.subTitle.length > 0){
            
            /*calculate subtitle height*/
            
            rect = [self.subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            height += rect.size.height;
        }
    }else{
        
        /*calculate title height*/
        CGRect rect = [self.titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        height += rect.size.height;
        
        if(self.subTitle.length > 0){
            
            _titleLabelTopConstraint.constant = 25;
            
            height += 50;
            
            /*calculate subtitle height*/
            
            CGRect rect = [self.subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            height += rect.size.height;
        }else{
            
            _titleLabelTopConstraint.constant = 30;
            
            height += 60;
        }
    }
    
    contentViewHeight = height;
}

- (void)initializeExpandedView{
    
    CGRect frame = _descView.frame;
    
    frame.size.width = self.frame.size.width - (_verticalLine ? 6 : 0);
    
    _descView.frame = frame;
    
    [_descView initialize];
    
    expandedViewHeightConstraint.constant = _descView.frame.size.height+1/*seperator height*/;
}

- (void)adjustDescViewHeightTo:(CGFloat)height{
    
    expandedViewHeightConstraint.constant = height+1/*seperator height*/;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ExtendingCardViewRTL" owner:self options:nil];
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ExtendingCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self addSubview:view];

    self.verticalLine = false;
}
@end
