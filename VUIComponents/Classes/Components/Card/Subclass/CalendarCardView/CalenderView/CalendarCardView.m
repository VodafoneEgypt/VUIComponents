//
//  CalendarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/11/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "CalendarCardView.h"
#import "BaseCardView+Protected.h"
#import "FSCalendar.h"
#import "UIColor+Hex.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface CalendarCardView()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (weak, nonatomic) IBOutlet UIButton *nextYearButton;
@property (weak, nonatomic) IBOutlet UIButton *previousYearButton;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleBottomConsrtraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConsrtaint;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;

@end

@implementation CalendarCardView

#pragma mark setter

-(void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    _titleLabel.txt = titleString;
}

-(void)setSubTitleString:(NSString *)subTitleString {
    _subTitleString = subTitleString;
    _subTitleLabel.txt = subTitleString;
}

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    _titleAttributedString = titleAttributedString;
    
    _titleLabel.attributedText = titleAttributedString;
    
    _titleTopConsrtaint.constant = 20;
}

-(void)setSubTitleAttributedString:(NSAttributedString *)subTitleAttributedString{
    
    _subTitleAttributedString = subTitleAttributedString;
    
    _subTitleLabel.attributedText =subTitleAttributedString;
    _subTitleTopConstraint.constant = 15;
    _subTitleBottomConsrtraint.constant = 20;
}

-(void)setDateFormat:(NSString *)dateFormat{
    
    _dateFormat = dateFormat;
    
    self.dateFormatter1.dateFormat = _dateFormat;
    self.dateFormatter2.dateFormat = _dateFormat;
    [self initialize];
    
    [_calendar reloadData];
    
}

-(void)setAvailableDates:(NSArray<NSString *> *)availableDates{
    
    _availableDates = availableDates;
    
    [self.calendar selectDate:[self.dateFormatter1 dateFromString:[availableDates firstObject]] scrollToDate:YES];
    
    [_calendar reloadData];
}

-(void)setSelectYear:(NSString *)selectYear{
    
    NSString *date;

    date = [_dateFormat stringByReplacingOccurrencesOfString:@"yyyy" withString:selectYear];
   
    date = [date stringByReplacingOccurrencesOfString:@"MM"
                                                             withString:@"01"];
    date = [date stringByReplacingOccurrencesOfString:@"dd"
                                                             withString:@"01"];
    [self.calendar selectDate:[self.dateFormatter1 dateFromString:date] scrollToDate:YES];

    [_calendar reloadData];
}

-(void)setMaximumDateForCalendar:(NSString *)maximumDateForCalendar{
    
    _maximumDateForCalendar = maximumDateForCalendar;
    
    [_calendar reloadData];
    
}

-(void)setMinimumDateForCalendar:(NSString *)minimumDateForCalendar{
    
    _minimumDateForCalendar = minimumDateForCalendar;
    
    [_calendar reloadData];
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"CalendarCardView" owner:self options:nil] firstObject];
    
    self.bounds = view.frame;
    
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    
    self.calendar.accessibilityIdentifier = @"calendar";
    
    _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    
    _calendar.allowsMultipleSelection = NO;
    _calendar.delegate = self;
    _calendar.dataSource = self;
    _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;

    [self addSubview:view];
    self.previousYearButton.layer.cornerRadius = 9;
    
    self.nextYearButton.layer.cornerRadius = 9;
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter1 dateFromString:_minimumDateForCalendar];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter1 dateFromString:_maximumDateForCalendar];
}


#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if (_availableDates) {
        BOOL shouldSelect = [_availableDates containsObject:[self.dateFormatter1 stringFromDate:date]];
        if (!shouldSelect) {
            
            NSLog(@"Unavailable Date %@",[self.dateFormatter1 stringFromDate:date]);
            //        [[[UIAlertView alloc] initWithTitle:@"Sorry"
            //                                    message:[NSString stringWithFormat:@"the date : %@ unavailable ",[self.dateFormatter1 stringFromDate:date]]
            //                                   delegate:nil
            //                          cancelButtonTitle:@"OK"
            //                          otherButtonTitles:nil, nil] show];
        } else {
            NSLog(@"Should select date %@",[self.dateFormatter1 stringFromDate:date]);
        }
        return shouldSelect;
    }else{
        
        return true;
    }
}

-(NSDate *)selectedDate{
    
    return [_calendar selectedDate];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date");
    
    _selectedDateBlock(date);
    
    [self.dateFormatter1 stringFromDate:date];
    
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{

    
    NSLog(@"did change to page");
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    // Do other updates here
    [self layoutIfNeeded];
    [self layoutIfNeeded];
}

//- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleOffsetForDate:(NSDate *)date
//{
//    if ([self calendar:calendar subtitleForDate:date]) {
//        return CGPointZero;
//    }
//    if ([_datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
//        return CGPointMake(0, -2);
//    }
//    return CGPointZero;
//}

//- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventOffsetForDate:(NSDate *)date
//{
//    if ([self calendar:calendar subtitleForDate:date]) {
//        return CGPointZero;
//    }
//    if ([_datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
//        return CGPointMake(0, -10);
//    }
//    return CGPointZero;
//}
//
//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventSelectionColorsForDate:(nonnull NSDate *)date
//{
//    if ([self calendar:calendar subtitleForDate:date]) {
//        return @[appearance.eventDefaultColor];
//    }
//    if ([_datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
//        return @[[UIColor whiteColor]];
//    }
//    return nil;
//}

#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_availableDates containsObject:key]) {
        return [UIColor colorWithCSS:@"cfcfcf"];
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame andCalendarHeight:(CGFloat)calendarHeight{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        _calendarHeightConstraint.constant = calendarHeight;
    }
    return self;
}
- (IBAction)previousYearAction:(id)sender {
    
    NSDate *date = self.calendar.selectedDate;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;

    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self.calendar.selectedDate];
    [comps setYear:[comps year] - 1];
    date = [gregorian dateFromComponents:comps];
    if ( [date compare:self.calendar.minimumDate] == NSOrderedDescending) {
        
        [self.calendar selectDate:date scrollToDate:YES];
        
        [_calendar reloadData];
    }

}
- (IBAction)nextYearAction:(id)sender {
    
    NSDate *date = self.calendar.selectedDate;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self.calendar.selectedDate];
    [comps setYear:[comps year] + 1];
    date = [gregorian dateFromComponents:comps];
    if ( [date compare:self.calendar.maximumDate] == NSOrderedAscending) {
        
        [self.calendar selectDate:date scrollToDate:YES];
        
        [_calendar reloadData];
    }
    
}
@end
