//
//  TGTNMyExcelToolExcelView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolBaseView.h"

#import "TGTNMyExcelToolExcelMainView.h"
#import "TGTNMyExcelToolExcelHeadView.h"
#import "TGTNMyExcelToolExcelLeftFunctionView.h"
#import "TGTNMyExcelToolExcelHeadFunctionView.h"

#import "TGTNMyExcelToolExcelHeadChildModel.h"
#import "TGTNMyExcelToolExcelMainChildItemModel.h"
#import "TGTNMyExcelToolExcelHeadFunctionModel.h"
#import "TGTNMyExcelToolExcelLeftFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelView : TGTNMyExcelToolBaseView

/// 头部功能按钮点击
@property (nonatomic, copy) void(^ _Nullable headFunctionClickConfig)(NSIndexPath *indexPath);
/// 左边功能按钮点击
@property (nonatomic, copy) void(^ _Nullable leftFunctionClickConfig)(NSIndexPath *indexPath);

/// 头部数据
@property (nonatomic, strong) NSMutableArray *headListData;
/// 内容数据
@property (nonatomic, strong) NSMutableArray *contentListData;

/// 插入列
/// @param index 索引
- (void)tgtnInsetRowWithIndexPath:(NSInteger) index;
/// 插入行
/// @param index 索引
- (void)tgtnInsetSectionWithIndexPath:(NSInteger) index;
/// 删除列
/// @param index 索引
- (void)tgtnDeleteRowWithIndexPath:(NSInteger) index;
/// 删除行
/// @param index 索引
- (void)tgtnDeleteSectionWithIndexPath:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
