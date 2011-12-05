//
//  TimeScroller.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeScroller.h"

@implementation TimeScroller

@synthesize delegate = _delegate;

- (id)initWithDelegate:(id<TimeScrollerDelegate>)delegate {
    
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
    if (self) {

        _delegate = delegate;
        self.backgroundColor = [UIColor blackColor];
        
    }
    
    return self;
}

- (void)scrollViewDidScroll {

    if (!_tableView || !_scrollBar) {
        
        _tableView = [self.delegate tableViewForTimeScroller:self];
        
        self.frame = CGRectMake(CGRectGetWidth(_tableView.frame) - CGRectGetWidth(self.frame) - 10.0f, 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        for (id subview in [_tableView subviews]) {
            if ([subview isKindOfClass:[UIImageView class]]) {
        
                UIImageView *imageView = (UIImageView *)subview;
                if (imageView.frame.size.width == 7.0f) {
                    _scrollBar = imageView;
                }
            
            }
        }
        
    }
/*
    UIView *containerView = _tableView.superview;
    
    CGRect scrollBarFrame = _scrollBar.frame;
    CGRect selfFrame = self.frame;
    CGRect convertedScrollBarFrame = [_tableView convertRect:scrollBarFrame toView:containerView];
  */  
    //self.transform = CGAffineTransformMakeTranslation(0.0f, CGRectGetMidY(convertedScrollBarFrame) - (CGRectGetHeight(selfFrame) / 2));
    
    //self.frame = CGRectMake(CGRectGetMinX(selfFrame), CGRectGetMidY(convertedScrollBarFrame) - (CGRectGetHeight(selfFrame) / 2) , CGRectGetWidth(selfFrame), CGRectGetHeight(selfFrame));

    
}

@end
