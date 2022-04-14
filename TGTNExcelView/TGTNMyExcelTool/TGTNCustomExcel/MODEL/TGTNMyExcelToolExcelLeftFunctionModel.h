//
//  TGTNMyExcelToolExcelLeftFunctionModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolBaseLeftFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelLeftFunctionModel : TGTNMyExcelToolBaseLeftFunctionModel

/// 点击方法回调
@property (nonatomic, copy) void(^ _Nullable buttonClickConfig)(NSIndexPath *indexPath);

/// 选中索引
@property (nonatomic, strong) NSIndexPath * _Nullable selectIndexPath;

@end

NS_ASSUME_NONNULL_END
