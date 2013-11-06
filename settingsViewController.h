//
//  settingsViewController.h
//  Scoala
//
//  Created by CLEVERSOFT-2 on 11/6/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "database.h"

@interface settingsViewController : UIViewController
            <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *NumeCopii;
@property (strong, nonatomic) NSArray *IdCopii;

@end
