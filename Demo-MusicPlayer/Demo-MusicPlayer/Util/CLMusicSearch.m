//
//  CLMusicSearch.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/6.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "CLMusicSearch.h"
#import "CLMusic.h"
#import "CLMuiscTool.h"




static CLMusicSearch *_manager;




//http://geci.me/api/song/\u6d77\u9614\u5929\u7a7a
//http://box.zhangmen.baidu.com/x?op=12&count=1&title=海阔天空

@interface CLMusicSearch ()
@property (nonatomic,copy) void(^progress)(int64_t curerntByte,int64_t totalByte);
@property (nonatomic,copy) void(^sucsees )(NSString * objct,id respone,NSString *keyString);
@property (nonatomic,copy) void(^failed  )(id objec,id error,NSString *keyString);
@property (nonatomic,strong) NSString *keyString;
@property (nonatomic,strong) NSMutableDictionary *resumeDataDic;
@property (nonatomic,strong) NSMutableDictionary *taskDic;
@property (nonatomic,strong) NSMutableDictionary *sessionDic;
@property (nonatomic,strong) NSOperationQueue *queue;

@end
@implementation CLMusicSearch

+(instancetype)searchManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _manager=[[self alloc] init];
       
    });
    
    return  _manager;
}

-(instancetype)init{
    
    
    if (self=[super init]) {
        
        _taskDic = [NSMutableDictionary dictionary];
        self.resumeDataDic = [NSMutableDictionary dictionary];
       
    }
    
    return self;
}



//-(void )searchMusicByQuery:(NSString *)fileName{
//    
//    NSString *ecodeStr=[self econdeSting:fileName];
//    NSURL *url=[NSURL URLWithString:ecodeStr];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSHTTPURLResponse *respos = (NSHTTPURLResponse *)response;
//        if (respos.statusCode==200) {
//            
//            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            _lyricArray=dic[@"song"];
//            
//            if (_lyricArray!=nil) {
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"searchMusic" object:self userInfo:@{@"searchMusic":_lyricArray}];
//            }
//            
//
//            
//        } else {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"reuslt=nil" object:self userInfo:@{@"searchMusic":@"搜索结果为空"}];
//        }
//               
//    }];
//    
//    [task resume];
//    
//    
//}
//
//
//
//-(NSString *)searchArtist:(NSString *)urlStr andIndex:(NSInteger )index{
//    
//        __block  NSString *str ;
//        NSString *ecodeStr=[self econdeSting:urlStr];
//        NSURL *url=[NSURL URLWithString:ecodeStr];
//        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//        [request setHTTPMethod:@"GET"];
//        NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            
//            NSDictionary *dic   = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSDictionary * dics = dic[@"result"];
//            str                 = dics[@"name"];
//            
//        }];
//
//       [task resume];
//    
//    return str;
//    
//}
//
//-(NSString  *)searchCover:(NSString *)urlStr andIndex:(NSInteger )index{
//    
//    __block  NSString *str ;
//    
//    NSString *ecodeStr=[self econdeSting:urlStr];
//    NSURL *url=[NSURL URLWithString:ecodeStr];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        
//        NSDictionary *dic   = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSDictionary * dics = dic[@"result"];
//        if (index==0) {
//            
//            str             = dics[@"cover"];
//        } else {
//            
//            str             = dics[@"thumb"];
//        }
//    }];
//    
//    [task resume];
//    
//    return str;
//    
//}

//+(NSURL *)downloadMusic:(NSString *)muiscStr{
//    
//    __block NSURL *locationUrl;
//    NSURL *url=[NSURL URLWithString:muiscStr];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    NSURLSessionDownloadTask *task=[[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        locationUrl=location;
//    }];
//    
//    [task resume];
//    
//    return locationUrl;
//
//}
//
//+(void )getMusicContens:(NSString *)remotePath{
//    
//    __block NSDictionary *songDic=nil;
//    NSURL *url=[NSURL URLWithString:remotePath];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//    
//        NSHTTPURLResponse *respos = (NSHTTPURLResponse *)response;
//        if (respos.statusCode==200) {
//            
//            NSDictionary *dic     = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            
//                
//            songDic               = dic[@"data"][@"songList"][0];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"download" object:self userInfo:@{@"music":songDic}];
//            
//            
//        }
//        
//                
//    }];
//    
//    [task resume];
//    
//    
//    
//}


