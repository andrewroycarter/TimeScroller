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

#pragma mark UIScrollViewDelegateMethods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_timeScroller scrollViewDidScroll];
    
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
    
    return cell;
}

@end
