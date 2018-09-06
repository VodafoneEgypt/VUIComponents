//
//  ExpandSignpostCellModel.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ExpandSignpostCellModel : NSObject

@property (nonatomic ,strong) NSString *leftText;

@property (nonatomic ,strong) NSString *rightText;

@property (nonatomic ,strong) UIImage *image;

@property (nonatomic ,strong) UIImage *seletedImage;

@property (strong ,nonatomic) ActionBlock actionBlock;

@end
