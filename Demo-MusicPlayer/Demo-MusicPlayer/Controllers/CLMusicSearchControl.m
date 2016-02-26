//
//  CLMusicGroup.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/5.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicSearchControl.h"
#import "CLMusicSearch.h"
#import "CLMuiscTool.h"
#import "CLMusic.h"
#import <UIImageView+WebCache.h>
#import "CLCachData.h"
#import "CLCachDataTool.h"
#import <FSAudioStream.h>
#import "UIView+Extension.h"
#import "TSMessage.h"
#import "CLAudioTool.h"
#import "MBProgressHUD+KR.h"

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define STATUES_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAV_HEINGT     [[UINavigationController alloc] init].navigationBar.frame.size.height


const static NSString *baseBaiUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.search.catalogSug&format=json&size=20&query=";
const static NSString *basePlayUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.song.play&songIds=877578";
const static NSString *baseMusicUrl=@"http://ting.baidu.com/data/music/links?songIds=";

const static NSString *baseMusicRecoUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.artist.getSongList&tinguid=7994&limits=20";



const static NSString *baseUrl=@"http://geci.me/api/lyric";

const static NSString *baseUrlArtist=@"http://geci.me/api/artist/:artist_id";

const static NSString *baseUrlCover=@"http://geci.me/api/cover/:album_id";

const static NSString *baseUrlSong=@"http://geci.me/api/song/:";

const static NSString *baseMusicDetail=@"http://ting.baidu.com/data/music/links?songIds=";

const static NSString *baiDuBaseUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?";

const static NSString *baiDuListUrl=@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&size=10&type=";


@interface CLMusicSearchControl ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSString *searchMusicPath;
@property (nonatomic,strong) NSString *searchMusicID;
@property (nonatomic,strong) FSAudioStream *audioStream;
@property (nonatomic,strong) NSArray *showArray;
@property (nonatomic,getter=isOnSearch) BOOL onSearch;
@property (nonatomic,strong) UITableView *tableView;



@end

@implementation CLMusicSearchControl


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    self.onSearch=NO;
    [TSMessage setDefaultViewController:self];
    self.delegate = [CLAudioTool sharedAudiManager];
    [self createTableView];
    self.searchBar = [[UISearchBar alloc] initWithFrame:
                      CGRectMake(0, NAV_HEINGT+STATUES_HEIGHT, SCREEN_WIDTH, 44)];
    [self.view addSubview:self.searchBar] ;
    self.searchBar.delegate=self;
    if (self.searchString!=nil) {
        
        [self seatherMusic:self.searchString=[NSString stringWithFormat:@"%@%@",
                                              baseBaiUrl,self.searchString] ];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playError:) name:@"searchPlayError" object:nil];

    
}

-(void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEINGT+STATUES_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEINGT-STATUES_HEIGHT-40)];
    self.tableView.dataSource =self;
    self.tableView.delegate   =self;
    //CGRect frame = self.tableView.frame;
    [self.view addSubview:self.tableView];
    
    
}

-(void)playError:(NSNotification *)infor{
    
    
    self.tableView.userInteractionEnabled=NO;
    NSDictionary *dic=infor.userInfo;
    [TSMessage showNotificationWithTitle:@"错误" subtitle:dic[@"description"] type:TSMessageNotificationTypeError];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(1);
        self.tableView.userInteractionEnabled=YES;
    });

    
}

-(void)clikBack{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)animationForTableView{
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled=NO;
    self.tableView.x=[UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:2 animations:^{
        
        self.tableView.x=0;
        
    } completion:nil];
    
    window.userInteractionEnabled=YES;
    
}


