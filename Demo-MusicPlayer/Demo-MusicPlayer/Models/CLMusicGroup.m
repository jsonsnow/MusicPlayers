//
//  CLMusicGroup.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/22.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicGroup.h"

@implementation CLMusicGroup
-(instancetype)init{
    
    if (self = [super init]) {
        
        self.musicsArray = [NSMutableArray array];
    }
    
    return self;
}

@end
