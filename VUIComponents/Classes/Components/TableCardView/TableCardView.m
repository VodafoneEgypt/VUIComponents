//
//  TableCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "TableCardView.h"
#import <VUIComponents/LanguageHandler.h>
#import <VUIComponents/Utilities.h>
#import "BaseCardView+Protected.h"
#import "TableCardModel.h"
#import "BaseTableCell.h"

@interface TableCardView ()<UITableViewDelegate,UITableViewDataSource,CellHeightChangedDelegate>{
    
    NSMutableDictionary* cellsHeights;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableCardView

-(void)setTableCardModelArray:(NSArray *)tableCardModelArray{
    
    _tableCardModelArray = tableCardModelArray;
    
    [_tableView reloadData];
    
    [self initialize];
}

#pragma mark - CellHeightChangedDelegate

-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = cellsHeights[[NSString stringWithFormat:@"%@",indexPath]];
    
    NSLog(@"old height %f and new Height %f",oldHeight.floatValue, height);
    
    if(oldHeight == nil || oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        NSLog(@"forCellAtIndexPath %@",indexPath);
        
        cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] = [NSNumber numberWithFloat:height];
        
        [self.tableView reloadData];
//        [self initialize];

    }
    
    [self initialize];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] != nil){
        
        return [cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] floatValue];
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"%lu", (unsigned long)_tableCardModelArray.count);
    return _tableCardModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"dmlkmdmlkvfmld");
    NSLog(@"TableCount: @%lu", (unsigned long)((TableCardModel*)(_tableCardModelArray[section])).data.count);
    return ((TableCardModel*)(_tableCardModelArray[section])).data.count;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"willSelectRowAtIndexPath  %ld", (long)indexPath.row); // you can see selected row number in your console;

    if(self.selectionIndexPathBlock != nil){
        
        self.selectionIndexPathBlock(indexPath);
    }
    if (self.allowSelection == false) {
        [tableView selectRowAtIndexPath:self.selectedIndexPath animated:false scrollPosition:UITableViewScrollPositionNone];
        
        return self.selectedIndexPath;
    }else{
        
        return indexPath;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath  %ld", (long)indexPath.row); // you can see selected row number in your console;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"BaseTableCell";
    
    BaseTableCell *cell = (BaseTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        
        [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    cell.indexPath = indexPath;
    
    if(cell.cellCardView == nil){
        
        NSLog(@"allocate new card for index %ld",(long)indexPath.row);
        
        cell.heightChangeDelegate = self;
        
        BaseCellCardView *baseCellCardView = [[_cellCardView class] new];
        
        cell.cellCardView = baseCellCardView;
        
        cell.width = self.frame.size.width;
        
        cell.cellCardView.model =  ((TableCardModel*)(_tableCardModelArray[indexPath.section])).data[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    
    _selectedIndexPath = selectedIndexPath;
    
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:true scrollPosition:UITableViewScrollPositionNone];    
}

-(void)initializeContentView{
    
    contentViewHeight = 1000;
    if (cellsHeights.count > 0){
        
        contentViewHeight = (self.buttons)?16:2;
    }
        for (int row = 0; row<cellsHeights.count; row++) {
            
            contentViewHeight += [cellsHeights[[NSString stringWithFormat:@"%@",[NSIndexPath indexPathForRow:row inSection:0]]] floatValue];
            
            self.heightDidChangedBlock(contentViewHeight);
        }
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle mainBundle]loadNibNamed:@"TableCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.scrollEnabled = false;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _allowSelection = true;
    cellsHeights = [NSMutableDictionary new];
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}

@end
