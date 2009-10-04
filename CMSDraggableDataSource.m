//
//  CMSDraggableDataSource.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/10/03.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "CMSDraggableDataSource.h"


@implementation CMSDraggableDataSource

- (BOOL)tableView:(NSTableView *)aTableView
       acceptDrop:(id <NSDraggingInfo>)info
              row:(NSInteger)row
    dropOperation:(NSTableViewDropOperation)operation
{
    NSArray *items = [[info draggingPasteboard] pasteboardItems];
    for (NSPasteboardItem *item in items) {
        NSString *s = [item stringForType:NSPasteboardTypeString];
        if (![[arrayController content] containsObject:s]) {
            [arrayController addObject:s];
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[arrayController content] forKey:@"CMSHiddenItems"];
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)aTableView validateDrop:(id < NSDraggingInfo >)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation
{
    return NSDragOperationCopy;
}

- (BOOL)tableView:(NSTableView *)aTableView
writeRowsWithIndexes:(NSIndexSet *)rowIndexes
     toPasteboard:(NSPasteboard *)pboard
{
    NSArray *texts = [[arrayController content] objectsAtIndexes:rowIndexes];
    [pboard writeObjects:texts];
    return YES;
}

@end
