//
//  CLLyric.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/9.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLLyric.h"

@implementation CLLyric

+(NSMutableArray *)lrcLinesWithFileName:(NSURL *)fileName{
    
    NSMutableArray *lrcLines=[NSMutableArray array];
    
    //NSURL *url=[[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    
    NSString *lrcStr=[NSString stringWithContentsOfURL:fileName encoding:NSUTF8StringEncoding error:nil];
    
    //分割字符串,以换行符进行分割,将一句句单次单独分割出来
    
    NSArray *lrcCmps =[lrcStr componentsSeparatedByString:@"\n"];
    
    
    [lrcCmps enumerateObjectsUsingBlock:^(NSString *lineStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        CLLyric *lrcLine =[[CLLyric alloc] init];
        [lrcLines addObject:lrcLine];
        
        //如歌是歌词的头部信息(歌手,歌名,专辑)
        if ([lineStr hasPrefix:@"[ti:" ]|| [lineStr hasPrefix:@"[ar:"]||[lineStr hasPrefix:@"[al:"]) {
            NSString *word=[[lineStr componentsSeparatedByString:@":"] lastObject];
            lrcLine.word=[word substringToIndex:word.length-1];
            
        }else if ([lineStr hasPrefix:@"["]){
            
            NSArray *array=[lineStr componentsSeparatedByString:@"]"];
            lrcLine.time=[[array firstObject] substringFromIndex:1];
            lrcLine.word=[array lastObject];
            
        }
        
        // NSLog(@"%@,%@",lrcLine.time,lrcLine.word);
        
    }];
    
    if (lrcLines.count==0) {
        return nil;
    }
    else{
        
        return lrcLines;
    }
    
    
}


@end
