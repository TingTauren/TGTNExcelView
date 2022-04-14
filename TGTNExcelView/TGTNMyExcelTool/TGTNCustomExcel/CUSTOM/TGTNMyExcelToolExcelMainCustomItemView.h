//
//  TGTNMyExcelToolExcelMainCustomItemView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolExcelMainChildItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelMainCustomItemView : UIView

/// 数据模型
@property (nonatomic, strong) TGTNMyExcelToolExcelMainChildItemModel *model;

/// 设置数据源
- (void)tgtnSetModel:(id)model;
/// 添加子视图
- (void)tgtnAddChildView;
/// 修改子视图大小
- (void)tgtnChangeChildFrame;

@end

NS_ASSUME_NONNULL_END
