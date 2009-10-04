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


@interface NSObject (ContextMenuScrubberPrivateMethods)
- (NSArray *)cms_webView:(WebView *)sender
contextMenuItemsForElement:(NSDictionary *)element
        defaultMenuItems:(NSArray *)defaultMenuItems;
@end

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
    [[[[CMSPrefPanelController sharedController] itemArrayController] content] removeAllObjects];
    for (NSMenuItem *item in menuItems) {
        NSString *title = [item title];
        if ([title isEqualToString:@""]) {
            continue;
        }
        [[[CMSPrefPanelController sharedController] itemArrayController] addObject:title];
        if (![[[[CMSPrefPanelController sharedController] hiddenItemArrayController] content] containsObject:title]) {
            [newMenuItems addObject:item];
        }
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
    
    NSMenu *safariMenu = [[[NSApp mainMenu] itemAtIndex:0] submenu];
    // Insert menu item next to "Preferences..."
    for (NSUInteger i = 0; i < [[safariMenu itemArray] count]; i++) {
        if ([[safariMenu itemAtIndex:i] isSeparatorItem]) {
            [safariMenu insertItem:[[self class] menuItemForMainMenu]
                           atIndex:(i + 2)];
            break;
        }
    }
    
    NSLog(@"ContextMenuScrubber loaded");
}


+ (NSMenuItem *)menuItemForMainMenu
{
    NSString *title = NSLocalizedStringFromTableInBundle(@"Edit context menu...",
                                                         @"",
                                                         [NSBundle mainBundle],
                                                         @"");
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:title
                                                  action:@selector(showWindow:)
                                           keyEquivalent:@""];
    [item autorelease];
    [item setTarget:[CMSPrefPanelController sharedController]];
     return item;
}

@end
