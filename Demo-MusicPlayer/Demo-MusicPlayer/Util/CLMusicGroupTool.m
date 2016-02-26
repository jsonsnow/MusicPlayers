//
//  CLMusicGroupTool.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/22.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicGroupTool.h"
#import "CLMuiscTool.h"
#import "CLMusic.h"
#import "CLMusicGroup.h"
#import "NSString+CLStringTool.h"

static NSArray *_groupArray;
static CLMusicGroupTool *_manager;
@interface CLMusicGroupTool ()
@property (nonatomic,strong) NSArray *allTitleArray;
@property (nonatomic,strong) NSArray *recentPlayArray;
@end
@implementation CLMusicGroupTool

-(NSArray *)allTitleArray{
    
    
    NSMutableArray *array = [NSMutableArray array];
    if (!_allTitleArray) {
        
        for (int i=0; i<26; i++) {
            
            char ch = 97+i;
            [array addObject:[NSString stringWithFormat:@"%c",ch]];
        }
    }
    
    
    return [array copy];;
}

+(instancetype)managerGroup{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        _manager = [[self alloc] init];
    });
    
    return _manager;
    
}

-(instancetype)init{
    
    if (self = [super init]) {
        
       
    }
    
    return self;
}

-(NSArray *)getAllRecentPlayMusic {
    
    if (_recentPlayArray == nil) {
        
        
        NSArray *array  = [[CLMuiscTool musicManager] getRecentPlayMusic];
        
        _recentPlayArray =  [self paresMusicToGroup:array withIsGroup:NO];
        
    }
   
    
    return _recentPlayArray;
    
    
}

-(NSArray *)getALLMusicGroup{
    
    if (_groupArray==nil) {
        
        NSArray *array  =[[CLMuiscTool musicManager] musicArray];
       _groupArray = [self paresMusicToGroup:array withIsGroup:YES];
        
    }
    
  
    return _groupArray;
}

-(NSArray *)paresMusicToGroup:(NSArray *)array withIsGroup:(BOOL)isGroup{
    
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    for (NSString *string in self.allTitleArray) {
        CLMusicGroup *group = [CLMusicGroup new];
        group.titile = string;
        [arrays addObject:group];
    }
  
  
    for (CLMusicOnBaiDuIcon *music in array) {
        

        NSString *nameString = [NSString convertHanZiToPingYing:music.artistName];
        char c= [nameString characterAtIndex:0];
       
        if ('A'<=c&&c<'Z') {
            c = c +32;
        }
        
        if (c<'a'||c> 'z') {
            NSLog(@"delete");
            continue;
        }
        int index= c-97;
        
        if (0<index && index< 26) {
            
            CLMusicGroup *group = arrays[index];
            [group.musicsArray addObject:music];
        }
        
        
    }
    
    return [arrays copy];
    
}
-(void)addMusicFromOnceGroup:(CLMusicOnBaiDuIcon *)music{
    
    
    NSString *nameString = [NSString convertHanZiToPingYing:music.artistName];
    char c= [nameString characterAtIndex:0];
    
    if ('A'<=c&&c<'Z') {
        c = c +32;
    }
    
    if (c<'a'||c> 'z') {
        NSLog(@"delete");
        
    }
    int index= c-97;
    if (0<index && index< 26) {
        
        CLMusicGroup *group = _groupArray[index];
        [group.musicsArray addObject:music];
    }
    

    
}
-(void)addMusicFormRecentPlayArray:(CLMusicOnBaiDuIcon *)music{
    
    
    NSString *nameString = [NSString convertHanZiToPingYing:music.artistName];
    char c= [nameString characterAtIndex:0];
    
    if ('A'<=c&&c<'Z') {
        c = c +32;
    }
    
    if (c<'a'||c> 'z') {
        NSLog(@"delete");
        
    }
    int index= c-97;
    
    if (0<index && index< 26) {
        
        CLMusicGroup *group = _recentPlayArray[index];
        [[CLMuiscTool musicManager] addMusicForRecentPlay:music];
        [group.musicsArray addObject:music];
    }
    
    
}



-(void)deleteMusicFromOnceGroup:(CLMusicOnBaiDuIcon *)music{
    
    
    
    
}


@end
