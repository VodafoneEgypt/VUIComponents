//
//  GiftCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 8/21/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "GiftCardView.h"
#import "AnaVodafoneLabel.h"
#import "BaseCardView+Protected.h"
#import "LanguageHandler.h"

@interface GiftCardView() {}

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLableTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

@end

@implementation GiftCardView

-(void)setTitleString:(NSString *)titleString {
    
    _titleString = [[LanguageHandler sharedInstance] stringForKey:titleString];
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_titleString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20]}];
    
    _titleLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setDescString:(NSString *)descString {
    
    _descString = [[LanguageHandler sharedInstance] stringForKey:descString];
    
    _descLableTopConstraint.constant = 10;

    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_descString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20]}];
    
    _descLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setDateString:(NSString *)dateString {
    
    _dateString = [[LanguageHandler sharedInstance] stringForKey:dateString];
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_dateString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14]}];
    
    _dateLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setGiftImg:(UIImage *)giftImg {
    _giftImg = giftImg;
    _giftImageView.image = giftImg;
}
 
-(void)commonInit {
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"GiftCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self addSubview:view];
}

@end
