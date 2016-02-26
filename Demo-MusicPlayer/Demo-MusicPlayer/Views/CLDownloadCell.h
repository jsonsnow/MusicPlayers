//
//  CLDownloadCell.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/23.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLDownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *currentDownloadMusic;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIProgressView *preogress;
@property (weak, nonatomic) IBOutlet UILabel *progeressLabel;

@end
