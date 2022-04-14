//
//  TGTNMyExcelToolExcelHeadCustomView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolExcelHeadChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelHeadCustomView : UIView

/// 数据模型
@property (nonatomic, strong) TGTNMyExcelToolExcelHeadChildModel *model;

/// 设置数据源
- (void)tgtnSetModel:(id)model;

@end

NS_ASSUME_NONNULL_END
