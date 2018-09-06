//
//  BaseCardViewWithButtonsOld.h
//  Ana Vodafone
//
//  Created by Taha on 2/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "BaseCardView.h"

@interface BaseCardViewWithButtonsOld : BaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *buttonsViewHeightConstraint;
    
    __weak IBOutlet UIView *buttonsView;
}

@property (nonatomic, strong) NSArray* buttons;

- (void) initializeButtonsView;

@end

