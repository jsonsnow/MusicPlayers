//
//  CLCachDataTool.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/11.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLCachDataTool.h"
#import <AVFoundation/AVFoundation.h>
#import "CLLyric.h"


@interface CLCachDataTool()


@end
@implementation CLCachDataTool

//缓存歌词和存到本地
+(void)addLrcForCach:(NSArray *)lrc andURL:(NSURL *)url andID:(NSString *)ID{
    
  
    NSString *strPath=url.path;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    [manager copyItemAtPath:strPath toPath:[self lrcPathwith:ID] error:&error];
    if (error) {
        
        NSLog(@"copy error:%@",error.userInfo);
    }
    
    
}
+(NSString *)lrcPathwith :(NSString *)ID{
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    
    NSString * lrcPath=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    lrcPath = [lrcPath stringByAppendingPathComponent:@"lrc"];
    if (![manager fileExistsAtPath:lrcPath]) {
        
        [manager createDirectoryAtPath:lrcPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    lrcPath = [NSString stringWithFormat:@"%@/%@.lrc",lrcPath,ID];
    
    return lrcPath;
}


#pragma mark --歌词获取
+(NSArray *)getLrcForCachWith:(NSString *)ID{
   
    
  
        
       NSString *lrcPath = [self lrcPathwith:ID];
       NSURL *url = [NSURL fileURLWithPath:lrcPath];
       NSArray * array = [CLLyric lrcLinesWithFileName:url];
       return array;
}

+(NSString *)lrcPath{
    
      NSString * lrcPath=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        lrcPath=[lrcPath stringByAppendingPathComponent:@"lrc"];
    
       return lrcPath;
    
}



+(void)removeCachData{
    
    [[CLCachData sharedCachDataManager] cleanCachData];
    
}



+(void)transform{
    
    NSString *string=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *array = [manager contentsOfDirectoryAtPath:string error:nil];
    for (NSString *subString in array) {
        
        if (![[subString pathExtension] isEqualToString:@"metadata"]&&![subString  isEqualToString:@"DS_Store"]) {
            
            NSString *str=[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject],subString];
            NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
            
            NSURL *url = [NSURL fileURLWithPath:str];
            AVURLAsset *mp3 =[AVURLAsset URLAssetWithURL:url options:nil];
            NSLog(@"%@",mp3);
            
            for (NSString *format in [mp3 availableMetadataFormats]) {
                NSLog(@"format Type =%@",format);
                
                for (AVMetadataItem *meta in [mp3 metadataForFormat:format]) {
                    
                    if (meta.commonKey) {
                        
                        [retDic setObject:meta.value forKey:meta.commonKey];
                    }
                }
            }
            NSLog(@"%@",retDic);

        }
    }
    
}



@end
