//
//  CLMusicControl.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicControl.h"
#import "CLMusic.h"
#import "CLMuiscTool.h"
#import "CLMusicGroupTool.h"
#import "CLMusicGroup.h"
#import <UIImageView+WebCache.h>
#import "CLAudioTool.h"

const CGFloat weight=70;



@interface CLMusicControl ()<UITableViewDataSource,UITableViewDelegate>






@property (nonatomic,assign) NSArray *musicArray;
@end

@implementation CLMusicControl
-(NSArray *)musicArray{
    
    if (!_musicArray) {
        
        _musicArray = [[CLMuiscTool musicManager] musicArray];
    }
    return _musicArray ;
}

-(NSArray *)getmusicGroupArray{
    
    if (_musicGroupArray==nil) {
        
        _musicGroupArray =[[CLMusicGroupTool managerGroup] getALLMusicGroup];

    }
    
    
    return _musicGroupArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self getmusicGroupArray];
    self.delegate = [CLAudioTool sharedAudiManager] ;
    [self createTableView];
    self.navigationItem.title=@"本地列表";
    
    
}

-(void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return  self.musicGroupArray.count;
//    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CLMusicGroup *group = self.musicGroupArray[section];
    NSArray *musics = [group.musicsArray copy];
    return musics.count;
//    return self.musicArray.count;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identefier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identefier];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identefier];
    }
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CLMusicGroup *group = self.musicGroupArray[indexPath.section];
    NSArray *musics = [group.musicsArray copy];
    if (musics.count>0) {
        
        CLMusicOnBaiDuIcon *music = musics[indexPath.row];
        //        CLMusicOnBaiDuIcon *music = self.musicArray[indexPath.row];
        cell.textLabel.text = music.songName;
        cell.detailTextLabel.text = music.artistName;
        
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return weight-20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLMusicGroup *group = self.musicGroupArray[indexPath.section];
    NSArray *musics = group.musicsArray;
    CLMusicOnBaiDuIcon *music = musics[indexPath.row];
    [[CLMusicGroupTool managerGroup] addMusicFormRecentPlayArray:music];
    [self.delegate clickLocalMusiControl:self withSelectedMuisc:music];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CLMusicGroup *group = self.musicGroupArray[section];
    NSArray *musics = group.musicsArray;
    if (musics.count>0) {
        
        return 20;
        
    } else {
        
        return 0;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    CLMusicGroup *group = self.musicGroupArray[section];
    NSArray *musics = group.musicsArray;
    
    if (musics.count>0) {
        
        return group.titile;
        
    } else {
        
        return nil;
    }
    
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return [self.musicGroupArray valueForKeyPath:@"titile"];
    
}

#pragma mark --编辑状态

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除该歌曲";
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        UIAlertController *contro = [UIAlertController alertControllerWithTitle:@"删除此歌" message:@"确定删除这首歌吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            CLMusicGroup *group = self.musicGroupArray[indexPath.section];
            NSArray *musics = [group.musicsArray copy];
            CLMusicOnBaiDuIcon *music = musics[indexPath.row];
            [group.musicsArray removeObject:music];
            [[CLMuiscTool musicManager] removeMusicFromLocal:music];
            [[CLMuiscTool musicManager] deleteMusicForRecentPlay:music];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
        [contro addAction:cancelAction];
        [contro addAction:deleteAction];
        
        [self presentViewController:contro animated:YES completion:nil];

    }
    
}



@end
