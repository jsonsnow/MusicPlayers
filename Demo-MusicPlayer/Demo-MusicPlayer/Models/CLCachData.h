//
//  CLCachData.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/11.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCachData : NSObject

@property (nonatomic,strong) NSMutableDictionary *lrcDic;
@property (nonatomic,strong) NSMutableDictionary *musicDic;

+(instancetype)sharedCachDataManager;
-(void)cleanCachData;

@end