-(NSOperationQueue *)queue{
    
    if (!_queue) {
        
        _queue = [NSOperationQueue new];
    }
    
    return _queue;
}

//下载歌词
+(void)downloadLrc:(NSURL *)url  completionHandler:(void(^)(id objct, id erro))complete{
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task=[[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
            NSLog(@"歌词搜索错误");
        }
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
            
            complete(location,error);
        }
        
        
    }];
    
    [task resume];
    
    
}

//下载歌曲任务
-(void)downloadMusic:(NSString *)string successHandler:(void (^)(NSString *, id, NSString *))success
                                        andFailHander:(void (^)(id, id, NSString *))failHander
                                        andProgrees:(void (^)(int64_t, int64_t))preogress{
    
   
        NSBlockOperation *opreation=[NSBlockOperation blockOperationWithBlock:^{
        
        NSURL  *url= [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:
                               configuration delegate:self delegateQueue:[NSOperationQueue new]];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request];
        
        self.sucsees   = success;
        self.failed    = failHander;
        [task resume];
        _taskDic[string] = task;
        _resumeDataDic[string] = @0;
        
    }];
    
    self.queue.maxConcurrentOperationCount=2;
    [self.queue addOperation:opreation];
    
        
    
    
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
  
    NSArray *allKey = [_taskDic allKeys];
    for (NSString *key in allKey) {
        
        if (downloadTask == _taskDic[key]) {
            
            self.keyString = key;
            break ;
        }
    }
    if (self.keyString.length>0) {
        
        [_taskDic removeObjectForKey:self.keyString];
        [self.resumeDataDic removeObjectForKey:self.keyString];
    }
    
    [self.delegate havedownloadedMusic:self andlocaPath:location.path andKeyString:self.keyString];
    if (self.sucsees) {
        
        self.sucsees(location.path,downloadTask.response,self.keyString);
    }
    
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    
    NSString *keyString;
    NSArray *allKey = [_taskDic allKeys];
    for (NSString *key in allKey) {
        
        if (downloadTask == _taskDic[key]) {
            
            keyString = key;
            break ;
        }
    }

    [self.delegate downloadTaskProgress:self andEd:totalBytesWritten+[self.resumeDataDic[keyString] intValue] andKeyString:keyString andAll:totalBytesExpectedToWrite withDownTask:downloadTask];
    
    
        //self.progress(totalBytesWritten,totalBytesExpectedToWrite);
}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    
    //error[NSURLErrorKey];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    
    if (error) {
        
        NSArray *allKey=[_taskDic allKeys];
        for (NSString *key in allKey) {
            
            if (task == _taskDic[key]) {
                
                self.keyString = key;
                break ;
            }
        }
        if (self.keyString.length>0) {
            
              [_taskDic removeObjectForKey:self.keyString];
            
            if ([self.keyString containsString:@"?"]) {
                
                [_resumeDataDic removeObjectForKey:self.keyString];
            }
            
        }
        
        NSLog(@"%@测试失败",self.keyString);
        
        [self.delegate downloadFailer:self withKeyString:self.keyString andDownTask:task andError:error];
        if (self.failed) {
            
            self.failed(httpResponse,error,self.keyString);

        }
       
    }
    
}

//获取歌曲列表网络请求
-(void)getMusicList:(NSString *)urlString successHandler:(void (^)(id, id))success
                                          andFailHandle: (void (^)(id, NSError *))failHander{
    
    NSString *econdeString=[self econdeSting:urlString];
    NSURL *url=[NSURL URLWithString:econdeString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                success(data,httpResponse);

                
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                  failHander(response,error);
                
            });

          
        }
        
    }];
    
    [task resume];
    
}

-(void )getMusicListByID:(NSString *)ID successHandler:(void (^)(id, id))success
                                        andFailHanle:(void (^)(id, NSError *))faileHander
{
    
    NSString *econdeString=[self econdeSting:ID];
    NSURL *url=[NSURL URLWithString:econdeString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode==200) {
            
            success(data,httpResponse);
            
        } else {
            
            faileHander(httpResponse,error);
        }
        
    }];
    
    [task resume];
}

