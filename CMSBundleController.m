//
//  CMSBundleController.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/09/04.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "CMSBundleController.h"

#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import "CMSPrefPanelController.h"


id cms_webView_contextMenuItemsForElement_defaultItems(id self,
                                                       SEL _cmd,
                                                       WebView *sender,
                                                       NSDictionary *element,
                                                       NSArray *defaultMenuItems)
{
    NSArray *menuItems = [self cms_webView:sender
                contextMenuItemsForElement:element
                          defaultMenuItems:defaultMenuItems];
    NSMutableArray *newMenuItems = [NSMutableArray array];
    [[[CMSPrefPanelController sharedController] itemArrayController] prepareContent];
    for (NSMenuItem *item in menuItems) {
        if (item == [NSMenuItem separatorItem]) { continue; }
        [[[CMSPrefPanelController sharedController] itemArrayController] addObject:[item title]];
        // TODO: remove items
        [newMenuItems addObject:item];
    }
    return newMenuItems;
}
    

@implementation CMSBundleController

+ (void)load
{
    Class cls = objc_getClass("BrowserWebView");
    class_addMethod(cls,
                    @selector(cms_webView:contextMenuItemsForElement:defaultMenuItems:),
                    (IMP)cms_webView_contextMenuItemsForElement_defaultItems,
                    "@@:@@@");
    Method orig = class_getInstanceMethod(cls, @selector(webView:contextMenuItemsForElement:defaultMenuItems:));
    Method alt = class_getInstanceMethod(cls, @selector(cms_webView:contextMenuItemsForElement:defaultMenuItems:));
    method_exchangeImplementations(orig, alt);
    
    [[NSApp mainMenu] addItem:[[self class] menuItemForMainMenu]];
    
    NSLog(@"ContextMenuScrubber loaded");
}


+ (NSMenuItem *)menuItemForMainMenu
{
    NSMenu *submenu = [[NSMenu alloc] initWithTitle:@"CMS"];
    [submenu autorelease];
    [submenu addItemWithTitle:@"Preferences..."
                       action:@selector(showWindow:)
                keyEquivalent:@""];
    [[submenu itemAtIndex:0]
     setTarget:[CMSPrefPanelController sharedController]];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"CMS"
                                                  action:NULL
                                           keyEquivalent:@""];
    [item autorelease];
    [item setSubmenu:submenu];
    return item;
}

@end
