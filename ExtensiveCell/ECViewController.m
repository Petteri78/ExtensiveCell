//
//  ECViewController.m
//  ExtensiveCell
//
//  Created by Tanguy Hélesbeux on 02/11/2013.
//  Copyright (c) 2013 Tanguy Hélesbeux. All rights reserved.
//

#import "ECViewController.h"
#import "ExtensiveCellContainer.h"
#import "UITableView+Extensions.h"

@interface ECViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark Selection mecanism

- (BOOL)tableView:(UITableView *)tableView isSelectedIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath && tableView.selectedRowIndexPath)
    {
        if (indexPath.row == tableView.selectedRowIndexPath.row && indexPath.section == tableView.selectedRowIndexPath.section)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView isExtendedCellIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath && tableView.selectedRowIndexPath)
    {
        if (indexPath.row == tableView.selectedRowIndexPath.row + 1 && indexPath.section == tableView.selectedRowIndexPath.section)
        {
            return YES;
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (![self tableView:tableView isExtendedCellIndexPath:indexPath]) {
     
        [self tableView:tableView shouldExtendCellAtIndexPath:indexPath];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.selectedRowIndexPath && tableView.selectedRowIndexPath.section == section)
    {
        return [self tableView:tableView numberOfRowsForSection:section] + 1;
    }
    return [self tableView:tableView numberOfRowsForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *contentView = [self tableView:tableView viewForContainerAtIndexPath:indexPath];
    if ([self tableView:tableView isExtendedCellIndexPath:indexPath] && contentView) {
        return 2*contentView.frame.origin.y + contentView.frame.size.height;
    } else {
        return [self tableView:tableView heightForExtensiveCellAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView isExtendedCellIndexPath:indexPath])
    {
        NSString *identifier = [ExtensiveCellContainer reusableIdentifier];
        ExtensiveCellContainer *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell addContentView:[self tableView:tableView viewForContainerAtIndexPath:indexPath]];
        
        return cell;
        
    } else {
        
        UITableViewCell *cell = [self tableView:tableView extensiveCellForRowIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark ExtensiveCellDelegate

- (void)tableView:(UITableView *)tableView shouldExtendCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
        [tableView beginUpdates];
        
        if (tableView.selectedRowIndexPath)
        {
            if ([self tableView:tableView isSelectedIndexPath:indexPath])
            {
                NSIndexPath *tempIndexPath = tableView.selectedRowIndexPath;
                tableView.selectedRowIndexPath = nil;
                [self tableView:tableView removeCellBelowIndexPath:tempIndexPath];
            } else {
                NSIndexPath *tempIndexPath = tableView.selectedRowIndexPath;
                if (indexPath.row > tableView.selectedRowIndexPath.row) {
                    indexPath = [NSIndexPath indexPathForRow:(indexPath.row-1) inSection:indexPath.section];
                }
                tableView.selectedRowIndexPath = indexPath;
                [self tableView:tableView removeCellBelowIndexPath:tempIndexPath];
                [self tableView:tableView insertCellBelowIndexPath:indexPath];
            }
        } else {
            tableView.selectedRowIndexPath = indexPath;
            [self tableView:tableView insertCellBelowIndexPath:indexPath];
        }
        
        [tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView insertCellBelowIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:(indexPath.row+1) inSection:indexPath.section];
    NSArray *pathsArray = @[indexPath];
    [tableView insertRowsAtIndexPaths:pathsArray withRowAnimation:UITableViewRowAnimationTop];
}

- (void)tableView:(UITableView *)tableView removeCellBelowIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:(indexPath.row+1) inSection:indexPath.section];
    NSArray *pathsArray = @[indexPath];
    [tableView deleteRowsAtIndexPaths:pathsArray withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark ECTableViewDataSource default

- (UITableViewCell *)tableView:(UITableView *)tableView extensiveCellForRowIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_CELLS_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForContainerAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
