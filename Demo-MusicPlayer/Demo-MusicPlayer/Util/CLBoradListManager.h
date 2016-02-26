//
//  CLBoradListManager.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLBoradListManager : NSObject

+(instancetype)listManager;
-(void )getListCompleteHandle:(void (^)(NSArray *array))complete andHaveReload:(void(^)(NSArray *haveData))haveDataHandle;
+(void)removeAllMusicList;

@end
