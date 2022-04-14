//
//  TGTNMyExcelToolBaseLeftModel.m
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import "TGTNMyExcelToolBaseLeftModel.h"

@implementation TGTNMyExcelToolBaseLeftModel

#pragma mark ------ get
- (NSMutableArray *)listData {
    if (_listData) return _listData;
    _listData = [NSMutableArray new];
    return _listData;
}

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self _tgtnInitData];
    }
    return self;
}
/// 初始化数据
- (void)_tgtnInitData {
    
}

#pragma mark ------ Private

#pragma mark ------ Public

@end
