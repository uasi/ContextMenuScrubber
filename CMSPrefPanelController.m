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
    [hiddenItemTable setDropRow:-1 dropOperation:NSTableViewDropOn];
    [hiddenItemTable registerForDraggedTypes:types];
    
    // Add empty string to show placeholder text prompting to right-click
    [itemArrayController addObject:@""];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [hiddenItemArrayController addObjects:[defaults arrayForKey:@"CMSHiddenItems"]];
}

- (void)showWindow:(id)sender
{
    [itemArrayController setSelectionIndexes:[NSIndexSet indexSet]];
    [hiddenItemArrayController setSelectionIndexes:[NSIndexSet indexSet]];
    [super showWindow:sender];
}

- (void)keyDown:(NSEvent *)event
{
    // On delete key pressed
    if ([event keyCode] == 51) {
        [hiddenItemArrayController removeObjectsAtArrangedObjectIndexes:[hiddenItemArrayController selectionIndexes]];
    }
}

@end
