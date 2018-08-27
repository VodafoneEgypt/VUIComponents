//
//  CustomButtom.m
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import "CustomButton.h"
#import "CustomButtonStyleModel.h"
#import "UIColor+Hex.h"
#import <VUIComponents/LanguageHandler.h>

#define height 45

@interface CustomButton(){
    
    CustomButtonStyleModel *objCustomButtonModel;
}
@end

@implementation CustomButton

#pragma mark setters

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    self.titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18];

    objCustomButtonModel = [[CustomButtonStyleModel alloc] initWithStyleFilePath:styleFilePath];

    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.normalTitleColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.highlightedTitleColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.disabledTitleColor] forState:UIControlStateDisabled];
    
    
    [self handleUnSelected];
}

#pragma mark event handling

-(void)performAction{

    [self handleUnSelected];
    
    if (_actionBlock != nil) {
        
        _actionBlock();
    }
}

-(void)handleUnSelected{
    
    self.layer.borderWidth = objCustomButtonModel.normalBorderWidth;
    self.layer.cornerRadius = objCustomButtonModel.normalCornerRadius;
    self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.normalBorderColor].CGColor;
    
    self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.normalBackgroundColor ] colorWithAlphaComponent:objCustomButtonModel.normalBackgroundAlpha];
}

-(void)handleTouchDownEvent{
    
    self.layer.borderWidth = objCustomButtonModel.highlightedBorderWidth;
    self.layer.cornerRadius = objCustomButtonModel.highlightedCornerRadius;
    self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.highlightedBorderColor].CGColor;
    
    self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.highlightedBackgroundColor] colorWithAlphaComponent:objCustomButtonModel.highlightedBackgroundAlpha];
}

#pragma mark overided
-(void)setFrame:(CGRect)frame{
     
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height)];
}

-(void)setEnabled:(BOOL)enabled{
    
    [super setEnabled:enabled];
    
    if (enabled) {
       
        [self handleUnSelected];
    }else{
        
        self.layer.borderWidth = objCustomButtonModel.disabledBorderWidth;
        self.layer.cornerRadius = objCustomButtonModel.disabledCornerRadius;
        self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.disabledBorderColor].CGColor;
        
        self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.disabledBackgrounddColor] colorWithAlphaComponent:objCustomButtonModel.disabledBackgroundlpha];
    }
}

#pragma mark initialize

-(instancetype) initWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock{

    self = [super init];
    
    if(self){
        
        self.txt = txt;
        
        self.styleFilePath = styleFilePath;
        
        _actionBlock = actionBlock;
        
        [self commonInit];
    }
    
    return self;
}

+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock{

    return [[CustomButton alloc] initWithTxt:txt AndStyleFilePath:styleFilePath AndActinBlock:actionBlock];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit{
    
    [self addTarget:self action:@selector(handleTouchDownEvent) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(handleUnSelected) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(handleUnSelected) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
    self.layer.masksToBounds = YES;
}

@end
