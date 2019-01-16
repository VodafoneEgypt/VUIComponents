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
@property (strong, nonatomic) IBInspectable NSString *footetTableViewcell1Title;
@property (strong, nonatomic) IBInspectable NSString *footetTableViewcell2Title;

@property (strong, nonatomic) IBInspectable UIImage *footetTableViewcell1Image;
@property (strong, nonatomic) IBInspectable UIImage *footetTableViewcell2Image;


@property (copy) void (^selectedActionBlock) (NSInteger);
@property (strong, nonatomic) CreditCardViewModel *selectedCard;
@property (strong, nonatomic) NSArray *creditCardModelArray;
@property (nonatomic) ActionBlock addCreditCardActionBlock;
@property (nonatomic) ActionBlock manageCreditCardActionBlock;



//-(void)setCreditCardArray:(NSArray *)creditCardArray ;
-(void)showBottomSheet:(UIViewController *)viewController :(UIView *)view ;
-(void)dismissView ;


@end

