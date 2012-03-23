TimeScroller
============

![Screenshot: Launch image](https://github.com/andrewroycarter/TimeScroller/raw/master/screenshot.png)

About
-----

TimeScroller is an effort to reproduce the nifty view that hovers beside the scroll bar in the Path app. 

Usage
-----

In a UIViewController that contains a UITableView simply create a new TimeScroller object
    _timeScroller = [[Timescroller alloc] initWithDelegate:self];
And conform to the TimeScrollerDelegate protocol

    //The UITableView that you'd like the TimeScroller to be in
    - (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller {
        return _myTableView;
      }

    //The date for a given cell
    - (NSDate *)dateForCell:(UITableViewCell *)cell {
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
        NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
        NSDate *date = [dictionary objectForKey:@"date"];
        return date;                        
    }

And let the TimeScroller know what's happening with the UITableView by using UIScrollViewDelegate

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

Other Credit
------------

Thanks to Path for making great new UI and moving the bar higher.
Thanks to @bsirach for helping with design!
Also thanks to everyone who has contributed bug fixes and features to the project!


License
-------

Copyright (c) 2011 Andrew Roy Carter

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
