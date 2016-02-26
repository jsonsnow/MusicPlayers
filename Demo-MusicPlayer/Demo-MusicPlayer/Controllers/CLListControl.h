//
//  CLListControl.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLBoardList.h"
@class CLMusicOnBaiDuIcon;
@class CLListControl;
@class CLArtist;
@protocol CLListControlDelegate  <NSObject>

-(void)clickListControlDelegate:(CLListControl *)control andMusic:(CLMusicOnBaiDuIcon *)muisc;

@end

@interface CLListControl : UITableViewController
@property (nonatomic,strong) CLBoardList *list;
@property (nonatomic,strong) CLArtist *artist;
@property (nonatomic,weak) id<CLListControlDelegate> delegate;

@end
