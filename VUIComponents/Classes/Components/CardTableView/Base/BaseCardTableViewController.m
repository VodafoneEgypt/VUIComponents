//
//  BaseCardTableViewController.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardTableViewController.h"
#import "LanguageHandler.h"
@interface BaseCardTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableDictionary* heights;
    
    NSMutableDictionary* cells;
    
    BOOL navigationItemsAdded;
    
    UIButton* backButton;
    
    UIView *whiteBar;
    
    UIButton* sideMenuButton;
    
}

@end

@implementation BaseCardTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    whiteBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    whiteBar.backgroundColor = [UIColor whiteColor];
    
    whiteBar.alpha = 1;
    
    navigationItemsAdded = false;
    
    heights = [NSMutableDictionary new];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
    
    if(navigationItemsAdded == false){
        
        [self adjustNavigationItems];
    }
}
#pragma mark - public -

- (void)prepareCells{
    
    cells = [NSMutableDictionary new];
    
    self.cardsTableView.delegate = self;
    
    self.cardsTableView.dataSource = self;
    
    NSInteger numberOfSections = [self numberOfSectionsInTableView:self.cardsTableView];
    
    NSIndexPath* indexPath = nil;
    
    BaseCardTableViewCell* cell = nil;
    
    for (NSInteger j = 0; j<numberOfSections; j++) {
        
        NSInteger numberOfRows = [self tableView:self.cardsTableView numberOfRowsInSection:j];
        
        for (NSInteger i=0; i<numberOfRows; i++) {
            
            indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            
            cell = [self cellForRowAtIndexPath:indexPath];
            
            [cells setObject:cell forKey:[NSString stringWithFormat:@"%ld-%ld",(long)j,(long)i]];
            
            [self changeHeightTo:cell.card.frame.size.height forCellAtIndexPath:indexPath];
        }
    }
    
    [self.cardsTableView reloadData];
}

#pragma mark - setters

-(void) addNavigationBar{
    
    [self.view addSubview:whiteBar];
}

-(void)adjustNavigationItems{
    
    [self addNavigationBar];
    
    navigationItemsAdded = true;
    
    CGRect btnFrame;
    
    if(([LanguageHandler sharedInstance].currentLanguage == ARABIC)){
        
        btnFrame = CGRectMake(15, 15, 30, 25);
    }else{
        
        btnFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 30, 15, 30, 25);
    }
    
    sideMenuButton = [[UIButton alloc] initWithFrame:btnFrame];
    [sideMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [sideMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateHighlighted];
    [sideMenuButton addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteBar addSubview:sideMenuButton];
    
    if(self.navigationController.viewControllers.count > 1){
        
        if(([LanguageHandler sharedInstance].currentLanguage == ARABIC)){
            
            btnFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 30, 15, 30, 30);
        }else{
            
            btnFrame = CGRectMake(15, 15, 30, 30);
        }
        
        UIImage * backButtonImage = [UIImage imageNamed:([LanguageHandler sharedInstance].currentLanguage == ARABIC)?@"BlackBackArrow_AR":@"BlackBackArrow_EN"];
        
        backButton = [[UIButton alloc] initWithFrame:btnFrame];
        [backButton setImage:backButtonImage forState:UIControlStateNormal];
        [backButton setImage:backButtonImage forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [whiteBar addSubview:backButton];
    }
}

#pragma mark actions
-(void)back{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)hideNavigationBar{
    
    whiteBar.hidden = true;
}

-(void)openSideMenu{
    
}

#pragma mark should override

-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSException exceptionWithName:@"BaseCardTableViewController::cellForRowAtIndexPath" reason:@"should ovveride" userInfo:nil] raise];
    
    return [UITableViewCell new];
}

#pragma mark - CellHeightChangedDelegate
-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    if(oldHeight == nil ||
       oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] = [NSNumber numberWithFloat:height];
        
        [self.cardsTableView reloadData];
    }
}

#pragma mark table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] != nil){
        
        return [heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] floatValue] + _spacing;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [cells objectForKey:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
}

@end
