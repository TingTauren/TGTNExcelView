//
//  TGTNMyExcelToolBaseMainChildItemModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseMainChildItemModel : NSObject

/// 索引
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 总数量
@property (nonatomic, assign) NSInteger allCount;
/// 总行数量
@property (nonatomic, assign) NSInteger allSectionCount;
/// 宽度
@property (nonatomic, assign) float itemWidth;
/// 高度
@property (nonatomic, assign) float itemHeight;

@end

NS_ASSUME_NONNULL_END
