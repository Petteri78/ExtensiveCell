//
//  UITableView+Extensions.m
//  Comfort
//
//  Created by Petteri on 2013-11-19.
//
//

#import "UITableView+Extensions.h"
#import <objc/runtime.h>

static char SELECTED_KEY;

@implementation UITableView (Extensions)

@dynamic selectedRowIndexPath;

-(NSString*)selectedRowIndexPath{
    return objc_getAssociatedObject(self, &SELECTED_KEY);
}

-(void)setSelectedRowIndexPath:(NSIndexPath *)selectedRowIndexPath{
    objc_setAssociatedObject(self, &SELECTED_KEY, selectedRowIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
