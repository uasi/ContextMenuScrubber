//
//  CMSPrefPanelController.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/10/03.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "CMSPrefPanelController.h"


@implementation CMSPrefPanelController

@synthesize itemArrayController;
@synthesize hiddenItemArrayController;

+ (id)sharedController
{
    static CMSPrefPanelController *instance;
    if (instance == nil) {
        instance = [[[self class] alloc] initWithWindowNibName:@"PrefPanel"];
    }
    // Refer window to create array controllers
    // (The creation of them defers until the window is refered)
    [instance window];
     return instance;
}

- (void)awakeFromNib
{
    NSArray *types = [NSArray arrayWithObject:NSPasteboardTypeString];
    [itemTable registerForDraggedTypes:types];
    [hiddenItemTable registerForDraggedTypes:types];
}

@end
