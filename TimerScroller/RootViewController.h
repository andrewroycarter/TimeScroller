//
//  RootViewController.h
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.

#import <UIKit/UIKit.h>

#import "TimeScroller.h"

@interface RootViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, TimeScrollerDelegate> {

    UITableView *_tableView;
    NSMutableArray *_datasource;
    TimeScroller *_timeScroller;
    
}

@end
