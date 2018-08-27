//
//  CvvTextField.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "CvvTextField.h"
#import "ValidationTextFieldStyleModel.h"
#import <VUIComponents/LanguageHandler.h>
#import "UIColor+Hex.h"

#define height 45

@interface CvvTextField()<UITextFieldDelegate>{
    
    UIButton *cvvButtonImage;
    
    UIView *paddingView;
}

@property (strong, nonatomic)  UIImage *img;

@end

@implementation CvvTextField

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    ValidationTextFieldStyleModel *objValidationTextFieldStyleModel = [[ValidationTextFieldStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedBorderColor] CGColor];
    self.layer.borderWidth = objValidationTextFieldStyleModel.unSelectedBorderWidth;
    self.layer.cornerRadius = objValidationTextFieldStyleModel.unSelectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedTextColor];
    self.font = [UIFont fontWithName:objValidationTextFieldStyleModel.fontFamily size:objValidationTextFieldStyleModel.fontSize];
    
    self.backgroundColor =[UIColor colorWithCSS: objValidationTextFieldStyleModel.backgroundColor];
}

-(void)setImg:(UIImage *)img{
    
    _img = img;
    
    [cvvButtonImage setImage:img forState:UIControlStateNormal];
    [cvvButtonImage setImage:img forState:UIControlStateHighlighted];
    [cvvButtonImage setImage:img forState:UIControlStateDisabled];
}

#pragma mark textField delegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 3 || returnKey;
}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height)];
}

#pragma mark initialize

-(id)initWithStyleFilePath:(NSString*)styleFilePath {
    
    self = [super init];
    
    if(self){
        
        [self commonInit];
        
        self.styleFilePath = styleFilePath;
    }
    
    return self;
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
    
    self.secureTextEntry = true;

    cvvButtonImage = [UIButton buttonWithType:UIButtonTypeCustom];
   
    cvvButtonImage.userInteractionEnabled = false;
    
    self.img = [UIImage imageNamed:@"CreditCard"];
    
    self.delegate = self;
    
    BOOL deviseDirectionRightToLeft;
    
    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        deviseDirectionRightToLeft = !([LanguageHandler sharedInstance].currentDirection == RTL);
        
    }else{
        deviseDirectionRightToLeft = [LanguageHandler sharedInstance].currentDirection == RTL;
    }
    if (deviseDirectionRightToLeft){
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
        
        self.rightView = paddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        cvvButtonImage.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        cvvButtonImage.frame = CGRectMake(0,0, 50, 15);
        self.leftView = cvvButtonImage;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,20, 0)];
        
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        cvvButtonImage.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        cvvButtonImage.frame = CGRectMake(0,0, 50, 15);
        self.rightView = cvvButtonImage;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    
    if ([LanguageHandler sharedInstance].currentDirection == RTL) {

        self.textAlignment = NSTextAlignmentRight;
    }else{
        
        self.textAlignment = NSTextAlignmentLeft;
    }
}

@end
