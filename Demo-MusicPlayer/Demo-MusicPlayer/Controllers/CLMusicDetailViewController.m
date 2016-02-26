//
//  CLMusicDetailViewController.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/4.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicDetailViewController.h"
#import "UIView+Extension.h"
#import <AVFoundation/AVFoundation.h>
#import "CLAudioTool.h"
#import "CLMuiscTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <FSAudioStream.h>
#import <UIImageView+WebCache.h>


#define WITDH [UIScreen mainScreen].bounds.size.width


@interface CLMusicDetailViewController ()<AVAudioPlayerDelegate>
@property (nonatomic ,strong) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *currentTimeButton;

@property (nonatomic,strong) NSTimer *currentTimer;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForCurrentTimer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offsetXforSupView;
@property (nonatomic ,strong) FSAudioStream *audioStream;

@end

@implementation CLMusicDetailViewController

//- (void)viewDidLoad {
//
//    [super viewDidLoad];
//    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"change" object:nil];
//    
////    _audioStream=[[FSAudioStream alloc] init];
////    [_audioStream playFromURL:[NSURL URLWithString:self.remoteRul]];
////    
////    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];;
////    
//}
//
//-(void)update:(NSNotification *)sender{
//    
////    [self play:[CLMuiscTool getCurrentMusic].filename];
////   // _music=[CLMuiscTool getCurrentMusic];
////    [self setAlbumImageView];
//
//    
//}
//
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    
//    if ([keyPath isEqualToString:@"change"]) {
//        
//        [self play:[CLMuiscTool getCurrentMusic].filename];
//        _music=[CLMuiscTool getCurrentMusic];
//        [self setAlbumImageView];
//
//    }
//    
//        
//}
//
////播放或暂停
//- (IBAction)playOrPauseMusic {
//    if (self.playOrPauseButton.selected==YES) {
//        self.playOrPauseButton.selected=NO;
//        [[CLAudioTool sharedAudiManager] pauseAudioWithFileName:_music.filename];
//        
//    } else {
//        
//        self.playOrPauseButton.selected=YES;
//        [[CLAudioTool sharedAudiManager] playAudioWithFileName:_music.filename];
//        
//    }
//    
//    
//}
////播放下一首
//- (IBAction)playNextMusic {
//    [[CLAudioTool sharedAudiManager] stopAudioWithFileName:_music.filename];
//    _music=[CLMuiscTool nextMusic:_music];
//    [self setAlbumImageView];
//    [self play:_music.filename];
//    
//}
//
////播放上一首
//- (IBAction)playForwoedMusic:(UIButton *)sender {
//    [[CLAudioTool sharedAudiManager] stopAudioWithFileName:_music.filename];
//    _music=[CLMuiscTool forworadMusic:_music];
//    [self setAlbumImageView];
//   [self play:_music.filename];
//    
//}
//
//-(void)play:(NSString *)fileName;{
//    
//    self.player=[[CLAudioTool sharedAudiManager] playAudioWithFileName:fileName];
//    //self.player.delegate=self;
//    
//    if ([self.player prepareToPlay]) {
//        [self.player play];
//    }
//    
//    self.durationLabel.text=[self changeTimeWithInterval:self.player.duration];
//    [self.currentTimeButton setTitle:[self changeTimeWithInterval:self.player.currentTime] forState:UIControlStateNormal];
//    [self createTimerForCurrentButton];
//    
//}
//
//
//#pragma mark---显示播放界面
//-(void)showDetailControl{
//    
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    self.view.frame=window.bounds;
//    [window addSubview:self.view];
//    self.view.y=window.bounds.size.height;
//    [UIView animateWithDuration:1 animations:^{
//        self.view.y=0;
//    } completion:^(BOOL finished) {
//                //播放音频文件;
//        self.music=[CLMuiscTool getCurrentMusic];
//        self.playOrPauseButton.selected=YES;
//        [self play:_music.filename];
//        [self setAlbumImageView];
//        [self createTimerForCurrentButton];
//    }];
//    
//    
//}
//
//#pragma mark---点击button
////回到主界面
//- (IBAction)clickBackButton {
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.view.y=window.bounds.size.height;
//        
//    } completion:^(BOOL finished) {
//        
//        self.showViewWhenCallBack(self.playOrPauseButton.selected);
//        [self closeTimer];
//        
//        
//    }];
//    
//    
//}
//
//#pragma mark--播放时间~进度设置
//
//-(void)createTimerForCurrentButton{
//    
//    if (self.currentTimer) {
//        
//        [self closeTimer];
//    }
//    self.currentTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setcurrentTimer) userInfo:nil repeats:YES];
//    
//}
//-(void)setcurrentTimer{
//    
//    [self.currentTimeButton setTitle:[self changeTimeWithInterval:self.player.currentTime] forState:UIControlStateNormal];
//    CGFloat progress=self.player.currentTime/self.player.duration;
//    CGFloat offsetX=self.view.width-self.currentTimeButton.width-self.durationLabel.width;
//    if (progress*offsetX<WITDH) {
//    
//        self.offsetXforSupView.constant=progress*offsetX;
//        self.progressView.width=self.currentTimeButton.center.x;
//    }
//   
//}
//-(void)closeTimer{
//    
//    [self.currentTimer invalidate];
//    self.currentTimer=nil;
//}
//
//#pragma mark---手势
//
//- (IBAction)ClickPanGesture:(UIPanGestureRecognizer *)sender {
//    
//    
//    
//    CGPoint point=[sender translationInView:sender.view];
//    
//    self.offsetXforSupView.constant+=point.x;
//    CGFloat offsetX=self.view.width-self.currentTimeButton.width-self.durationLabel.width;
//    double offsetProgress = self.offsetXforSupView.constant / offsetX;
//    self.progressView.width=self.currentTimeButton.center.x;
//    [sender setTranslation:CGPointZero inView:sender.view];
//    if (sender.state==UIGestureRecognizerStateBegan) {
//        
//        [self closeTimer];
//    } else if (sender.state==UIGestureRecognizerStateEnded) {
//        
//        self.player.currentTime=offsetProgress*self.player.duration;
//        
//        
//        if (self.player.playing) {
//            [self createTimerForCurrentButton];
//        }
//       
//    }
//    
//}
//
//
//
//#pragma mark---专辑封面
//-(void)setAlbumImageView{
//    self.iconView.hidden=NO;
//    self.iconView.image=[self getCircularImage:[UIImage imageNamed:_music.icon] andRect:_iconView.bounds];
//    //self.iconView.backgroundColor=[UIColor grayColor];
//
//    
//}
//-(UIImage *)getCircularImage:(UIImage *)image andRect:(CGRect)rect{
//    
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    
//    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:rect];
//    [path addClip];
//    [image drawInRect:rect];
//    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//    
//    
//}
//
//
//-(NSString *)changeTimeWithInterval:(NSTimeInterval)interval{
//    
//    
//    return [NSString stringWithFormat:@"%02d:%02d",(int)interval/60,(int)interval%60];
//}
//
//
//
//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden=YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    
//       
//}
//
//-(void)dealloc{
//    
//    //[super dealloc];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"change" object:nil];
//    
//}
//



@end
