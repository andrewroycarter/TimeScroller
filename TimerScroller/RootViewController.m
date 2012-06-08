//
//  RootViewController.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.

#import "RootViewController.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        //There is no need to add the TimeScroller as a subview.
        _timeScroller = [[TimeScroller alloc] initWithDelegate:self];
        
        //This is just junk data to be displayed.
        _datasource = [NSMutableArray new];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSDate *today = [NSDate date];
        NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
        
        for (int i = todayComponents.day; i >= -15; i--) {
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:@"Title here" forKey:@"title"];
            
            components.year = todayComponents.year;
            components.month = todayComponents.month;
            components.day = i;
            components.hour = arc4random() % 23;
            components.minute = arc4random() % 59;
            
            NSDate *date = [calendar dateFromComponents:components];
            [dictionary setObject:date forKey:@"date"];
            
            [_datasource addObject:dictionary];
            
        }
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }

    return self;
}


- (void)loadView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
    
    [view addSubview:_tableView];
    
    self.view = view;
    
}

#pragma mark TimeScrollerDelegate Methods

//You should return your UITableView here
- (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller {

    return _tableView;

}

//You should return an NSDate related to the UITableViewCell given. This will be
//the date displayed when the TimeScroller is above that cell.
- (NSDate *)dateForCell:(UITableViewCell *)cell {
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSDate *date = [dictionary objectForKey:@"date"];
    
    return date;
    
}

#pragma mark UIScrollViewDelegateMethods


//The TimeScroller needs to know what's happening with the UITableView (UIScrollView)
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
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    }
    
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSString *title = [dictionary objectForKey:@"title"];
    cell.textLabel.text = title;
    
    NSDate *date = [dictionary objectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    
    return cell;
    
}

@end
