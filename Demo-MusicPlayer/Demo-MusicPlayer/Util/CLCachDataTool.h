//
//  CLCachDataTool.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/11.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLMusicOnBaiDuIcon;
#import "CLCachData.h"

@interface CLCachDataTool : NSObject

+(void)addLrcForCach:(NSArray *)lrc andURL:(NSURL *)url andID:(NSString *)ID;
+(NSArray *)getLrcForCachWith:(NSString *)ID;
+(void)transform;
+(void)removeCachData;

//+(void)addLrcForCach:()
@end
