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
- (NSDate *)dateForCell:(UITableViewCell *)cell;

@end

@interface TimeScroller : UIImageView {

    @protected
    id <TimeScrollerDelegate> _delegate;
    UITableView *_tableView;
    UIImageView *_scrollBar;
    UILabel *_timeLabel;
    UILabel *_dateLabel;
    UIImageView *_backgroundView;
    UIView *_handContainer;
    UIView *_hourHand;
    UIView *_minuteHand;
    NSDate *_lastDate;
    
}

@property (nonatomic, assign) id <TimeScrollerDelegate> delegate;

- (id)initWithDelegate:(id <TimeScrollerDelegate>)delegate;
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDecelerating;
- (void)scrollViewWillBeginDragging;

@end
