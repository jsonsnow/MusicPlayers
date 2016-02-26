//
//  BaseNetManager.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/5.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "BaseNetManager.h"
#import <AFNetworking.h>


static AFHTTPSessionManager *manager = nil;
@implementation BaseNetManager

+(AFHTTPSessionManager *)sharedAFManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        manager = [AFHTTPSessionManager manager];
        //manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
        
    });
    
    return manager;
    
}

+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))complete{
    
    return [[self sharedAFManager] GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,error);
    }];
    
}

+(id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))complete{
    return [[self sharedAFManager] POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,error);
    }];;
    
    
}

@end
