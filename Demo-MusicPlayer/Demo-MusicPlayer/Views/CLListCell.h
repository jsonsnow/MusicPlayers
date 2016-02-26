//
//  CLListCell.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLBoardList.h"
#import "CLArtist.h"

@interface CLListCell : UITableViewCell
@property (nonatomic,strong) CLBoardList *list;
@property (nonatomic,strong) CLArtist *artit;

@end
