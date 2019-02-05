//
//  BottomSheetView.h
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "CreditCardViewModel.h"
#import "CustomButton.h"

@interface BottomSheetView : UIViewController
@property (strong, nonatomic) IBInspectable NSString *bottomSheetTitle;
@property (strong, nonatomic) IBInspectable NSString *swipeTitle;

-(void)showBottomSheetWithView:(UIView*)view andViewController:(UIViewController *)viewController onSuperView:(UIView *)superView ;
-(void)dismissView ;


@end

