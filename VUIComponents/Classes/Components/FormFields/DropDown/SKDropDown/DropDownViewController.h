//
//  DropDownViewController.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/23/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownViewController : UIViewController

@property (strong, nonatomic) UITableView *table;

- (instancetype)initDropDownWithFrame:(CGRect)frame;

@end
