//
//  CLLyric.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/9.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLyric : NSObject
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *word;

+(NSMutableArray *)lrcLinesWithFileName:(NSURL *)fileName;

@end
