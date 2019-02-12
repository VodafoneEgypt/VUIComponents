//
//  BottomSheetView.h
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "CreditCardViewModel.h"
#import "CustomButton.h"

typedef enum : NSUInteger {
    TopPstion,
    CenterPostion
} BottomSheetOpeningPostion;

@interface BottomSheetView : UIViewController
@property (strong, nonatomic) IBInspectable NSString *bottomSheetTitle;
@property (strong, nonatomic) IBInspectable NSString *swipeTitle;
@property (nonatomic) BottomSheetOpeningPostion *openingPostion;

-(void)showBottomSheetWithView:(UIView*)view andViewController:(UIViewController *)viewController onSuperView:(UIView *)superView ;
-(void)dismissView ;


@end