#pragma mark --关键字搜索逻辑重写


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    self.showArray=nil;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
    if (self.isOnSearch||searchBar.text.length==0) {
        
        NSLog(@"正在搜索<请输入要搜索的内容");
        return;
    }
    
    
    self.onSearch=YES;
    NSString *pathStr=[NSString stringWithFormat:@"%@%@",baseBaiUrl,searchBar.text];
    dispatch_async(dispatch_queue_create("sleep", DISPATCH_QUEUE_CONCURRENT), ^{
        
        sleep(2);
        self.onSearch=NO;
    });

    [self seatherMusic:pathStr];
    
}
-(void)seatherMusic:(NSString *)string{
    
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在搜索"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.searchMusicPath=string;
        
        [[CLMusicSearch searchManager] getMusicList:string successHandler:^(id data, id response) {
            
            
            NSData *revData=data;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:revData options:0 error:nil];
            NSArray *musicArray = [CLMuiscTool onlineFirstMusci:dic];
            if (musicArray.count==0) {
                
                return ;
            }
            for (CLMusicOnBaiDu *music in musicArray) {
                
                NSString *musicPathByID=[NSString stringWithFormat:@"%@%@",baseMusicDetail,music.songid];
                NSLog(@"%@",musicPathByID);
                [[CLMusicSearch searchManager] getMusicList:musicPathByID successHandler:^(id data, id response) {
                    
                    NSAssert([NSThread isMainThread], @"updata ui must in main thread");
                    [hud hide:YES];
                    NSData *recData=data;
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recData options:0 error:nil];
                    self.showArray=[[CLMuiscTool  musicManager] onlineMusciByMusicID:dic];
                   
                        
                        [self.tableView reloadData];
                
                    
                } andFailHandle:^(id response, NSError *error) {
                    
                    NSAssert([NSThread isMainThread], @"updata ui must in main thread");
                    [MBProgressHUD showError:@"搜索错误"];
                    NSLog(@"%@",error.userInfo);
                    self.onSearch=NO;
                    NSLog(@"ID搜索粗无");
                    
                }];
                
            }
            
        } andFailHandle:^(id response, NSError *error) {
            
            NSAssert([NSThread isMainThread], @"updata ui must in main thread");
            NSLog(@"%@",error.userInfo);
            self.onSearch=NO;
            NSLog(@"搜索错误");
            [MBProgressHUD showError:@"搜索错误"];
            
        }];
        
    });
    
    

    
    
}




-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.searchString=nil;
    
}
-(void)closeKeyBoard{
    
    [self.searchBar resignFirstResponder];
}


#pragma mark---UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.showArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"searchCell"] ;
        
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"searchCell"];
    }
    if (self.showArray.count<=0) {
        return nil;
    }
    CLMusicOnBaiDuIcon *onelin=self.showArray[indexPath.row];
    cell.textLabel.text=onelin.songName;
    cell.detailTextLabel.text=onelin.artistName;
    CGRect rect=CGRectMake(0, 0, 60, 60);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:onelin.songPicSmall]
                      placeholderImage:[self getCircularImage:[UIImage imageNamed:@"008"] andRect:rect]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    return cell;
    
}

#pragma mark table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CLMusicOnBaiDuIcon *music = self.showArray[indexPath.row];
    [self.delegate clickMusicSearchofRow:self andMusic:music];
    
    [[CLMuiscTool musicManager] downloadMuisc:music];
  
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.searchBar resignFirstResponder];
    
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

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchPlayError" object:nil];
    
}

//#pragma mark ---下载任务
//
//-(void)downloadTak{
//    
//        CLMusicOnBaiDuIcon *music  = [CLMuiscTool getOnlineCurrentMusic];
//   
//        [[CLMuiscTool musicManager ] addDownloadMusic:music];
//    
//        [[CLMusicSearch searchManager] downloadMusic:music.songLink successHandler:^(id location, id response, NSString *keyString) {
//            
////            [CLMuiscTool addMusicForPlit:[[CLMuiscTool musicManager] getDonloadMuisc:keyString] withlocation:nil];
////            
////            [CLMuiscTool addMusicForLoaction:[[CLMuiscTool musicManager ] getDonloadMuisc:keyString] withlocation:location];
//            
//           ;
//            
//        } andFailHander:^(id response, id erro, NSString *keyString) {
//            
////            NSError *error=erro;
////            NSLog(@"%@",error.userInfo);
////            NSLog(@"下载错误");
////            [[CLMuiscTool musicManager] deleteFailureMusic:keyString];
////
//            
//        } andProgrees:^(int64_t writedData, int64_t totalData) {
//          
//            
//       }];
//
//        
//  
//    
//    
//}

// 收起键盘
//
//
//
//#pragma mark ---充当在线歌曲管理的 解耦需重写网络情况逻辑
//
//
//
//
//
//#pragma mark -- 通知回调
//


//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchMusic:) name:@"searchMusic" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(download:) name:@"download" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultEqualNil:) name:@"reuslt=nil" object:nil];

