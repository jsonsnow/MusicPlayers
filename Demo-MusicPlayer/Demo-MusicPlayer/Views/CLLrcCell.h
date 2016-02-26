//
//  CLLrcCell.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/10.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLyric.h"
@interface CLLrcCell : UITableViewCell

@property (nonatomic,strong) CLLyric *lrcLine;
+(instancetype)lrcCellWithTableView:(UITableView *)tableView;

@end
