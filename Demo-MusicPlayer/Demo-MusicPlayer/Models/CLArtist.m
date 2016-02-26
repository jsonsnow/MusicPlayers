//
//  CLArtist.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLArtist.h"

@implementation CLArtist

+(instancetype)pareArtistData:(NSDictionary *)dic{
    
    
    return [[self alloc] pareArtistDataWithDic:dic];
}

-(instancetype)pareArtistDataWithDic:(NSDictionary *)dic{
    
    
    [self setValuesForKeysWithDictionary:dic];
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}

@end
