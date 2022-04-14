//
//  TGTNMyExcelToolExcelView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelView.h"

@implementation TGTNMyExcelToolExcelView

#pragma mark ------ Private
/// 头部功能视图回调
- (void)_tgtnAddHeadFunctionModelConfig {
    __weak typeof(self) weakSelf = self;
    TGTNMyExcelToolExcelHeadFunctionModel *headFunctionModel = (TGTNMyExcelToolExcelHeadFunctionModel *)self.headFunctionModel;
    
    headFunctionModel.buttonClickConfig = ^(NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) self = weakSelf;
        
        if (self.headFunctionClickConfig) {
            self.headFunctionClickConfig(indexPath);
        }
        NSLog(@"head功能按钮点击 - %ld - %ld", indexPath.row, indexPath.section);
    };
}
/// 左边功能按钮点击
- (void)_tgtnAddLeftFunctionModelConfig {
    __weak typeof(self) weakSelf = self;
    TGTNMyExcelToolExcelLeftFunctionModel *leftFunctionModel = (TGTNMyExcelToolExcelLeftFunctionModel *)self.leftFunctionModel;
    
    leftFunctionModel.buttonClickConfig = ^(NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) self = weakSelf;
        
        if (self.leftFunctionClickConfig) {
            self.leftFunctionClickConfig(indexPath);
        }
        NSLog(@"left功能按钮点击 - %ld - %ld", indexPath.row, indexPath.section);
    };
}
/// 集中处理头部视图回调
/// @param model 头部视图模型
- (void)_tgtnAddHeadCustomModelConfig:(TGTNMyExcelToolExcelHeadChildModel *) model {
    __weak typeof(self) weakSelf = self;
    // 按钮点击回调
    model.buttonClickConfig = ^(NSInteger index, UIView * _Nonnull mySelf) {
        __strong typeof(weakSelf) self = weakSelf;
        
        CGRect newFrame = [mySelf convertRect:mySelf.bounds toView:self.headScroll];
        TGTNMyExcelToolExcelHeadFunctionModel *headModel = (TGTNMyExcelToolExcelHeadFunctionModel *)self.headFunctionModel;
        if (headModel.selectIndexPath.row == index) {
            [self _tgtnChangeHeadFunctionFrame:newFrame selectIndex:[NSIndexPath indexPathForRow:index inSection:-1] isShow:!self.headFunctionModel.isShow];
        } else {
            [self _tgtnChangeHeadFunctionFrame:newFrame selectIndex:[NSIndexPath indexPathForRow:index inSection:-1] isShow:self.headFunctionModel.isShow];
        }
    };
}
/// 集中处理内容视图回调
/// @param model 内容视图模型
- (void)_tgtnAddContentCustomModelConfig:(TGTNMyExcelToolExcelMainChildItemModel *) model {
    __weak typeof(self) weakSelf = self;
    model.buttonClickConfig = ^(NSIndexPath * _Nonnull indexPath, UIView * _Nonnull mySelf) {
        __strong typeof(weakSelf) self = weakSelf;
        
        CGRect newFrame = [mySelf convertRect:mySelf.bounds toView:self.mainScrollView];
        TGTNMyExcelToolExcelLeftFunctionModel *leftModel = (TGTNMyExcelToolExcelLeftFunctionModel *)self.leftFunctionModel;
        if (leftModel.selectIndexPath.section == indexPath.section && leftModel.selectIndexPath.row == indexPath.row) {
            // 修改位置和显示状态
            [self _tgtnChangeFunctionFrame:newFrame selectIndex:indexPath isShow:!self.leftFunctionModel.isShow];
        } else {
            // 修改位置和显示状态
            [self _tgtnChangeFunctionFrame:newFrame selectIndex:indexPath isShow:self.leftFunctionModel.isShow];
        }
    };
}

