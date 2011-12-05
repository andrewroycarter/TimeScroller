//
//  RootViewController.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        _datasource = [NSMutableArray new];
        
        for (int i = 0; i < 30; i++) {
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:@"Title here" forKey:@"title"];
            [_datasource addObject:dictionary];

            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.year = 2011;
            components.month = 10;
            components.day = i;
            
            NSDate *date = [calendar dateFromComponents:components];
            [dictionary setObject:date forKey:@"date"];
            
        }
        
    }

    return self;
}

- (void)dealloc {
    
    [_datasource release];
    
    [super dealloc];

}

- (void)viewDidLoad {

    _timeScroller = [[TimeScroller alloc] initWithDelegate:self];
    [self.view addSubview:_timeScroller];
    [_timeScroller release];

}

- (void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"lol");
}

#pragma mark TimeScrollerDelegate Methods

- (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller {

    return _tableView;

}

- (NSDate *)dateForCell:(UITableViewCell *)cell {
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSDate *date = [dictionary objectForKey:@"date"];
    
    return date;
    
}

#pragma mark UIScrollViewDelegateMethods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_timeScroller scrollViewDidScroll];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [_timeScroller scrollViewDidEndDecelerating];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [_timeScroller scrollViewWillBeginDragging];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
    
        [_timeScroller scrollViewDidEndDecelerating];
    
    }
    
}

#pragma mark UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_datasource count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *identifier = @"TableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
    
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    
    }
    
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSString *title = [dictionary objectForKey:@"title"];
    cell.textLabel.text = title;
    
    NSDate *date = [dictionary objectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return cell;
}

@end
