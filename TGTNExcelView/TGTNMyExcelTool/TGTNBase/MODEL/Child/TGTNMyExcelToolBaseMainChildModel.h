//
//  TGTNMyExcelToolBaseMainChildModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>

#import "TGTNMyExcelToolBaseMainChildItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseMainChildModel : NSObject

/// 子列表数据
@property (nonatomic, strong) NSMutableArray *listData;

/// 是否选中
@property (nonatomic, assign) BOOL isSelect;

/// 索引
@property (nonatomic, assign) NSInteger index;
/// 宽度
@property (nonatomic, assign) float allWidth;
/// 高度
@property (nonatomic, assign) float maxHeight;
/// 最小高度
@property (nonatomic, assign) float minHeight;

@end

NS_ASSUME_NONNULL_END
