//
//  TGTNMyExcelToolBaseHeadModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>

#import "TGTNMyExcelToolBaseHeadChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseHeadModel : NSObject

/// 列表数据
@property (nonatomic, strong) NSMutableArray *listData;

/// 宽度
@property (nonatomic, assign) float headAllWidth;
/// 高度
@property (nonatomic, assign) float headMaxHeight;

@end

NS_ASSUME_NONNULL_END
