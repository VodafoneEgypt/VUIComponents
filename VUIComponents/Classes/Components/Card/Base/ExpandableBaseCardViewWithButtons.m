//
//  ExpandableBaseCardViewWithButtons.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableBaseCardViewWithButtons.h"
#import "BaseCardView+Protected.h"

@implementation ExpandableBaseCardViewWithButtons

-(void)commonInit{
    
    self.expanded = false;
    _animationDeuration = 0;

}

- (void) initializeExpandedView{
    
//    expandedViewHeightConstraint.constant = 0;
    
//    expandedView.hidden = true;
}

- (void) initialize{
    
    [self initializeContentView];
    CGFloat totalHeight = contentViewHeight;

    if(self.buttons.count > 0){
        
        [self initializeButtonsView];
        
    }else{
        
        buttonsViewHeightConstraint.constant = 0;
    }
    
    buttonsView.hidden = !(self.buttons.count > 0);
    
    if(self.expanded == true){
        
        [self initializeExpandedView];
        
        totalHeight = contentViewHeight + expandedViewHeightConstraint.constant + buttonsViewHeightConstraint.constant;

    }else{
        
        totalHeight = contentViewHeight + buttonsViewHeightConstraint.constant;

    }
//    if(self.heightBlock != nil){
//        
//        self.heightBlock(totalHeight);
//    }else{
    
        NSLayoutConstraint *heightConstraint = nil;
        
        for (NSLayoutConstraint *constraint in self.constraints) {
            
            if(!(([constraint.firstItem isDescendantOfView:self] && (constraint.firstItem != self)) ||
                 ([constraint.secondItem isDescendantOfView:self] && (constraint.secondItem != self)))){
                
                heightConstraint = constraint;
                
                break;
                
            }
        }
        
    if(heightConstraint != nil){
        
        heightConstraint.constant = contentViewHeight;
        CGRect currentFrame = self.frame;
        currentFrame.size.height = totalHeight;
        
        [UIView animateWithDuration:_animationDeuration animations:^{
            self.frame = currentFrame;
            if(self.expanded == false){
                
                self->expandedViewHeightConstraint.constant = 0;
                [self->expandedView layoutIfNeeded];
            }
            heightConstraint.constant = totalHeight;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {}];
        
    }else{
        
        CGRect currentFrame = self.frame;
        
        currentFrame.size.height = totalHeight;
        [UIView animateWithDuration:_animationDeuration animations:^{
            
            self.frame = currentFrame;
            
        } completion:^(BOOL finished) {}];
    }
//    }
    
    if(self.heightDidChangedBlock != nil){
        self.heightDidChangedBlock(totalHeight);

    }
}

-(void)setExpanded:(BOOL)expanded{
    
    _expanded = expanded;
    
    [self initialize];
}

@end
