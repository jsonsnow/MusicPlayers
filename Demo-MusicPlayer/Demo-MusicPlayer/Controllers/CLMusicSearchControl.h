//
//  CLMusicGroup.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/5.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CLMusicSearchControl;
@class CLMusicOnBaiDuIcon;

@protocol CLMusicSearchControlDelegate <NSObject>

-(void)clickMusicSearchofRow:(CLMusicSearchControl *)search andMusic:(CLMusicOnBaiDuIcon *)musisc;

@end




@interface CLMusicSearchControl : UIViewController
@property (nonatomic,weak)id<CLMusicSearchControlDelegate> delegate;

@property (nonatomic,strong) NSString *searchString;

//+(CLMusicOnBaiDuIcon *)getCurrentMusic;
//+(void)setPlayingMusci:(CLMusicOnBaiDuIcon *)musci;
//+(CLMusicOnBaiDuIcon *)nextMusic:(CLMusicOnBaiDuIcon *)music;
//+(CLMusicOnBaiDuIcon *)forworadMusic:(CLMusicOnBaiDuIcon *)music;

@end
