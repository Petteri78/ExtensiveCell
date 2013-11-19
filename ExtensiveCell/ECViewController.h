//
//  ECViewController.h
//  ExtensiveCell
//
//  Created by Tanguy Hélesbeux on 02/11/2013.
//  Copyright (c) 2013 Tanguy Hélesbeux. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAIN_CELLS_HEIGHT 44

@protocol ECTableViewDataSource <NSObject>

/*****
 
 Similar to tableView:cellForRowAtIndexPath: from UITableViewDataSource.
 
 Asks the data source for a cell to insert in a particular location of the table view. (required)
 The returned ExtensiveCell object is frequently one that the application reuses for performance reasons.
 You should fetch a previously created cell object that is marked for reuse by sending a dequeueReusableCellWithIdentifier: message to tableView.
 
 The container displayed do not interfer with the indexPath.
 ECViewController manages the indexPath when you open/close a row. ECViewController will call viewForContainerAtIndexPath: to get the container view.
 
 *****/
- (UITableViewCell *)tableView:(UITableView *)tableView extensiveCellForRowIndexPath:(NSIndexPath *)indexPath;



/*****
 
 Asks the data source for a view to fill in a the container when selecting a row.
 You should fetch a previously created view object for performance reasons.
 
 The ECViewcontroller tableview only has one container and reuses it.
 
 *****/
- (UIView *)tableView:(UITableView *)tableView viewForContainerAtIndexPath:(NSIndexPath *)indexPath;

@optional

/*****
 
 Similar to tableView:heightForRowAtIndexPath: from UITableViewDelegate.
 
 Must return the height for the row at indexPath.
 
 The container displayed do not interfer with the indexPath.
 ECViewController manages the indexPath when you open/close a row. ECViewController will size the container to fit its given view.
 
 *****/
- (CGFloat)tableView:(UITableView *)tableView heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath;

/*****
 
 Similar to tableview:numberOfRowsInSection: frm UITableViewDataSource.
 
 Do not consider the container (open or closed) when calculating the number of rows.
 
 *****/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsForSection:(NSInteger)section;

@end

@interface ECViewController : UIViewController <ECTableViewDataSource>

@end