/// 修改头部功能按钮
- (void)_tgtnChangeHeadFunctionFrame:(CGRect) rect selectIndex:(NSIndexPath *) selectIndex isShow:(BOOL) isShow {
    TGTNMyExcelToolExcelLeftFunctionModel *leftFunctionModel = (TGTNMyExcelToolExcelLeftFunctionModel *)self.leftFunctionModel;
    leftFunctionModel.isShow = NO;
    leftFunctionModel.selectIndexPath = nil;
    leftFunctionModel.showRect = CGRectZero;
    
    TGTNMyExcelToolExcelHeadFunctionModel *headFunctionModel = (TGTNMyExcelToolExcelHeadFunctionModel *)self.headFunctionModel;
    headFunctionModel.isShow = isShow;
    headFunctionModel.selectIndexPath = selectIndex;
    headFunctionModel.showRect = CGRectMake(CGRectGetMinX(rect), 0.0, CGRectGetWidth(rect), self.headFunctionHeight);
    
    [self tgtnSetScrollContentAndReloadView];
    [self tgtnSetViewModel];
}
/// 修改功能按钮
- (void)_tgtnChangeFunctionFrame:(CGRect) rect selectIndex:(NSIndexPath *) selectIndex isShow:(BOOL) isShow {
    TGTNMyExcelToolExcelLeftFunctionModel *leftFunctionModel = (TGTNMyExcelToolExcelLeftFunctionModel *)self.leftFunctionModel;
    leftFunctionModel.isShow = isShow;
    leftFunctionModel.selectIndexPath = selectIndex;
    leftFunctionModel.showRect = CGRectMake(0.0, CGRectGetMinY(rect), self.leftFunctionWidth, CGRectGetHeight(rect));
    
    TGTNMyExcelToolExcelHeadFunctionModel *headFunctionModel = (TGTNMyExcelToolExcelHeadFunctionModel *)self.headFunctionModel;
    headFunctionModel.isShow = isShow;
    headFunctionModel.selectIndexPath = selectIndex;
    headFunctionModel.showRect = CGRectMake(CGRectGetMinX(rect), 0.0, CGRectGetWidth(rect), self.headFunctionHeight);
    
    // 设置滚动视图大小
    [self tgtnSetScrollContentAndReloadView];
    // 设置视图数据模型
    [self tgtnSetViewModel];
}

