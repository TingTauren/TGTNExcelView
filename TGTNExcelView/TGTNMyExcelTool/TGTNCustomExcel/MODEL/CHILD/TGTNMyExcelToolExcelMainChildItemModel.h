//
//  TGTNMyExcelToolExcelMainChildItemModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolBaseMainChildItemModel.h"

#import "TGTNMyExcelToolExcelMainChildCustomDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelMainChildItemModel : TGTNMyExcelToolBaseMainChildItemModel

/// 数据源
@property (nonatomic, strong) TGTNMyExcelToolExcelMainChildCustomDataModel *customDataModel;

/// 点击回调
@property (nonatomic, copy) void(^ _Nullable buttonClickConfig)(NSIndexPath *indexPath, UIView *mySelf);

@end

NS_ASSUME_NONNULL_END