-(void)sendHeadRequet:(NSString *)urlString successHandler:(void (^)(int64_t))succsess andFailurHandle:(void (^)(NSHTTPURLResponse *, NSError *))failure{
    
    
    NSString *econdeString=[self econdeSting:urlString];
    NSURL *url=[NSURL URLWithString:econdeString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
       // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (httpResponse.statusCode==200&&response.expectedContentLength) {
            
            succsess(response.expectedContentLength);
            
            
        } else {
            
            failure(httpResponse,error);
            
        }
        
    }];
    
    [task resume];
    
}


-(NSString *)econdeSting:(NSString *)file{
    
    return  [file stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
}


#pragma mark -- recv pasuOrsStart click


-(void)recvResumClick:(CLMusicOnBaiDuIcon *)music{
    
    NSURLSessionDownloadTask *task = _taskDic[music.songLink];
    [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
    
        
        self.resumeDataDic[music.songLink] = @(resumeData.length);
        
    }];
    
    self.sucsees  = nil;
    self.failed   = nil;
    self.progress = nil;
    
    
}

-(void)recvStartClick:(CLMusicOnBaiDuIcon *)music{
    
//    NSData *resumeData = self.resumeDataDic[music.songLink];
//    NSURLSession *session = _sessionDic[music.songLink];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithResumeData:resumeData];
//    _taskDic[music.songLink] = task;
//    [task resume];
    
    NSString *urlString = music.songLink;
    NSRange range = [urlString rangeOfString:@"?"];
    if (range.location) {
        
        urlString = [urlString substringToIndex:range.location];
        
    }
    
    NSURL  *url= [NSURL URLWithString:urlString];
    int64_t currentLenth = [self.resumeDataDic[music.songLink] intValue];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *resumStr = [NSString stringWithFormat:@"bytes=%lld-",currentLenth];
    request.HTTPMethod = @"post";
    [request setValue:resumStr forHTTPHeaderField:@"Range"];
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             configuration delegate:self delegateQueue:[NSOperationQueue new]];
    NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request];
    [task resume];
    self.taskDic[urlString] = task;

    
}

-(void)POST:(NSString *)url parameters:(NSMutableDictionary *)parameters
                            andBodyData:(NSData *)data andFileName:(NSString *)fileName
                            withsuccess:(void (^)(NSURLResponse *, id))success
                            orFailure:(void (^)(NSURLResponse *, NSError *))failure{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08x%08x",arc4random(),arc4random()];
    NSMutableData *body = [NSMutableData data];
    
    ///表单数据
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableString *fieldStr = [NSMutableString string];
        [fieldStr appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
        [fieldStr appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key]];
        [fieldStr appendString:[NSString stringWithFormat:@"%@", obj]];
        [body appendData:[fieldStr dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    ///图片数据部分
    NSMutableString *topStr = [NSMutableString string];
    
    
    /**拼装成格式：
     --Boundary+72D4CD655314C423
     Content-Disposition: form-data; name="uploadFile"; filename="001.png"
     Content-Type:image/png
     Content-Transfer-Encoding: binary
     
     ... contents of boris.png ...
     */
    [topStr appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
    [topStr appendFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=%@\r\n",fileName];
    [topStr appendString:@"Content-Type:image/png\r\n"];
    [topStr appendString:@"Content-Transfer-Encoding: binary\r\n\r\n"];
    [body appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 结束部分
    NSString *bottomStr = [NSString stringWithFormat:@"--%@--", boundary];
    /**拼装成格式：
     --Boundary+72D4CD655314C423--
     */
    [body appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 设置请求类型为post请求
    request.HTTPMethod = @"post";
    // 设置request的请求体
    request.HTTPBody = body;
    // 设置头部数据，标明上传数据总大小，用于服务器接收校验
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField:@"Content-Length"];
    // 设置头部数据，指定了http post请求的编码方式为multipart/form-data（上传文件必须用这个）。
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            id responseObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if (!error) {
                
                success(response,responseObj);
                
            } else {
                
                failure(response,error);
                
            }

            
        });
        
    }];
    
    [task resume];

    
}





@end
