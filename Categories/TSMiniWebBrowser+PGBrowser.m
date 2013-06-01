//
//  TSMiniWebBrowser+PGBrowser.m
//  transitorio
//
//  Created by Uauker on 12/23/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "TSMiniWebBrowser+PGBrowser.h"

@implementation TSMiniWebBrowser (PGBrowser)

+ (TSMiniWebBrowser *)browserWithUrl:(NSURL *)url delegate:(id<TSMiniWebBrowserDelegate>)delegate {
    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:url];
    webBrowser.delegate = delegate;
    
    webBrowser.mode = TSMiniWebBrowserModeNavigation;
    
    webBrowser.barStyle = UIBarStyleBlack;
    webBrowser.hidesBottomBarWhenPushed = YES;
    
    return webBrowser;
}


@end
