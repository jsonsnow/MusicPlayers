//
//  CLGroupControl.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/7.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLGroupControl.h"
#import "CLMuiscStroeViewController.h"
#import "CLMusicSearchControl.h"
#import "CLMuiscTool.h"
#import "CLMusicControl.h"
#import "CLDownloadController.h"
#import "CLRecentViewController.h"

@interface CLGroupControl ()<UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lcoalMusicNum;
@property (weak, nonatomic) IBOutlet UILabel *downloadingMusic;
@property (nonatomic,copy ) NSString *searchPath;
@property (weak, nonatomic) IBOutlet UILabel *recentPlayMusicCount;



@end

@implementation CLGroupControl

/**   搜索路径获取 可以给用户一个交互 让用户选择搜索路径*/
-(NSString *)searchPath{
    
    if (!_searchPath) {
        
        _searchPath =@"Users/Aspmcll";
    }
    
    return _searchPath;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
    [self getMusicFromUserDeviec];
    self.navigationItem.title = @"我的音乐";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchButton:)];
    
    self.tableView.tableHeaderView=[self createScorView];
 
    
}
-(void)getMusicFromUserDeviec{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isFirstSearch"];
    BOOL firstSearch = ![defaults boolForKey:@"isFirstSearch"];
    if (firstSearch) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[CLMuiscTool musicManager] searchLocalMusicOnPc:self.searchPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.lcoalMusicNum.text = [NSString stringWithFormat:
                                           @"%ld首",(unsigned long)[[CLMuiscTool musicManager] musicArray].count];
                [defaults setBool:YES forKey:@"isFirstSearch"];
                
            });
            
        });
        
        
    }

}

#pragma 首界面在出现时候刷新数据
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.lcoalMusicNum.text = [NSString stringWithFormat:
                               @"%ld首",(unsigned long)[[CLMuiscTool musicManager] musicArray].count];
    NSArray *array = [[CLMuiscTool musicManager] getAllDownloadMusic];
    self.downloadingMusic.text = [NSString stringWithFormat:@"%ld首音乐正在下载",(unsigned long)array.count];
    
    self.recentPlayMusicCount.text = [NSString stringWithFormat:@"%ld首",(unsigned long)[[CLMuiscTool musicManager] getRecentPlayMusic].count];
    self.tabBarController.tabBar.hidden=NO;
                                  
}



-(UIScrollView *)createScorView{
    
    UIScrollView *scorView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.tableView.frame.size.width, 150)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"img_history_play_default.jpg"]];
    
    [scorView addSubview:imageView];
    
    return scorView;
    
}

#pragma mark -click Buttion 
- (IBAction)clickRecntPlayBtn:(id)sender {
    
    
    CLRecentViewController *recentController = [[CLRecentViewController alloc] init];
    [self.navigationController pushViewController:recentController animated:YES];
    
}

- (IBAction)clickLocalButton:(UIButton *)sender {
    
    CLMusicControl *localMusicControl = [CLMusicControl new];
    
    [self.navigationController pushViewController:localMusicControl animated:YES];
    
}

- (IBAction)clcikShowDownloadMusic:(id)sender {
    
    
    CLDownloadController *downloadControl = [CLDownloadController new];
    
    [self.navigationController pushViewController:downloadControl animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--tableview-datasourece



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0&&indexPath.row==2) {
        
         CLMuiscStroeViewController *stroControl=[CLMuiscStroeViewController new];
        
        [self.navigationController pushViewController:stroControl animated:YES];
        
    }
    
  
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (void)searchButton:(UIBarButtonItem *)sender {
   
    
    CLMusicSearchControl *search = [CLMusicSearchControl new];

    [self.navigationController pushViewController:search animated:YES];
    
}


@end
