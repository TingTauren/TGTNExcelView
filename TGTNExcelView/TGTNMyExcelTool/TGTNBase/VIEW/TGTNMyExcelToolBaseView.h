//
//  TGTNMyExcelToolBaseView.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <UIKit/UIKit.h>

#import "TGTNMyExcelToolBaseMainView.h"
#import "TGTNMyExcelToolBaseHeadView.h"
#import "TGTNMyExcelToolBaseLeftView.h"
#import "TGTNMyExcelToolBaseLeftFunctionView.h"
#import "TGTNMyExcelToolBaseHeadFunctionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseView : UIView

/// 头部操作视图高度
@property (nonatomic, assign) float headFunctionHeight;
/// 是否存在头部操作视图
@property (nonatomic, assign) BOOL haveHeadFunction;
/// 头部滚动视图高度
@property (nonatomic, assign) float headHeight;
/// 是否存在头部视图
@property (nonatomic, assign) BOOL haveHead;

/// 左边操作视图宽度
@property (nonatomic, assign) float leftFunctionWidth;
/// 是否存在左边操作视图
@property (nonatomic, assign) BOOL haveLeftFunction;
/// 左边滚动视图宽度
@property (nonatomic, assign) float leftWidth;
/// 是否存在左边视图
@property (nonatomic, assign) BOOL haveLeft;

/// 头部操作滚动视图
@property (nonatomic, readonly) UIScrollView *headFunctionScroll;
/// 头部滚动视图
@property (nonatomic, readonly) UIScrollView *headScroll;
/// 左边操作滚动视图
@property (nonatomic, readonly) UIScrollView *leftFunctionScroll;
/// 左边滚动视图
@property (nonatomic, readonly) UIScrollView *leftScroll;
/// 主列表视图
@property (nonatomic, readonly) UIScrollView *mainScrollView;

/// 主视图
@property (nonatomic, readonly) TGTNMyExcelToolBaseMainView *mainView;
/// 头部视图
@property (nonatomic, readonly) TGTNMyExcelToolBaseHeadView *headView;
/// 左边视图
@property (nonatomic, readonly) TGTNMyExcelToolBaseLeftView *leftView;
/// 头部功能视图
@property (nonatomic, readonly) TGTNMyExcelToolBaseHeadFunctionView *headFunctionView;
/// 左边功能视图
@property (nonatomic, readonly) TGTNMyExcelToolBaseLeftFunctionView *leftFunctionView;

/// 主视图数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseMainModel *mainModel;
/// 头部视图数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseHeadModel *headModel;
/// 左边视图数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseLeftModel *leftModel;
/// 头部功能视图数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseHeadFunctionModel *headFunctionModel;
/// 左边功能视图数据模型
@property (nonatomic, strong) TGTNMyExcelToolBaseLeftFunctionModel *leftFunctionModel;

/// 刷新数据源和视图
- (void)tgtnReloadDataAndView;
/// 设置视图数据模型
- (void)tgtnSetViewModel;
/// 设置视图添加子视图
- (void)tgtnSetViewAddChildView;
/// 设置视图刷新子视图
- (void)tgtnSetViewReloadChildView;

@end

#pragma mark ------ 分割线

@interface TGTNMyExcelToolBaseView (TGTNMyExcelToolBaseViewAdd)

/// 初始化视图
- (void)tgtnInitView;
/// 设置视图滚动大小并设置视图大小
- (void)tgtnSetScrollContentAndReloadView;
/// 刷新其它视图大小
- (void)tgtnReloadOtherViewFrame;
/// 初始化数据源
- (void)tgtnInitDataSource;
/// 刷新数据源
- (void)tgtnRefreshDataSource;
/// 设置视图刷新子视图数据
- (void)tgtnSetViewReloadChildViewData;

/// 返回自定义Main视图的class
- (Class)tgtnPreferredMainViewClass;
/// 返回自定义head视图的class
- (Class)tgtnPreferredHeadClass;
/// 返回自定义left视图的class
- (Class)tgtnPreferredLeftClass;
/// 返回自定义headFuntion视图的class
- (Class)tgtnPreferredHeadFunctionClass;
/// 返回自定义leftFuntion视图的class
- (Class)tgtnPreferredLeftFunctionClass;


/// 获取头部宽度
/// @param index 索引
- (float)tgtnPreferredHeadChildWidthAtIndex:(NSInteger) index;
/// 获取头部高度
/// @param index 索引
- (float)tgtnPreferredHeadChildHeightAtIndex:(NSInteger) index;

/// 获取左边宽度
/// @param index 索引
- (float)tgtnPreferredLeftChildWidthAtIndex:(NSInteger) index;
/// 获取左边高度
/// @param index 索引
- (float)tgtnPreferredLeftChildHeightAtIndex:(NSInteger) index;

/// 获取内容宽度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildWidthAtRow:(NSInteger) row section:(NSInteger) section;
/// 获取内容高度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildHeightAtRow:(NSInteger) row section:(NSInteger) section;

@end

NS_ASSUME_NONNULL_END
