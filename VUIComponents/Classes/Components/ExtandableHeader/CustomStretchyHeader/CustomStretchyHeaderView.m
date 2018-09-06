//
//  CustomStretchyHeaderView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "CustomStretchyHeaderView.h"
#import "PagerView.h"

@interface CustomStretchyHeaderView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *triangleView;

@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CustomStretchyHeaderView

#pragma mark setter

-(void)setBGImage:(UIImage *)BGImage{
    
    _BGImage = BGImage;
    
    _BGImageView.image = BGImage;
}

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    _titleAttributedString = titleAttributedString;
    
    _navTitleLabel.attributedText = titleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_navTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
  
    self.minimumContentHeight = rect.size.height +70;
    self.maximumContentHeight = rect.size.height +70;

}

-(void)setCardView:(BaseCardView *)cardView{
    
    _cardView = cardView;
    
    CGPoint point = _containerView.frame.origin;

    CGSize size = _cardView.frame.size;
    
    _containerViewHeightConstraint.constant = size.height;
    
    _containerView.frame = CGRectMake(point.x, point.y, size.width, size.height);
    
    _containerView.clipsToBounds = YES;
    
    [_containerView addSubview:_cardView];
    
    self.minimumContentHeight = _containerView.frame.origin.y;

    self.maximumContentHeight = _containerView.frame.size.height +self.minimumContentHeight;
    
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = 1;
    CGFloat blurAlpha = 1;
    if (stretchFactor > 1) {
        alpha = CGFloatTranslateRange(stretchFactor, 1, 1.12, 1, 0);
        blurAlpha = alpha;
    } else if (stretchFactor < 0.8) {
        alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    }
    
    alpha = MAX(1, alpha);
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_triangleView) {
        UIBezierPath* path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width/2, _triangleView.bounds.size.height)];
        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width, 0)];
        [path addLineToPoint:CGPointMake(0, 0)];
        
        CAShapeLayer *mask = [CAShapeLayer new];
        mask.frame = _triangleView.bounds;
        mask.path = path.CGPath;
        _triangleView.layer.mask = mask;

    }
    
}
#pragma mark init
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self = [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        //        self = [self commonInit];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [self commonInit];
    }
    return self;
}

-(CustomStretchyHeaderView *)commonInit{
    
    CustomStretchyHeaderView *headerView;
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomStretchyHeaderView"
                                                      owner:self
                                                    options:nil];
    headerView = nibViews.firstObject;
    
    return headerView;
}
@end
