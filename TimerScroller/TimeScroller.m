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
    
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
    if (self) {
        
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 6.0f;
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeTranslation(abs(kDistanceFromEdgeOfTableView), 0.0f);
        self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        self.layer.borderWidth = 1.0f;
        
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = UITextAlignmentCenter;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        _dateLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
        _dateLabel.minimumFontSize = 12.0f;
        _dateLabel.shadowColor = [UIColor blackColor];
        _dateLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
        [self addSubview:_dateLabel];
        [_dateLabel release];
        
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    _dateLabel.text = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
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
