//
//  HeaderCardView.h
//  Ana Vodafone
//
//  Created by Taha on 1/22/18.
//  Copyright © 2018 VIS. All rights reserved.
//

#import "BaseCardView.h"

IB_DESIGNABLE

@interface HeaderCardView : BaseCardView

@property (nonatomic , strong) IBInspectable NSString * titleString;
@property (nonatomic , strong) NSAttributedString * subTitleAttributedString;
@property (nonatomic , strong) NSAttributedString * descAttributedString;

@property (nonatomic , strong) NSArray *buttons;

@property (nonatomic ) IBInspectable int titleTopConstraintConstant;

@end
