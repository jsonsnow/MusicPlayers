//
//  CLArtist.h
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/17.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLArtist : NSObject
@property (nonatomic,strong) NSString *yyr_artist;
@property (nonatomic,strong) NSString *artistid;
@property (nonatomic,strong) NSString *artistpic;
@property (nonatomic,strong) NSString *artistname;
//@property (nonatomic,strong) NSString *country;
//@property (nonatomic,strong) NSString *language;

+(instancetype)pareArtistData:(NSDictionary *)dic;

@end
