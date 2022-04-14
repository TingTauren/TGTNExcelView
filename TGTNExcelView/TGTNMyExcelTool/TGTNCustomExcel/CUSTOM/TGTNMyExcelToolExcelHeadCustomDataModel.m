//
//  TGTNMyExcelToolExcelHeadCustomDataModel.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelHeadCustomDataModel.h"

@implementation TGTNMyExcelToolExcelHeadCustomDataModel

/// 获取字典
- (NSMutableDictionary *)tgtnGetCustomDataDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_columnType forKey:@"columnType"];
    [dict setObject:_title forKey:@"title"];
    [dict setObject:_content forKey:@"content"];
    [dict setObject:_canDel forKey:@"canDel"];
    [dict setObject:_hint forKey:@"hint"];
    [dict setObject:_contentColumnHint forKey:@"contentColumnHint"];
    return dict;
}

@end
