//
//  EGOCache+PGCache.m
//  transitorio
//
//  Created by Uauker on 12/9/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "EGOCache+PGCache.h"

@implementation EGOCache (PGCache)

+ (BOOL)hasCacheMD5ForKey:(NSString *)url {
    return [[EGOCache globalCache] hasCacheForKey:[url MD5Hash]];
}

+ (void)setUrl:(NSString *)url withTimeoutInterval:(NSTimeInterval)interval onSuccessPerform:(PGSimpleCacheCallback)callback {
    NSString *key = [url MD5Hash];
    [EGOCache setUrl:url forKey:key withTimeoutInterval:interval onSuccessPerform:callback];
}

+ (void)setUrl:(NSString *)url forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)interval onSuccessPerform:(PGSimpleCacheCallback)callback {
    NSString *source = @"";
    NSError *error = nil;
    BOOL isNew = NO;
    
    NSLog(@"Carregando: %@", url);
    
    if (![[EGOCache globalCache] hasCacheForKey:key]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
        
        NSHTTPURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        source = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (error == nil && [response statusCode] == 200) {
            isNew = YES;
            [[EGOCache globalCache] setString:source forKey:key withTimeoutInterval:interval];
        }
    }
    else {
        NSData *data = [[EGOCache globalCache] dataForKey:key];
        source = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    callback(source, isNew, error);
}


@end
