//
//  ViewControllerTableCardSample.m
//  VUIComponents_Example
//
//  Created by Taha on 12/3/18.
//  Copyright © 2018 1RGB1. All rights reserved.
//

#import "ViewControllerTableCardSample.h"
#import "TableCardView.h"
#import "TableCardModel.h"
#import "ExpandCellCardModel.h"
#import "ExpandSignpostCellModel.h"
#import "ExpandCellCardView.h"
#import <Languagehandlerpod/LanguageHandler.h>
#import "MultiLineCellCardView.h"
#import "SimpleTextCardView.h"

@interface ViewControllerTableCardSample ()

@property (weak, nonatomic) IBOutlet TableCardView *tableCardView;
@property (weak, nonatomic) IBOutlet SimpleTextCardView *simpleTextCardView;

@end

@implementation ViewControllerTableCardSample

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self setupTableCardView];
    [self setupSimpleTextCardView];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

-(void)setupTableCardView{
    
    TableCardModel *tableCardModel = [TableCardModel new];
    tableCardModel.data = @[];
    ExpandCellCardModel *multiLineRadioButtonCellModel1 = [ExpandCellCardModel new];
    ExpandCellCardModel *multiLineRadioButtonCellModel2 = [ExpandCellCardModel new];
    ExpandCellCardModel *multiLineRadioButtonCellModel3 = [ExpandCellCardModel new];
  
    NSDictionary* attributes;
    
    attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                   NSForegroundColorAttributeName:[UIColor blackColor]};
    
    
    NSMutableAttributedString* question = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"question question question question question question question question question question "] attributes:attributes];
    
    
    
    multiLineRadioButtonCellModel1.avatarImage = [UIImage imageNamed:@"avatar1"];
    
    multiLineRadioButtonCellModel1.title = @"Signpost title3";
    
    multiLineRadioButtonCellModel1.subTitle = @"01234 5678903";
    
    multiLineRadioButtonCellModel1.secondTitle = @"£11.61";
    
    multiLineRadioButtonCellModel1.verticalLine = true;

    
    ExpandSignpostCellModel *objExpandSignpostCellModel1 = [[ExpandSignpostCellModel alloc] init];
    objExpandSignpostCellModel1.leftText = @"first";
    objExpandSignpostCellModel1.rightText = @"first";
    
    ExpandSignpostCellModel *objExpandSignpostCellModel2 = [[ExpandSignpostCellModel alloc] init];
    
    objExpandSignpostCellModel2.leftText = @"seconed";
    objExpandSignpostCellModel2.rightText = @"seconed";
    
    ExpandSignpostCellModel *objExpandSignpostCellModel3 = [[ExpandSignpostCellModel alloc] init];
    objExpandSignpostCellModel3.leftText = @"third";
    objExpandSignpostCellModel3.rightText = @"third";
    
    NSArray *data = @[objExpandSignpostCellModel1,objExpandSignpostCellModel2,objExpandSignpostCellModel3];
    
    multiLineRadioButtonCellModel1.expandTableArray = data ;
    
    multiLineRadioButtonCellModel1.verticalLine = true;
    
    multiLineRadioButtonCellModel1.targetBlock = ^{
        NSLog(@"test2");
    };
    
    multiLineRadioButtonCellModel1.expandable = true;
    
    
    multiLineRadioButtonCellModel1.avatarImage = [UIImage imageNamed:@"user"];
    
    
    tableCardModel.sectionData = question;
    
    tableCardModel.data = @[multiLineRadioButtonCellModel1,multiLineRadioButtonCellModel1,multiLineRadioButtonCellModel1];

    _tableCardView.cellCardView = [ExpandCellCardView new];
    _tableCardView.tableCardModelArray = @[tableCardModel,tableCardModel];
    
}

-(void)setupSimpleTextCardView{
    
    _simpleTextCardView.text = @"test test test test";
}
@end
