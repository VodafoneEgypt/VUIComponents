//
//  TableCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "BaseCellCardView.h"
#import "BaseCardViewWithButtons.h"

typedef void(^SelectionIndexPathBlock)(NSIndexPath *indexPath);

@interface TableCardView : BaseCardViewWithButtons

@property (nonatomic, strong) NSArray *tableCardModelArray;

@property (strong,nonatomic) SelectionIndexPathBlock selectionIndexPathBlock;

@property (strong , nonatomic) BaseCellCardView* cellCardView;

@property (nonatomic,strong) NSIndexPath* selectedIndexPath;

@property (nonatomic) BOOL allowSelection;

@end
