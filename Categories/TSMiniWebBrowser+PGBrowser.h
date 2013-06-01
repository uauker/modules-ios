//
//  TSMiniWebBrowser+PGBrowser.h
//  transitorio
//
//  Created by Uauker on 12/23/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "TSMiniWebBrowser.h"

@interface TSMiniWebBrowser (PGBrowser)

+ (TSMiniWebBrowser *)browserWithUrl:(NSURL *)url delegate:(id<TSMiniWebBrowserDelegate>)delegate;

@end
