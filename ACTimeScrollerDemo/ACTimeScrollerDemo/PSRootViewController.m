//
//  PSRootViewController.m
//  ACTimeScrollerDemo
//
//  Created by Andrew Carter on 4/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import "PSRootViewController.h"

#import "ACTimeScroller.h"

NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";

@interface PSRootViewController () <ACTimeScrollerDelegate>
{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;
}

@end

@implementation PSRootViewController

#pragma mark - UITableViewController Overrides

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setupDatasource];
    }
    return self;
}

- (void)viewDidLoad
{
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
}

#pragma mark - Instance Methods

- (void)setupDatasource
{
    _datasource = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    for (NSInteger i = [todayComponents day]; i >= -15; i--)
    {
        [components setYear:[todayComponents year]];
        [components setMonth:[todayComponents month]];
        [components setDay:i];
        [components setHour:arc4random() % 23];
        [components setMinute:arc4random() % 59];
        
        NSDate *date = [calendar dateFromComponents:components];
        [_datasource addObject:date];
    }
}

#pragma mark - ACTimeScrollerDelegate Methods

- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}

- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath row]];
}

#pragma mark - UITableViewDatasource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PSTableViewCellIdentifier];
    
    NSDate *date = _datasource[[indexPath row]];
    [[cell textLabel] setText:[date description]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datasource count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewWillBeginDragging];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewDidEndDecelerating];
}

@end
