//
//  CLMusicDetailViewController.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLMusic.h"

typedef void(^MyBlock)(BOOL);
@interface CLMusicDetailViewController : UIViewController

@property (nonatomic,copy) MyBlock showViewWhenCallBack;
@property (nonatomic,strong) NSString *remoteRul;
@property (nonatomic,strong) NSString *imageUrl;


@end
