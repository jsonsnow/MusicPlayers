//
//  CLAudioTool.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <FSAudioStream.h>
#import "CLMusicSearchControl.h"
#import "CLListControl.h"
#import "CLMusicControl.h"

@interface CLAudioTool : NSObject<AVAudioPlayerDelegate,CLMusicSearchControlDelegate,CLListControlDelegate,CLMusicControlDelegate>

+(instancetype)sharedAudiManager;

////本地播放
//-(AVAudioPlayer *)playAudioWithFileName:(NSString *)fileName;
//
//-(void)pauseAudioWithFileName:(NSString *)fileName;
//
//-(void)stopAudioWithFileName:(NSString *)fileName;

//在线音乐播放

-(FSAudioStream *)playAudioWithOnlineString:(NSString *)fileName;
-(void)pauseAudioWithOnlineString:(NSString *)fileName;
-(void)stopAudioWithOnlineString:(NSString *)fileName;

@end
