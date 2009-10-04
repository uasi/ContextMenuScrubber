//
//  CMSDraggableDataSource.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/10/03.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "CMSDraggableDataSource.h"


@implementation CMSDraggableDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [[arrayController content] count];
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex
{
    return [[arrayController content] objectAtIndex:rowIndex];
}

- (BOOL)tableView:(NSTableView *)aTableView
       acceptDrop:(id <NSDraggingInfo>)info
              row:(NSInteger)row
    dropOperation:(NSTableViewDropOperation)operation
{
    NSArray *pboardItems = [[info draggingPasteboard] pasteboardItems];
    for (NSPasteboardItem *item in pboardItems) {
        [arrayController addObject:[item stringForType:NSPasteboardTypeString]];
    }
    return YES;
}

- (BOOL)tableView:(NSTableView *)aTableView
writeRowsWithIndexes:(NSIndexSet *)rowIndexes
     toPasteboard:(NSPasteboard *)pboard
{
    NSMutableArray *pboardItems = [NSMutableArray array];
    for (NSString *s in [[arrayController content] objectsAtIndexes:rowIndexes]) {
        NSPasteboardItem *item = [[[NSPasteboardItem alloc] init] autorelease];
        [item setString:s forType:NSPasteboardTypeString];
        [pboardItems addObject:item];
    }
    return [pboard writeObjects:pboardItems];
}

@end