//-(void)resultEqualNil:(NSNotification *)sender{
//
//    NSDictionary *dic = sender.userInfo;
//    NSString *str= dic[@"searchMusic"];
//    NSLog(@"%@",str);
//    self.onSearch=NO;
//
//}
//
//-(void)searchMusic:(NSNotification *)sender{
//
//    [[CLCachData sharedCachDataManager] cleanCachData];
//    NSDictionary *dic = sender.userInfo;
//    _fisrtResult=dic[@"searchMusic"];
//    if (_fisrtResult.count==0) {
//        NSLog(@"搜索结果为空请重新输入");
//        self.onSearch=NO;
//    } else {
//        _fisrtResult = [CLMuiscTool onlineFirstMusci:_fisrtResult];
//
//        for (NSInteger i=0; i<self.fisrtResult.count; i++) {
//
//                        CLMusicOnBaiDu *music=self.fisrtResult[i];
//                        NSString *musicPathByID=[NSString stringWithFormat:@"%@%@",baseMusicDetail,music.songid];
//                        NSLog(@"%@",musicPathByID);
//            [CLMusicSearch getMusicContens:musicPathByID];
//
//
//                    }
//
//    }
//}
//
//-(void)download:(NSNotification *)sender{
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        NSDictionary *dic = sender.userInfo;
//        _secondResult=dic[@"music"];
//        CLMusicOnBaiDuIcon *music = [CLMuiscTool onlineMusciByMusicID:_secondResult];
//        if (music!=nil) {
//            [_searchResult addObject:music];
//            [self.tableView reloadData];
//
//        }
//
//        if (_searchResult.count==self.fisrtResult.count) {
//            NSLog(@"搜索结束");
//            self.onSearch=NO;
//        }
//
//
//    });
//
//}


//搜索逻辑
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//
//     [searchBar resignFirstResponder];
//    if (self.isOnSearch||searchBar.text.length==0) {
//
//        NSLog(@"正在搜索<请输入要搜索的内容");
//        return;
//    }
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [_searchResult removeAllObjects];
//
//        self.onSearch=YES;
//        NSString *pathStr=[NSString stringWithFormat:@"%@%@",baseBaiUrl,searchBar.text];
//        self.searchMusicPath=pathStr;
//        [CLMusicSearch searchMusicByQuery:pathStr];
//
//    });
//
//    dispatch_async(dispatch_queue_create("sleep", DISPATCH_QUEUE_CONCURRENT), ^{
//
//        sleep(2);
//        self.onSearch=NO;
//    });
//
//
//}

//#pragma mark -音乐推荐列表
//
//- (IBAction)clickList:(UISegmentedControl *)sender {
//    
//    self.showArray=nil;
//    [self.tableView reloadData];
//    NSString *string;
//    
//    if (sender.selectedSegmentIndex==3) {
//        
//        //sender.selectedSegmentIndex=16;
//        string=[NSString stringWithFormat:@"%@21",baiDuListUrl];
//        
//    } else {
//        
//        string=[NSString stringWithFormat:@"%@%ld",baiDuListUrl,sender.selectedSegmentIndex];
//        
//    }
//    
//    if (sender.selectedSegmentIndex==0) {
//        
//        string=[NSString stringWithFormat:@"%@24",baiDuListUrl];
//        
//    }
//    
//    [self animationForTableView];
//    [self searchListMusic:string];
//    
//    
//}
//
//-(void)searchListMusic:(NSString *)string{
//    
//    
//    
//    [[CLMusicSearch searchManager] getMusicList:string successHandler:^(id data, id response) {
//        
//        NSData *rcvdata=data;
//        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:rcvdata options:0 error:nil];
//        NSArray    *array =dic[@"song_list"];
//        NSArray *Musicarray   = [CLMuiscTool muiscList:array];
//        
//        for (CLMusicOnBaiDuIcon *music in Musicarray) {
//            
//            NSString *musicPathByID=[NSString stringWithFormat:@"%@%@",baseMusicDetail,music.songId];
//            [[CLMusicSearch searchManager] getMusicList:musicPathByID successHandler:^(id data, id response) {
//                
//                NSData *revData=data;
//                NSDictionary *dic  = [NSJSONSerialization JSONObjectWithData:revData options:0 error:nil];
//                self.showArray     = [[CLMuiscTool musicManager] muiscListForContens:dic];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [self.tableView reloadData];
//                });
//                
//                
//                
//            } andFailHandle:^(id response, NSError *error) {
//                
//                NSLog(@"%@",error.userInfo);
//                self.onSearch=NO;
//                
//            }];
//            
//            
//        }
//        
//        
//    } andFailHandle:^(id response, NSError *error) {
//        
//        NSHTTPURLResponse *res=response;
//        NSLog(@"%ld error:%@",res.statusCode,error.userInfo);
//        self.onSearch=NO;
//        NSLog(@"榜单错误");
//        
//    }];
//    
//    
//}





@end
