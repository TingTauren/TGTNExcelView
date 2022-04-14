//
//  TGTNMyExcelToolExcelMainView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolBaseMainView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelMainView : TGTNMyExcelToolBaseMainView

/// 修改子视图数据源
- (void)tgtnChangeChildData;

/// 插入视图行
/// @param index 索引
- (void)tgtnInsetViewSectionWithIndex:(NSInteger) index;
/// 插入视图列
/// @param index 索引
- (void)tgtnInsetViewRowWithIndex:(NSInteger) index;
/// 删除视图列
/// @param index 索引
- (void)tgtnDeleteViewRowWithIndex:(NSInteger) index;
/// 删除视图行
/// @param index 索引
- (void)tgtnDeleteViewSectionWithIndex:(NSInteger) index;
/// 获取当前选中视图
/// @param indexPath 索引
- (UIView *)tgtnGetCurrenSelectViewWithIndex:(NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
