//
//  CLRecentViewController.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/2/25.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLRecentViewController.h"
#import "CLMusicGroupTool.h"
#import "CLMusicGroup.h"
#import "CLMusic.h"

@interface CLRecentViewController ()


@end

@implementation CLRecentViewController




-(NSArray *)getmusicGroupArray{
    
    if (self.musicGroupArray==nil) {
        
        self.musicGroupArray =[[CLMusicGroupTool managerGroup] getAllRecentPlayMusic];
        
    }
    
    
    return self.musicGroupArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getmusicGroupArray];
    [self createTableView];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = YES;
    //self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return  self.musicGroupArray.count;
//    //    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    CLMusicGroup *group = self.musicGroupArray[section];
//    NSArray *musics = [group.musicsArray copy];
//    return musics.count;
//    //    return self.musicArray.count;
//    
//    
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *identefier = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identefier];
//    
//    if (cell==nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identefier];
//    }
//    
//    
//    
//    CLMusicGroup *group = self.musicGroupArray[indexPath.section];
//    NSArray *musics = [group.musicsArray copy];
//    if (musics.count>0) {
//        
//        CLMusicOnBaiDuIcon *music = musics[indexPath.row];
//        //        CLMusicOnBaiDuIcon *music = self.musicArray[indexPath.row];
//        cell.textLabel.text = music.songName;
//        cell.detailTextLabel.text = music.artistName;
//        
//    }
//    
//    
//    return cell;
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
