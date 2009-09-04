//
//  BrowserWebView+CMSHack.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/09/04.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "BrowserWebView+CMSHack.h"

#import "CMSBundleController.h"


static NSArray *actionsOfUnwantedMenuItems;

@implementation BrowserWebView (CMSHack)

+ (void)load
{
    NSBundle *bundle = [NSBundle bundleForClass:
                        [CMSBundleController class]];
    NSArray *actions = [bundle objectForInfoDictionaryKey:
                        @"CMSActionsOfUnwantedMenuItems"];
    actionsOfUnwantedMenuItems = [actions retain];
}

- (NSArray *)cms_webView:(WebView *)sender
contextMenuItemsForElement:(NSDictionary *)element
    defaultMenuItems:(NSArray *)defaultMenuItems
{
    NSArray *menuItems = [self cms_webView:sender
                contextMenuItemsForElement:element
                          defaultMenuItems:defaultMenuItems];
    NSMutableArray *newMenuItems = [NSMutableArray array];
    for (NSMenuItem *item in menuItems) {
        NSString *action = NSStringFromSelector([item action]);
        if ([actionsOfUnwantedMenuItems containsObject:action]) {
            // NSLog(@"Menu item removed: '%@'", action);
        }
        else {
            [newMenuItems addObject:item];
        }
    }
    return newMenuItems;
}

@end
