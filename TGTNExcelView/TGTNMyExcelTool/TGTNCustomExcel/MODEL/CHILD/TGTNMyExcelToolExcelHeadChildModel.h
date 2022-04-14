//
//  TGTNMyExcelToolExcelHeadChildModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolBaseHeadChildModel.h"
#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolExcelHeadCustomDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelHeadChildModel : TGTNMyExcelToolBaseHeadChildModel

/// 数据源
@property (nonatomic, strong) TGTNMyExcelToolExcelHeadCustomDataModel *customDataModel;

/// 点击回调
@property (nonatomic, copy) void(^ _Nullable buttonClickConfig)(NSInteger index, UIView *mySelf);

@end

NS_ASSUME_NONNULL_END
