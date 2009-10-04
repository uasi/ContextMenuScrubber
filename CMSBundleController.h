//
//  CMSBundleController.h
//  ContextMenuScrubber
//
//  Created by uasi on 09/09/04.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CMSBundleController : NSObject {
    IBOutlet NSWindowController *prefPanelController;
}

+ (NSMenuItem *)menuItemForMainMenu;

@end
