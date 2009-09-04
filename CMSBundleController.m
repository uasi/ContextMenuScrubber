//
//  CMSBundleController.m
//  ContextMenuScrubber
//
//  Created by uasi on 09/09/04.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import "CMSBundleController.h"

#import <objc/runtime.h>
#import "BrowserWebView+CMSHack.h"


@implementation CMSBundleController

+ (void)load
{
    Class cls = objc_getClass("BrowserWebView");
    Method orig = class_getInstanceMethod(cls, @selector(webView:contextMenuItemsForElement:defaultMenuItems:));
    Method alt = class_getInstanceMethod(cls, @selector(cms_webView:contextMenuItemsForElement:defaultMenuItems:));
    method_exchangeImplementations(orig, alt);
    
    NSLog(@"ContextMenuScrubber loaded");
}

@end
