//
//  CMSPrefPanelController.h
//  ContextMenuScrubber
//
//  Created by uasi on 09/10/03.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CMSPrefPanelController : NSWindowController {
    IBOutlet NSArrayController *itemArrayController;
    IBOutlet NSArrayController *hiddenItemArrayController;
    IBOutlet NSTableView *itemTable;
    IBOutlet NSTableView *hiddenItemTable;
}

@property(retain) NSArrayController *itemArrayController;
@property(retain) NSArrayController *hiddenItemArrayController;

+ (id)sharedController;

@end
