//
//  BaseNetManager.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/5.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject

+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj,NSError *error))complete;
+(id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj,NSError *error))complete;


@end
