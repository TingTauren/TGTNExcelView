//
//  TGTNMyExcelToolExcelMainChildCustomDataModel.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelMainChildCustomDataModel.h"

@implementation TGTNMyExcelToolExcelMainChildCustomDataModel

- (void)setVideoPath:(NSString *)videoPath {
    _videoPath = videoPath;
    
//    if ([_videoPath tgtn_isNotNull:YES] && ![_videoPath tgtn_isUrl]) {
//        // 封面
//        _coverImage = [TGTNVideoOperation tgtn_getVideoCoverImage:_videoPath];
//    } else {
//        _coverImage = nil;
//    }
}

/// 获取字典
- (NSMutableDictionary *)tgtnGetCustomDataDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_columnType forKey:@"columnType"];
    [dict setObject:_title forKey:@"title"];
    [dict setObject:_content forKey:@"content"];
    [dict setObject:_canDel forKey:@"canDel"];
    [dict setObject:_hint forKey:@"hint"];
    [dict setObject:_videoPath forKey:@"videoPath"];
    [dict setObject:_imagePath forKey:@"imagePath"];
    return dict;
}

@end
