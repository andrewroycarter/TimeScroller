//
//  TimeScroller.h
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeScroller;

@protocol TimeScrollerDelegate <NSObject>

@required

- (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller;

@end

@interface TimeScroller : UIView {

    id <TimeScrollerDelegate> _delegate;
    UITableView *_tableView;
    UIImageView *_scrollBar;

}

@property (nonatomic, assign) id <TimeScrollerDelegate> delegate;

- (id)initWithDelegate:(id <TimeScrollerDelegate>)delegate;
- (void)scrollViewDidScroll;

@end
