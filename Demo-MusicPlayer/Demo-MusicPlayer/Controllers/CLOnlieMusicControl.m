//
//  CLMusicDetailViewController.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLOnlieMusicControl.h"
#import "UIView+Extension.h"
#import "CLAudioTool.h"
#import <AVFoundation/AVFoundation.h>
#import <FSAudioStream.h>
#import <UIImageView+WebCache.h>
#import "CLMusic.h"
#import "CLMusicSearch.h"
#import "CLLyric.h"
#import "CLLrcCell.h"
#import "CLCachDataTool.h"
#import "CLMuiscTool.h"
#import <CoreLocation/CLRegion.h>


@class FSStreamConfiguration;


#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define STATUES_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAV_HEINGT     [[UINavigationController alloc] init].navigationBar.frame.size.height


@interface CLOnlieMusicControl ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) FSAudioStream *onliePlayer;
@property (weak,  nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak,  nonatomic) IBOutlet UIImageView *iconView;
@property (weak,  nonatomic) IBOutlet UILabel *durationLabel;
@property (weak,  nonatomic) IBOutlet UIButton *currentTimeButton;
@property (nonatomic,strong) NSTimer *currentTimer;
@property (weak,  nonatomic) IBOutlet UIView *progressView;
@property (weak,  nonatomic) IBOutlet NSLayoutConstraint *offsetXforSupView;
//@property (nonatomic,strong) FSStreamConfiguration *configuration;

//歌词显示部分
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *lrcLines;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) CADisplayLink *lrcTimer;
@property (nonatomic,assign) NSTimeInterval currentTime;
@property (nonatomic,weak) CLMusicOnBaiDuIcon * onlieMuisc;


@end

@implementation CLOnlieMusicControl


- (void)viewDidLoad {

    //UILocalNotification
    [super viewDidLoad];
    [self setTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    self.playOrPauseButton.selected=YES;
    _onlieMuisc=[CLMuiscTool getOnlineCurrentMusic];
    if (_onlieMuisc==nil) {
        
        _onlieMuisc = [CLMuiscTool getCurrentMusic];
        
        if (_onlieMuisc==nil) {
            
            self.playOrPauseButton.selected=NO;
            return;
        }
        
    }
    [self setAlbumImageView];
    [self play:_onlieMuisc.songLink];
    [self downloadLrc];
    
    [self createTimerForCurrentButton];
    [self creatLrcTimer];

    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.currentTimer invalidate];
    [self.lrcTimer invalidate];
    self.currentTimer = nil ;
    self.lrcTimer = nil;
}


//显示歌词的tableView初始化
-(void)setTableView{
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEINGT+STATUES_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEINGT-STATUES_HEIGHT-150)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator  =NO;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
}

//歌词下载

-(void)downloadLrc{
    
    self.lrcLines = [CLCachDataTool getLrcForCachWith:_onlieMuisc.songId];
    if (self.lrcLines.count==0) {
        
        [CLMusicSearch downloadLrc:[NSURL URLWithString: _onlieMuisc.lrcLink] completionHandler:^(id objct, id erro) {
            
            NSURL *url=objct;
            self.lrcLines= [CLLyric lrcLinesWithFileName:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSAssert([NSThread isMainThread],@"updataUI must in Main thread");
                [self.tableView reloadData];
                [self creatLrcTimer];
                
            });
            
            [CLCachDataTool addLrcForCach:self.lrcLines andURL:url andID:_onlieMuisc.songId];
            
        }];
        
    } else {
       
        NSAssert([NSThread isMainThread],@"updataUI must in Main thread");
           
            [self.tableView reloadData];
            [self creatLrcTimer];
            
        
        
    }
    
}

