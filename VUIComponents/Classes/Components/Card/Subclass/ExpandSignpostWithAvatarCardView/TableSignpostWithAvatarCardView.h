//
//  TableSignpostWithAvatarCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
#import "DropdownMenu.h"

@interface TableSignpostWithAvatarCardView : BaseCardViewWithButtons

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) BOOL isRadioButton;

@property (nonatomic) int selecetdIndexRow;

@property (nonatomic) CGFloat cellHeight;

@property (strong,nonatomic) SelectionBlock selectionBlock;

@property (nonatomic ,strong) UIColor* cellBGColor ;

@end
