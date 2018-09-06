//
//  CustomDropDownStyleModel.m
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import "CustomDropDownStyleModel.h"

@implementation CustomDropDownStyleModel

-(id) initWithStyleFilePath:(NSString*) styleFilePath{
    
    self = [self init];
    
    if(self){
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:styleFilePath ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *customDropDown = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.fontFamily = customDropDown[@"fontFamily"];
        
        self.fontSize = [customDropDown[@"fontSize"] intValue];

        self.backgroundColor = customDropDown[@"backgroundColor"];
        
        self.titleColor = customDropDown[@"titleColor"];
        
        self.borderColor = customDropDown[@"borderColor"];
        
        self.borderWidth = [customDropDown[@"borderWidth"] floatValue];
        
        self.cornerRadius = [customDropDown[@"borderRadius"] floatValue];
    }
    
    return self;
}

@end
