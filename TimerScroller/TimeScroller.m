//
//  TimeScroller.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeScroller.h"

@implementation TimeScroller

#define kDistanceFromEdgeOfTableView -80.0f

@synthesize delegate = _delegate;

- (id)initWithDelegate:(id<TimeScrollerDelegate>)delegate {
    
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
    if (self) {

        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = UITextAlignmentCenter;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        _dateLabel.minimumFontSize = 12.0f;
        [self addSubview:_dateLabel];
        [_dateLabel release];
        self.alpha = 0.0f;
        
    }
    
    return self;
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
        
        _tableView = [self.delegate tableViewForTimeScroller:self];
        
        self.frame = CGRectMake(kDistanceFromEdgeOfTableView, 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
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
    
    CGRect selfFrame = self.frame;
    CGRect scrollBarFrame = _scrollBar.frame;
    
    self.frame = CGRectMake(kDistanceFromEdgeOfTableView,
                            (CGRectGetHeight(scrollBarFrame) / 2.0f) - (CGRectGetHeight(selfFrame) / 2.0f),
                            CGRectGetWidth(selfFrame),
                            CGRectGetHeight(selfFrame));
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    point = [self convertPoint:point toView:_tableView];

    point.y -= 44;
    
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
    } completion:^(BOOL finished) {
        
    }];

}


- (void)scrollViewWillBeginDragging {
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
    
    [_scrollBar addSubview:self];
    
}

@end
