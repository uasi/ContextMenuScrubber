//
//  CMSDraggableDataSource.h
//  ContextMenuScrubber
//
//  Created by uasi on 09/10/03.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CMSDraggableDataSource : NSObject <NSTableViewDataSource> {
    IBOutlet NSArrayController *arrayController;
}

@end