//歌词定时器
-(void)creatLrcTimer{
    
    
    if (self.lrcTimer) {
        
        [self closeLrcTimer];
    }
   
    self.lrcTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(updataLrcTimer)];
        
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
}
-(void)updataLrcTimer{
    
    self.currentTime=self.onliePlayer.currentTimePlayed.minute*60+
    self.onliePlayer.currentTimePlayed.second;
    
}
-(void)closeLrcTimer{
    
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
    
}
//重新currentTime的settter方法
-(void)setCurrentTime:(NSTimeInterval)currentTime{
    if (_currentTime>currentTime) {
        self.currentIndex=0;
    }
    _currentTime=currentTime;
    int minute=currentTime/60;
    int second=(int)currentTime%60;
    int msecon=(currentTime -(int)currentTime)*100;
    NSString *currentTimeStr=[NSString stringWithFormat:@"%02d:%02d:%02d",minute,second,msecon];
    
    for (NSInteger i=self.currentIndex; i<self.lrcLines.count; i++) {
        CLLyric *currentLine=self.lrcLines[i];
        NSString *currentLineTime=currentLine.time;
        NSString *nextLineTime=nil;
        
        if (i+1<self.lrcLines.count) {
            CLLyric *nextLine=self.lrcLines[i+1];
            nextLineTime =nextLine.time;
        }
        
        if (([currentTimeStr compare:currentLineTime] !=NSOrderedAscending &&([currentTimeStr compare:nextLineTime]==NSOrderedAscending) &&(self.currentIndex!=i))) {
            
            NSArray *reloadLines=@[
                                   [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
                                   [NSIndexPath indexPathForItem:i inSection:0],
                                   
                                   ];
            
            self.currentIndex=i;
            [self.tableView reloadRowsAtIndexPaths:reloadLines withRowAnimation:UITableViewRowAnimationNone];
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:
                                                    self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }
    
    
}

#pragma mark-----tableView data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lrcLines.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLLrcCell *cell=[CLLrcCell lrcCellWithTableView:tableView];
    cell.lrcLine=self.lrcLines[indexPath.row];
    if (self.currentIndex==indexPath.row) {
        cell.textLabel.textColor=[UIColor redColor];
        cell.textLabel.font=[UIFont systemFontOfSize:20];
    }else{
        
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.font=[UIFont systemFontOfSize:15];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}
#pragma mark------tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}


#pragma mark- -- play control

//播放或暂停
- (IBAction)playOrPauseMusic {
    
    self.playOrPauseButton.selected=!self.playOrPauseButton.selected;
    [[CLAudioTool sharedAudiManager] pauseAudioWithOnlineString:_onlieMuisc.songLink];
        
}
//播放下一首
- (IBAction)playNextMusic {
    
    
    [[CLAudioTool sharedAudiManager] stopAudioWithOnlineString:_onlieMuisc.songLink];
    
    
    _onlieMuisc=[CLMuiscTool getOnlineCurrentMusic]?[CLMuiscTool nextOnlineMusic:_onlieMuisc]:[CLMuiscTool nextMusic:_onlieMuisc];
    [self setAlbumImageView];
    [self downloadLrc];
    [self play:_onlieMuisc.songLink];
    
}

//播放上一首
- (IBAction)playForwoedMusic:(UIButton *)sender {
    
    [[CLAudioTool sharedAudiManager] stopAudioWithOnlineString:_onlieMuisc.songLink];
    _onlieMuisc=[CLMuiscTool getOnlineCurrentMusic]?[CLMuiscTool nextOnlineMusic:_onlieMuisc]:[CLMuiscTool nextMusic:_onlieMuisc];
    [self setAlbumImageView];
    [self downloadLrc];
    [self play:_onlieMuisc.songLink];
    
}

-(void)play:(NSString *)fileName;{
    

    self.onliePlayer=[[CLAudioTool sharedAudiManager] playAudioWithOnlineString:fileName];

    self.durationLabel.text=[self changeTimeWithInterval:self.onliePlayer.duration];
    [self.currentTimeButton setTitle:[self changeTimeWithInterval:self.onliePlayer.currentTimePlayed] forState:UIControlStateNormal];
    [self createTimerForCurrentButton];
    
}


#pragma mark--播放时间~进度设置

-(void)createTimerForCurrentButton{
    
    if (self.currentTimer) {
        
        [self closeTimer];
    }
    self.currentTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setcurrentTimer) userInfo:nil repeats:YES];
    
}
-(void)setcurrentTimer{
    
    [self.currentTimeButton setTitle:[self changeTimeWithInterval:self.onliePlayer.currentTimePlayed] forState:UIControlStateNormal];
    self.durationLabel.text=[self changeTimeWithInterval:self.onliePlayer.duration];
    
    CGFloat currentTime=self.onliePlayer.currentTimePlayed.minute*60+
    self.onliePlayer.currentTimePlayed.second;
    
    CGFloat durationTime=self.onliePlayer.duration.minute*60+
    self.onliePlayer.duration.second;
    
    
    if (durationTime!=0) {
        
    CGFloat progress= currentTime/durationTime*1.0;
    CGFloat offsetX=self.view.width-self.currentTimeButton.width-self.durationLabel.width;
    if (progress*offsetX<SCREEN_WIDTH) {
    
        self.offsetXforSupView.constant=progress*offsetX;
        self.progressView.width=self.currentTimeButton.center.x;
        
    }
    
    }
   
}
-(void)closeTimer{
    
    [self.currentTimer invalidate];
    self.currentTimer=nil;
}

#pragma mark---手势

- (IBAction)ClickPanGesture:(UIPanGestureRecognizer *)sender {
    
    
    CGPoint point=[sender translationInView:sender.view];
    
    self.offsetXforSupView.constant+=point.x;
    CGFloat offsetX=self.view.width-self.currentTimeButton.width-self.durationLabel.width;
    double offsetProgress = self.offsetXforSupView.constant / offsetX;
    self.progressView.width=self.currentTimeButton.center.x;
    [sender setTranslation:CGPointZero inView:sender.view];
    if (sender.state==UIGestureRecognizerStateBegan) {
        
        [self closeTimer];
        [self closeLrcTimer];
        
    } else if (sender.state==UIGestureRecognizerStateEnded) {
        
        FSStreamPosition currentTimer=self.onliePlayer.duration;
        unsigned time = currentTimer.second + currentTimer.minute*60;
        time = time*offsetProgress;
        currentTimer.minute=time/60;
        currentTimer.second=time%60;
        
        [self.onliePlayer seekToPosition:currentTimer];
        [self createTimerForCurrentButton];
        [self creatLrcTimer];
       
    }
    
}


#pragma mark---专辑封面
-(void)setAlbumImageView{
    self.navigationItem.title=_onlieMuisc.songName;
    
    if (![_onlieMuisc.songPicBig isKindOfClass:[NSNull class]]) {
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:_onlieMuisc.songPicBig]];

        
    }
   
}

-(UIImage *)getCircularImage:(UIImage *)image andRect:(CGRect)rect{
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    [image drawInRect:rect];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}


-(NSString *)changeTimeWithInterval:(FSStreamPosition)interval{
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)interval.minute,(int)interval.second];
}



-(void)dealloc{
    
    
    
}

-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
    [[CLCachData sharedCachDataManager] cleanCachData];
    
    
}






@end