#pragma mark ------ Public
/// 插入列数据
/// @param index 索引
- (void)_tgtnInserRowDataWithIndex:(NSInteger) index {
    // 插入头部数据模型
    TGTNMyExcelToolExcelHeadChildModel *headChildModel = [TGTNMyExcelToolExcelHeadChildModel new];
    if (index >= self.headModel.listData.count) {
        [self.headModel.listData addObject:headChildModel];
    } else {
        [self.headModel.listData insertObject:headChildModel atIndex:index];
    }
    
    // 插入主视图数据模型
    for (NSInteger i = 0; i < self.mainModel.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [self.mainModel.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainChildItemModel *childItemModel = [TGTNMyExcelToolExcelMainChildItemModel new];
        if (index >= mainChildModel.listData.count) {
            [mainChildModel.listData addObject:childItemModel];
        } else {
            [mainChildModel.listData insertObject:childItemModel atIndex:index];
        }
    }
}
/// 插入行数据
/// @param index 索引
- (void)_tgtnInserSectioDataWithIndex:(NSInteger) index {
    // 初始化主视图数据模型
    NSArray *contentChildList = [_contentListData objectAtIndex:index];
    
    TGTNMyExcelToolBaseMainChildModel *mainChildModel = [TGTNMyExcelToolBaseMainChildModel new];
    [mainChildModel.listData removeAllObjects];
    
    for (NSInteger j = 0; j < contentChildList.count; j++) {
        TGTNMyExcelToolExcelMainChildItemModel *childItemModel = [TGTNMyExcelToolExcelMainChildItemModel new];
        [mainChildModel.listData addObject:childItemModel];
    }
    
    if (index >= self.mainModel.listData.count) {
        [self.mainModel.listData addObject:mainChildModel];
    } else {
        [self.mainModel.listData insertObject:mainChildModel atIndex:index];
    }
}
/// 删除列数据
/// @param index 索引
- (void)_tgtnDeleteRowDataWithIndex:(NSInteger) index {
    // 删除头部数据模型
    [self.headModel.listData removeObjectAtIndex:index];
    
    // 删除主视图数据模型
    for (NSInteger i = 0; i < self.mainModel.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [self.mainModel.listData objectAtIndex:i];
        // 删除数据
        [mainChildModel.listData removeObjectAtIndex:index];
    }
}
/// 删除行数据
/// @param index 索引
- (void)_tgtnDeleteSectionDataWithIndex:(NSInteger) index {
    [self.mainModel.listData removeObjectAtIndex:index];
}
/// 插入列
/// @param index 索引
- (void)tgtnInsetRowWithIndexPath:(NSInteger) index {
    // 插入列数据
    [self _tgtnInserRowDataWithIndex:index];
    // 刷新数据源
    [self tgtnRefreshDataSource];
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 插入视图
    [((TGTNMyExcelToolExcelHeadView *)self.headView) tgtnInsetViewRowWithIndex:index];
    // 插入视图
    [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnInsetViewRowWithIndex:index];
    // 设置滚动视图大小
    [self tgtnSetScrollContentAndReloadView];
    // 设置视图刷新子视图数据
    [self tgtnSetViewReloadChildViewData];
    // 设置视图刷新子视图大小
    [self tgtnSetViewReloadChildView];
    // 选中索引
    TGTNMyExcelToolExcelHeadFunctionModel *headFunctionModel =  (TGTNMyExcelToolExcelHeadFunctionModel *)self.headFunctionModel;
    NSIndexPath *selectRowIndex = headFunctionModel.selectIndexPath;
    if (selectRowIndex.row == index) {
        selectRowIndex = [NSIndexPath indexPathForRow:(index + 1) inSection:selectRowIndex.section];
        // 修改显示位置
        UIView *selectView = [((TGTNMyExcelToolExcelHeadView *)self.headView) tgtnGetCurrenSelectViewWithIndex:selectRowIndex];
        CGRect newFrame = [selectView convertRect:selectView.bounds toView:self.headScroll];
        // 修改位置和显示状态
        [self _tgtnChangeHeadFunctionFrame:newFrame selectIndex:selectRowIndex isShow:YES];
    }
}
/// 插入行
/// @param index 索引
- (void)tgtnInsetSectionWithIndexPath:(NSInteger) index {
    /// 插入行数据
    [self _tgtnInserSectioDataWithIndex:index];
    // 刷新数据源
    [self tgtnRefreshDataSource];
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 插入视图
    [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnInsetViewSectionWithIndex:index];
    // 设置滚动视图大小
    [self tgtnSetScrollContentAndReloadView];
    // 设置视图刷新子视图数据
    [self tgtnSetViewReloadChildViewData];
    // 设置视图刷新子视图大小
    [self tgtnSetViewReloadChildView];
    // 选中索引
    TGTNMyExcelToolExcelLeftFunctionModel *leftFunctionModel =  (TGTNMyExcelToolExcelLeftFunctionModel *)self.leftFunctionModel;
    NSIndexPath *selectSectionIndex = leftFunctionModel.selectIndexPath;
    if (selectSectionIndex.section == index) {
        selectSectionIndex = [NSIndexPath indexPathForRow:selectSectionIndex.row inSection:(index + 1)];
        // 修改显示位置
        UIView *selectView = [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnGetCurrenSelectViewWithIndex:selectSectionIndex];
        CGRect newFrame = [selectView convertRect:selectView.bounds toView:self.mainScrollView];
        // 修改位置和显示状态
        [self _tgtnChangeFunctionFrame:newFrame selectIndex:selectSectionIndex isShow:YES];
    }
}
/// 删除列
/// @param index 索引
- (void)tgtnDeleteRowWithIndexPath:(NSInteger) index {
    // 删除列数据
    [self _tgtnDeleteRowDataWithIndex:index];
    // 删除列视图
    [((TGTNMyExcelToolExcelHeadView *)self.headView) tgtnDeleteViewRowWithIndex:index];
    // 删除列视图
    [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnDeleteViewRowWithIndex:index];
    // 清空操作视图位置
    self.headFunctionModel.isShow = NO;
    self.leftFunctionModel.isShow = NO;
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 刷新数据源
    [self tgtnRefreshDataSource];
    // 设置滚动视图大小
    [self tgtnSetScrollContentAndReloadView];
    // 设置视图刷新子视图数据
    [self tgtnSetViewReloadChildViewData];
    // 设置视图刷新子视图大小
    [self tgtnSetViewReloadChildView];
}
/// 删除行
/// @param index 索引
- (void)tgtnDeleteSectionWithIndexPath:(NSInteger) index {
    // 删除行数据
    [self _tgtnDeleteSectionDataWithIndex:index];
    // 删除行视图
    [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnDeleteViewSectionWithIndex:index];
    // 清空操作视图位置
    self.headFunctionModel.isShow = NO;
    self.leftFunctionModel.isShow = NO;
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 刷新数据源
    [self tgtnRefreshDataSource];
    // 设置滚动视图大小
    [self tgtnSetScrollContentAndReloadView];
    // 设置视图刷新子视图数据
    [self tgtnSetViewReloadChildViewData];
    // 设置视图刷新子视图大小
    [self tgtnSetViewReloadChildView];
}

#pragma mark ------ Super Method
/// 初始化视图
- (void)tgtnInitView {
    [super tgtnInitView];
}
/// 设置视图滚动大小并设置视图大小
- (void)tgtnSetScrollContentAndReloadView {
    [super tgtnSetScrollContentAndReloadView];
}
/// 刷新其它视图大小
- (void)tgtnReloadOtherViewFrame {
    [super tgtnReloadOtherViewFrame];
}
/// 初始化数据源
- (void)tgtnInitDataSource {
    // 初始化头部数据模型
    TGTNMyExcelToolBaseHeadModel *headModel = [TGTNMyExcelToolBaseHeadModel new];
    [headModel.listData removeAllObjects];
    for (NSInteger i = 0; i < _headListData.count; i++) {
        TGTNMyExcelToolExcelHeadChildModel *headChildModel = [TGTNMyExcelToolExcelHeadChildModel new];
        [headModel.listData addObject:headChildModel];
    }
    self.headModel = headModel;
    
    // 初始化主视图数据模型
    TGTNMyExcelToolBaseMainModel *mainModel = [TGTNMyExcelToolBaseMainModel new];
    [mainModel.listData removeAllObjects];
    for (NSInteger i = 0; i < _contentListData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [TGTNMyExcelToolBaseMainChildModel new];
        [mainChildModel.listData removeAllObjects];
        
        for (NSInteger j = 0; j < self.headModel.listData.count; j++) {
            TGTNMyExcelToolExcelMainChildItemModel *childItemModel = [TGTNMyExcelToolExcelMainChildItemModel new];
            [mainChildModel.listData addObject:childItemModel];
        }
        
        [mainModel.listData addObject:mainChildModel];
    }
    self.mainModel = mainModel;
    
    // 初始化头部功能数据模型
    self.headFunctionModel = [TGTNMyExcelToolExcelHeadFunctionModel new];
    [self _tgtnAddHeadFunctionModelConfig];
    
    // 初始化左边功能数据模型
    self.leftFunctionModel = [TGTNMyExcelToolExcelLeftFunctionModel new];
    [self _tgtnAddLeftFunctionModelConfig];
}
/// 刷新数据源
- (void)tgtnRefreshDataSource {
    [super tgtnRefreshDataSource];
    
    for (NSInteger i = 0; i < self.headModel.listData.count; i++) {
        TGTNMyExcelToolExcelHeadChildModel *headChildModel = [self.headModel.listData objectAtIndex:i];
        
        headChildModel.customDataModel = [_headListData objectAtIndex:i];
        [self _tgtnAddHeadCustomModelConfig:headChildModel];
    }
    
    for (NSInteger i = 0; i < self.mainModel.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [self.mainModel.listData objectAtIndex:i];
        
        NSArray *mainChildList = [_contentListData objectAtIndex:i];
        
        for (NSInteger j = 0; j < mainChildModel.listData.count; j++) {
            TGTNMyExcelToolExcelMainChildItemModel *childItemModel = [mainChildModel.listData objectAtIndex:j];
            childItemModel.customDataModel = [mainChildList objectAtIndex:j];
            [self _tgtnAddContentCustomModelConfig:childItemModel];
        }
    }
}
/// 设置视图刷新子视图数据
- (void)tgtnSetViewReloadChildViewData {
    // 刷新子视图数据
    [((TGTNMyExcelToolExcelMainView *)self.mainView) tgtnChangeChildData];
    [((TGTNMyExcelToolExcelHeadView *)self.headView) tgtnChangeChildData];
}

/// 返回自定义Main视图的class
- (Class)tgtnPreferredMainViewClass {
    return [TGTNMyExcelToolExcelMainView class];
}
/// 返回自定义head视图的class
- (Class)tgtnPreferredHeadClass {
    return [TGTNMyExcelToolExcelHeadView class];
}
/// 返回自定义headFuntion视图的class
- (Class)tgtnPreferredHeadFunctionClass {
    return [TGTNMyExcelToolExcelHeadFunctionView class];
}
/// 返回自定义leftFuntion视图的class
- (Class)tgtnPreferredLeftFunctionClass {
    return [TGTNMyExcelToolExcelLeftFunctionView class];
}


/// 获取头部宽度
/// @param index 索引
- (float)tgtnPreferredHeadChildWidthAtIndex:(NSInteger) index {
    return [super tgtnPreferredHeadChildWidthAtIndex:index];
}
/// 获取头部高度
/// @param index 索引
- (float)tgtnPreferredHeadChildHeightAtIndex:(NSInteger) index {
    return [super tgtnPreferredHeadChildHeightAtIndex:index];
}

/// 获取内容宽度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildWidthAtRow:(NSInteger) row section:(NSInteger) section {
    return [super tgtnPreferredItemChildWidthAtRow:row section:section];
}
/// 获取内容高度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildHeightAtRow:(NSInteger) row section:(NSInteger) section {
    return [super tgtnPreferredItemChildHeightAtRow:row section:section];
}

@end
