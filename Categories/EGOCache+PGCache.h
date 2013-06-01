//
//  EGOCache+PGCache.h
//  transitorio
//
//  Created by Uauker on 12/9/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "EGOCache.h"
#import "NSString+MD5.h"
#import "JSONKit.h"

typedef void(^PGCacheCallback)(NSString *content, BOOL isNew, NSError *error);
typedef void(^PGCacheYQLCallback)(NSString *content, BOOL isNew, NSDate *createdAt, NSError *error);

@interface EGOCache (PGCache)

+ (BOOL)hasCacheMD5ForKey:(NSString *)url;

+ (void)setUrl:(NSString *)url withTimeoutInterval:(NSTimeInterval)interval onSuccessPerform:(PGCacheCallback)callback;
+ (void)setUrl:(NSString *)url forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)interval onSuccessPerform:(PGCacheCallback)callback;

@end
