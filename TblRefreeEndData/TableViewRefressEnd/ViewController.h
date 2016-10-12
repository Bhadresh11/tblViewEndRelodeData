//
//  ViewController.h
//  TableViewRefressEnd
//
//  Created by Bhadresh Patel on 12/10/16.
//  Copyright © 2016 Bhadresh Patoliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface ViewController : UIViewController
{
    NSMutableArray *items;
    IBOutlet UITableView *tblView;
    NSInteger count;
}

@end

