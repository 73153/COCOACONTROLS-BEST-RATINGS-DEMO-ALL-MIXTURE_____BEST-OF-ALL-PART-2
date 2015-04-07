//
//  CalendarViewController.h
//  Party Kalauz
//
//  Created by Zsombor Fuszenecker on 3/24/15.
//  Copyright (c) 2015 Zsombor Fuszenecker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "CustomViewController.h"

@interface CalendarViewController : UIViewController<JTCalendarDataSource>{
    
    
}

@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendar *calendar;
@property (nonatomic, weak) CustomViewController* delegate;

@end
