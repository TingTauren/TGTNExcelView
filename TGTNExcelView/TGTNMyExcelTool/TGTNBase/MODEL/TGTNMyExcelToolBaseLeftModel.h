//
//  TGTNMyExcelToolBaseLeftModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>

#import "TGTNMyExcelToolBaseLeftChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseLeftModel : NSObject

/// 列表数据
@property (nonatomic, strong) NSMutableArray *listData;

/// 宽度
@property (nonatomic, assign) float leftMaxWidth;
/// 高度
@property (nonatomic, assign) float leftAllHeight;

@end

NS_ASSUME_NONNULL_END
