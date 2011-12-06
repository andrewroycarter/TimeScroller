//
//  TimeScroller.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeScroller.h"

#import <QuartzCore/QuartzCore.h>

@interface TimeScroller() {
    
    
}

- (void)updateDisplayWithCell:(UITableViewCell *)cell;
- (void)captureTableViewAndScrollBar;

@end


@implementation TimeScroller

#define kDistanceFromEdgeOfTableView -10.0f

@synthesize delegate = _delegate;

- (id)initWithDelegate:(id<TimeScrollerDelegate>)delegate {
    
    UIImage *background = [[UIImage imageNamed:@"timescroll_pointer"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 35.0f, 0.0f, 10.0f)];
    
    self = [super initWithImage:background];
    if (self) {
                
        self.frame = CGRectMake(0.0f, 0.0f, 80.0f, CGRectGetHeight(self.frame));
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeTranslation(abs(kDistanceFromEdgeOfTableView), 0.0f);
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 4.0f, 50.0f, 20.0f)];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.shadowColor = [UIColor blackColor];
        _timeLabel.shadowOffset = CGSizeMake(-0.5f, -0.5f);
        _timeLabel.text = @"6:00 PM";
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:9.0f];
        _timeLabel.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:_timeLabel];
        [_timeLabel release];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 9.0f, 100.0f, 20.0f)];
        _dateLabel.textColor = [UIColor colorWithRed:179.0f green:179.0f blue:179.0f alpha:0.60f];
        _dateLabel.shadowColor = [UIColor blackColor];
        _dateLabel.shadowOffset = CGSizeMake(-0.5f, -0.5f);
        _dateLabel.text = @"6:00 PM";
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:9.0f];
        _dateLabel.alpha = 0.0f;
        [self addSubview:_dateLabel];
        [_dateLabel release];
        
        _delegate = delegate;
        
    }
    
    return self;
}

- (void)captureTableViewAndScrollBar {
    
    _tableView = [self.delegate tableViewForTimeScroller:self];
    
    self.frame = CGRectMake(kDistanceFromEdgeOfTableView - CGRectGetWidth(self.frame) , 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    for (id subview in [_tableView subviews]) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            
            UIImageView *imageView = (UIImageView *)subview;
            if (imageView.frame.size.width == 7.0f) {
                
                imageView.clipsToBounds = NO;
                [imageView addSubview:self];
                _scrollBar = imageView;
                
            }
            
        }
    }
    
}

- (void)updateDisplayWithCell:(UITableViewCell *)cell {
    
    NSDate *date = [self.delegate dateForCell:cell];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:today];
    
    if (dateComponents.year == todayComponents.year && dateComponents.month == todayComponents.month && dateComponents.day == todayComponents.day) {

        _dateLabel.text = @"";

        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{

            self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 80.0f, CGRectGetHeight(self.frame));
            _timeLabel.frame = CGRectMake(30.0f, 4.0f, 100.0f, 20.0f);
            _dateLabel.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
    
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
            
            _timeLabel.frame = CGRectMake(30.0f, 4.0f, 100.0f, 10.0f);
            
            if (dateComponents.year == todayComponents.year && dateComponents.weekOfYear == todayComponents.weekOfYear && dateComponents.day + 1 == todayComponents.day) {
                
                _dateLabel.text = @"Yesterday";
                _dateLabel.alpha = 1.0f;
                self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 85.0f, CGRectGetHeight(self.frame));
                
            }
            
        } completion:^(BOOL finished) {
            
        }];
    
    }
    
    
}

- (void)scrollViewDidScroll {
    
    if (!_tableView || !_scrollBar) {
        
        [self captureTableViewAndScrollBar];
        
    }
    
    CGRect selfFrame = self.frame;
    CGRect scrollBarFrame = _scrollBar.frame;
    
    self.frame = CGRectMake(kDistanceFromEdgeOfTableView - CGRectGetWidth(selfFrame),
                            (CGRectGetHeight(scrollBarFrame) / 2.0f) - (CGRectGetHeight(selfFrame) / 2.0f),
                            CGRectGetWidth(selfFrame),
                            CGRectGetHeight(selfFrame));
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    point = [_scrollBar convertPoint:point toView:_tableView];
    
    UIView *view = [_tableView hitTest:point withEvent:UIEventTypeTouches];
    
    if ([view.superview isKindOfClass:[UITableViewCell class]]) {
        
        [self updateDisplayWithCell:(UITableViewCell *)view.superview];
        
    }
    
}

- (void)scrollViewDidEndDecelerating {
    
    CGRect newFrame = [_scrollBar convertRect:self.frame toView:_tableView.superview];
    self.frame = newFrame;
    [_tableView.superview addSubview:self];
    
    [UIView animateWithDuration:0.3f delay:1.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeTranslation(abs(kDistanceFromEdgeOfTableView), 0.0f);
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)scrollViewWillBeginDragging {
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.alpha = 1.0f;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [_scrollBar addSubview:self];
    
}

@end
