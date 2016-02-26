//
//  CLMusicControl.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLMusicControl;
@class CLMusicOnBaiDuIcon;
@protocol CLMusicControlDelegate <NSObject>

-(void)clickLocalMusiControl:(CLMusicControl *)localControl withSelectedMuisc:(CLMusicOnBaiDuIcon *)music;

@end

@interface CLMusicControl : UIViewController
@property (nonatomic,weak) id<CLMusicControlDelegate> delegate;
@property (nonatomic,strong) NSArray *musicGroupArray;
@property (strong, nonatomic) UITableView *tableView;
-(NSArray *)getmusicGroupArray;
-(void)createTableView;

@end
