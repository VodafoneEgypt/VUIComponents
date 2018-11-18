//
//  RechargeCardView.m
//  Ana Vodafone
//
//  Created by Taha on 11/18/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "RechargeCardView.h"
#import "BaseCardView+Protected.h"
#import "AnaVodafoneLabel.h"
#import "UIColor+Hex.h"
#import "ValidationTextField.h"
#import "CvvTextField.h"
@interface RechargeCardView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *grantedTextField;
@property (weak, nonatomic) IBOutlet CvvTextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *converterImgView;
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tittleLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountTextFieldTrailingConstraint;

@end

@implementation RechargeCardView

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    _imgView.image = image;
    
    [self initialize];
}

-(void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.text = titleString;
    
    [self initialize];
}

-(void)setConverterImage:(UIImage *)converterImage{
    
    _converterImage = converterImage;
    
    _converterImgView.image = converterImage;
}

-(void)setAmountString:(NSString *)amountString{
    
    _amountString = amountString;
    
    _amountTextField.text = amountString;
}

-(void)setCvvString:(NSString *)cvvString{
    
    _cvvString = cvvString;
    
    _cvvTextField.text = cvvString;
}

-(void)setAmountPlaceHolder:(NSString *)amountPlaceHolder{
    
    _amountPlaceHolder = amountPlaceHolder;
    
    _amountTextField.placeholder = amountPlaceHolder;
}

-(void)setCvvPlaceHolder:(NSString *)cvvPlaceHolder{
    
    _cvvPlaceHolder = cvvPlaceHolder;
    
    _cvvTextField.placeholder = cvvPlaceHolder;
}

-(void)setConversionRatio:(float)conversionRatio{
    
    _conversionRatio = conversionRatio;

    if (conversionRatio < 0) {
        
        _amountTextFieldTrailingConstraint.constant = 0;
    } else {
        
        _amountTextFieldTrailingConstraint.constant = _amountTextField.superview.frame.size.width - _converterImgView.frame.origin.x;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "] || (![self validateStringIsNumbers:string] && ![string isEqualToString:@""])){
        NSLog(@"not an number");
        return  NO;
    }else if (textField == self.cvvTextField) {
        if (textField.text.length < 4 || string.length == 0) {
            return YES;
        } else {
            return NO;
        }
    }else if (textField == self.amountTextField){
        
        float newValue;
        
        if ([string isEqualToString:@""] && [self.amountTextField.text length] > 1) {
            
            newValue = [[self.amountTextField.text substringToIndex:[self.amountTextField.text length] - 1] floatValue];
            
        }else if ([string isEqualToString:@""] && [self.amountTextField.text length] < 2){
            
            self.grantedTextField.text = @"";
            
            return YES;
            
        }else{
            
            newValue = [[NSString stringWithFormat:@"%@%@", self.amountTextField.text,string] floatValue];
        }
        newValue = newValue * self.conversionRatio;
        
        self.grantedTextField.text = [NSString stringWithFormat:@"%.2f",newValue];
        
        return YES;
        
    }else if (textField == self.grantedTextField){
        
        float newValue;
        
        if ([string isEqualToString:@""] && [self.grantedTextField.text length] > 1) {
            
            newValue = [[self.grantedTextField.text substringToIndex:[self.grantedTextField.text length] - 1] floatValue];
            
        }
        else if ([string isEqualToString:@""] && [self.grantedTextField.text length] < 2){
            
            self.amountTextField.text = @"";
            
            return YES;
            
        }else{
            
            newValue = [[NSString stringWithFormat:@"%@%@", self.grantedTextField.text,string] floatValue];
        }
        
        newValue = newValue * 1/self.conversionRatio;
        
        self.amountTextField.text = [NSString stringWithFormat:@"%.2f",newValue];
        
        return YES;
    }
    return YES;
}

- (BOOL)validateStringIsNumbers:(NSString *)string
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}
#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 76 + 126 + 30 + 28 + 45 + 16 + 45 + 16;
    
    if ([_titleLabel.text length] > 0) {

        [_titleLabel adjustHeight];
        _tittleLabelHeightConstraint.constant = _titleLabel.frame.size.height;
        contentViewHeight += _titleLabel.frame.size.height;
    }

}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle mainBundle]loadNibNamed:@"RechargeCardView" owner:self options:nil][0];
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    _amountTextField.delegate = self;
    _grantedTextField.delegate = self;
    _conversionRatio = -1;
    _cvvTextField.cardImg = [UIImage imageNamed:@"CVVicon"];
    [self addSubview:view];
    [self layoutIfNeeded];

}
@end
