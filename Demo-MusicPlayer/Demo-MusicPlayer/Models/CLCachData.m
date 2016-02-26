//
//  CLCachData.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/11.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLCachData.h"

static CLCachData *_cachData;
@implementation CLCachData

+(instancetype)sharedCachDataManager{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _cachData=[[self alloc] init];
        
    });
    
    
    return _cachData;
}

-(instancetype)init{
    
    if (self=[super init]) {
        
        self.lrcDic = [NSMutableDictionary dictionary];
        self.musicDic=[NSMutableDictionary dictionary];
        
    }
    
    
    return self;
    
}

-(void)cleanCachData{
    
    
    [self.lrcDic removeAllObjects];
    [self.musicDic removeAllObjects];
}
@end
