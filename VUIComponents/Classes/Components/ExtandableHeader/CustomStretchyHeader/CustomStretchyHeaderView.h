//
//  CustomStretchyHeaderView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import "BaseCardView.h"

@interface CustomStretchyHeaderView : GSKStretchyHeaderView

@property(nonatomic ,strong) BaseCardView *cardView;

@property(nonatomic, strong) UIImage *BGImage;

@property(nonatomic, strong) NSAttributedString *titleAttributedString;

@end
