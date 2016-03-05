//
//  CLDownloadController.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/23.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLDownloadController.h"
#import "CLMusicSearch.h"
#import "CLDownloadCell.h"
#import "CLMuiscTool.h"

static NSString *identifer = @"cell";
@interface CLDownloadController ()<CLMusicSearchDelegate>
@property (nonatomic,strong) NSArray *downloadArray;
@property (nonatomic,strong) NSMutableDictionary *downloadDic;


@end

@implementation CLDownloadController
-(NSMutableDictionary *)downloadDic{
    
    if (!_downloadDic) {
        
        _downloadDic = [NSMutableDictionary dictionary];
    }
    
    
    return _downloadDic;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CLDownloadCell" bundle:nil] forCellReuseIdentifier:identifer];
    self.downloadArray = [[CLMuiscTool musicManager] getAllDownloadMusic];
    [CLMusicSearch searchManager].delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.downloadArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLDownloadCell *cell  =[tableView dequeueReusableCellWithIdentifier:identifer];
    CLMusicOnBaiDuIcon *music = self.downloadArray[indexPath.row];
    cell.currentDownloadMusic.text = [NSString stringWithFormat:@"%@:%@",music.artistName,music.songName];
    self.downloadDic[music.songLink] = cell ;
    cell.downloadButton.tag =indexPath.row;
    [cell.downloadButton addTarget:self action:@selector(pauseOrStart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
    
}

-(void)pauseOrStart:(UIButton *)sender{
    
    sender.selected=!sender.selected;
    
    if (sender.selected) {
       
        [[CLMusicSearch searchManager] recvResumClick:self.downloadArray[sender.tag]];
       } else {
                
            [[CLMusicSearch searchManager] recvStartClick:self.downloadArray[sender.tag]];
    }


}
 
#pragma mark --tablview-delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *headerString = [NSString stringWithFormat:@"正在下载:%ld首",(unsigned long)self.downloadArray.count];
    return headerString;
    
}


#pragma mark  -- musicsearch -delegate
-(void)downloadTaskProgress:(CLMusicSearch *)search andEd:(int64_t)downloadedLength andKeyString:(NSString *)keyString andAll:(int64_t)expectedLength withDownTask:(NSURLSessionDownloadTask *)task{
    
   
    CLDownloadCell *cell = self.downloadDic[keyString];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.preogress.progress = 1.0*downloadedLength/expectedLength;
        cell.progeressLabel.text = [NSString stringWithFormat:@"%4.2lf",1.0*downloadedLength/expectedLength*100];
    });
    
    
    
}

-(void)havedownloadedMusic:(CLMusicSearch *)search andlocaPath:(NSString *)string andKeyString:(NSString *)keyString{
    
        [self.downloadDic removeObjectForKey:keyString];

    
}

-(void)downloadFailer:(CLMusicSearch *)seach withKeyString:(NSString *)keyString andDownTask:(NSURLSessionTask *)task andError:(NSError *)error{


    [self.downloadDic removeObjectForKey:keyString];

    
}






@end
