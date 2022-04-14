//
//  TGTNMyExcelToolBaseMainModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>

#import "TGTNMyExcelToolBaseMainChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseMainModel : NSObject

/// 列表数据
@property (nonatomic, strong) NSMutableArray *listData;

/// 选中位置
@property (nonatomic, strong) NSIndexPath * _Nullable selectIndex;

/// 宽度
@property (nonatomic, assign) float mainAllWidth;
/// 高度
@property (nonatomic, assign) float mainAllHeight;

@end

NS_ASSUME_NONNULL_END
