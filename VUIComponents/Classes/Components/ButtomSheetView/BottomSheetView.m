//
//  BottomSheetView.m
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BottomSheetView.h"
#import "BottomSheetTableViewCell.h"
#import "CreditCardViewModel.h"
#import "TableViewFooter.h"
#import <Languagehandlerpod/LanguageHandler.h>

@interface BottomSheetView ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *tableViewTitle;
@property (weak, nonatomic) IBOutlet UIView *holdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSheetTitleHeightConstraint;

@property (strong, nonatomic) UIViewController *viewController;
@property (weak, nonatomic) IBOutlet UIView *titleBGView;

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end
@implementation BottomSheetView


CGFloat durationTime = 0.5;

CGFloat fullView = 70 ;
#define partialView  [[UIScreen mainScreen ] bounds ].size.height - 360

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prepareForInit];
    
    if ([self.bottomSheetTitle length] > 0) {
        
        self.tableViewTitle.text = self.bottomSheetTitle;
        self.tableViewTitle.font = [UIFont fontWithName:@"regularFont" size:16.0];
        _bottomSheetTitleHeightConstraint.constant = 21;
        
    }else{
        _bottomSheetTitleHeightConstraint.constant = 0;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self prepareUI];
}

-(void) prepareForInit{
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    panRecognizer.delegate = self ;
    [self.view addGestureRecognizer:panRecognizer];
    
}

-(void) prepareUI{
    
    if (self.containerView.subviews.count > 0) {
        CGRect frame = self.containerView.subviews[0].frame;
        
        frame.size.height = (frame.size.height > self.containerView.frame.size.height) ? self.containerView.frame.size.height : frame.size.height;
        frame.origin = CGPointMake(0, 0);
        //        self.containerView.subviews[0].frame = frame;
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        CGRect frame = self.view.frame;
        
        self.view.frame = CGRectMake(0, fullView, frame.size.width, frame.size.height);
        NSLog(@"####self.view.frame.y = %f" ,self.view.frame.origin.y);
        NSLog(@"####self.view.frame.height = %f" ,self.view.frame.size.height);
        
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(20.0, 20.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    
    if ([self.bottomSheetTitle length] > 0) {
        
        self.titleBGView.layer.mask = maskLayer;
        
    }else{
        self.containerView.layer.mask = maskLayer;
    }
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.shadowView.bounds.origin.x , self.shadowView.bounds.origin.y, self.shadowView.bounds.size.width  , 100) byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(20.0, 20.0)];
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, -50.0f);
    self.shadowView.layer.shadowOpacity = 0.2f;
    self.shadowView.layer.shadowPath = shadowPath.CGPath;
    
}

-(void)panGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    CGFloat y = CGRectGetMinY(self.view.frame);
    
    if (( y + translation.y >= fullView) && (y + translation.y <= partialView)){
        CGRect aRect = CGRectMake(0, y + translation.y, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = aRect ;
        
        [recognizer setTranslation:CGPointZero inView:self.view];
        
    }else if (translation.y > 0 ){
        
        [self dismissView];
        
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ){
        //velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
        double duration = (velocity.y < 0)?(y - fullView)/ -velocity.y:(partialView - y)/velocity.y ;
        if (velocity.y < 0){
            duration = (y - fullView)/ -velocity.y ;
        }else {
            duration = (partialView - y)/velocity.y ;
        }
        if (duration > 1.3){
            duration = 1 ;
        }else{
            duration = duration ;
        }
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            if (velocity.y >= 0){
                CGRect aRect = CGRectMake(0, partialView , self.view.frame.size.width, self.view.frame.size.height);
                self.view.frame = aRect ;
            }else {
                CGRect aRect = CGRectMake(0, fullView, self.view.frame.size.width, self.view.frame.size.height);
                self.view.frame = aRect ;
            }
            
        } completion:^(BOOL finished) {
            if (velocity.y < 0){
                //                self.tableView.scrollEnabled = YES ;
            }
        }];
    }
}

-(void)showBottomSheetWithView:(UIView *)view andViewController:(UIViewController *)viewController onSuperView:(UIView *)superView{
    
    
    self.viewController = viewController ;
    [self.viewController addChildViewController:self];
    [superView addSubview:self.view];
    [self didMoveToParentViewController:self.viewController];
    CGFloat height = superView.frame.size.height;
    CGFloat width  = superView.frame.size.width;
    
    self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, width, [UIScreen mainScreen].bounds.size.height - fullView - 20);
    
    CGRect frame = view.frame;
    
    frame.size.height =  (frame.size.height > self.containerView.frame.size.height) ? self.containerView.frame.size.height : frame.size.height ;
    frame.origin = CGPointMake(0, 0);
    view.frame = frame;
    [self.containerView addSubview:view];
    
    //    [UIView animateWithDuration:durationTime animations:^{
    //
    //        self.view.frame = CGRectMake(0, CGRectGetMinY(self.view.frame), width, height);
    //    }];
}

-(void)dismissView {
    CGRect frame = self.view.frame ;
    frame.origin.y = [[UIScreen mainScreen ]bounds].size.height;
    
    [UIView animateWithDuration:durationTime animations:^{
        self.view.frame = frame ;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
    });
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    UIPanGestureRecognizer  *gesture = ((UIPanGestureRecognizer*)gestureRecognizer);
    CGPoint velocity = [gesture velocityInView:self.view];
    
    CGFloat direction = velocity.y ;
    CGFloat y = CGRectGetMinY(self.view.frame)  ;
    
    //    if((y == fullView && self.tableView.contentOffset.y == 0 && direction > 0) || (y == partialView)) {
    //        _tableView.scrollEnabled = NO ;
    //    }else {
    //        _tableView.scrollEnabled = YES ;
    //    }
    
    return false ;
}

@end
