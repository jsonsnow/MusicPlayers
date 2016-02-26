//
//  CLBoradListManager.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLBoradListManager.h"
#include "CLBoardList.h"
#import "CLMusicSearch.h"

const static NSString *baiDuListUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=";
static NSMutableArray *_musicListArray=nil;
static CLBoradListManager *_mananger;
@interface CLBoradListManager ()
@property (nonatomic,strong) NSArray *netArray;

@end
@implementation CLBoradListManager


-(NSArray *)netArray{
    
    
    if (!_netArray) {
        
        _netArray=@[@"http://tingapi.ting.baidu.com/v1/restserver/ting?       from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=1",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=2",
                    
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=11",
                    
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=12",
                    
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=16",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=21",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=22",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=23",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=24",
                    @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=25"
                    ];
    }
    
    
    return _netArray;
}


+(instancetype)listManager{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _mananger = [[self alloc] init];
        
    });
    
    return _mananger;
}

-(instancetype)init{
    
    if (self=[super init]) {
        
       
    }
    
    
    return self;
}


-(void )getListCompleteHandle:(void (^)(NSArray *))complete andHaveReload:(void (^)(NSArray *))haveDataHandle{
    
    if (_musicListArray==nil) {
         _musicListArray=[NSMutableArray array];
        for (NSString *urlString in self.netArray) {
            
            [[CLMusicSearch searchManager] getMusicList:urlString successHandler:^(id data, id response) {
                NSData *recData = data;
                NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:recData options:0 error:nil];
                NSDictionary *boardDic=dic[@"billboard"];
                CLBoardList *list =[CLBoardList new];
                [list setValuesForKeysWithDictionary:boardDic];
                [_musicListArray addObject:list];
                complete([_musicListArray copy]);
               
                
            } andFailHandle:^(id response, NSError *error) {
               
                
                
            }];
           
            
        }

    }  else {
        
        haveDataHandle(_musicListArray);
        
    }
    
    
    
}
+(void)removeAllMusicList{
    
    [_musicListArray removeAllObjects];
    
}
-(void)dealloc{
    
    [_musicListArray removeAllObjects];
    
}



@end
