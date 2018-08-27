//
//  CustomButtom.h
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizableButton.h"

typedef void(^ActionBlock)(void);

@interface CustomButton : LocalizableButton

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;

@property (strong ,nonatomic) ActionBlock actionBlock;

-(instancetype) initWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock;

+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock;

-(void)handleUnSelected;

@end
