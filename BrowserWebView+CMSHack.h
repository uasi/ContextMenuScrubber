//
//  BrowserWebView+CMSHack.h
//  ContextMenuScrubber
//
//  Created by uasi on 09/09/04.
//  Copyright 2009 99cm.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BrowserWebView {}
@end

@class WebView;
@interface BrowserWebView (CMSHack)
- (NSArray *)cms_webView:(WebView *)sender
contextMenuItemsForElement:(NSDictionary *)element
        defaultMenuItems:(NSArray *)defaultMenuItems;
@end
