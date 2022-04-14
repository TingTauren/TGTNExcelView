//
//  TGTNMyExcelToolExcelMainCustomView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolBaseMainChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelMainCustomView : UIView

/// 数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseMainChildModel *model;

/// 设置数据源
- (void)tgtnSetModel:(id)model;

/// 添加子视图
- (void)tgtnAddChildView;
/// 插入子视图
- (void)tgtnInsetChildView:(NSInteger) index;
/// 删除子视图
- (void)tgtnDeleteChildView:(NSInteger) index;
/// 删除全部子视图
- (void)tgtnDeleteAllChildView;
/// 修改子视图大小
- (void)tgtnChangeChildFrame;
/// 修改子视图数据源
- (void)tgtnChangeChildData;
/// 获取当前选中视图
/// @param index 索引
- (UIView *)tgtnGetCurrenSelectViewWithIndex:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
