//
//  TGTNMyExcelToolExcelMainView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelMainView.h"

#import "TGTNMyExcelToolExcelMainCustomView.h"

@interface TGTNMyExcelToolExcelMainView()
/// 视图列表
@property (nonatomic, strong) NSMutableArray *viewList;
@end

@implementation TGTNMyExcelToolExcelMainView

#pragma mark ------ get
- (NSMutableArray *)viewList {
    if (_viewList) return _viewList;
    _viewList = [NSMutableArray new];
    return _viewList;
}

#pragma mark ------ Super Method
/// 添加子视图
- (void)tgtnAddChildView {
    if (self.model.listData.count <= 0) {
        return;
    }
    for (UIView *view in _viewList) {
        [view removeFromSuperview];
    }
    [_viewList removeAllObjects];
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomView *mainCustomView = [TGTNMyExcelToolExcelMainCustomView new];
        [mainCustomView tgtnSetModel:childModel];
        [mainCustomView tgtnAddChildView];
        [self addSubview:mainCustomView];
        [self.viewList addObject:mainCustomView];
    }
}
/// 修改子视图大小
- (void)tgtnChangeChildFrame {
    float customViewY = 0.0;
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:i];
        mainCustomView.frame = CGRectMake(0.0, customViewY, childModel.allWidth, childModel.maxHeight);
        [mainCustomView tgtnChangeChildFrame];
        customViewY += childModel.maxHeight;
    }
}
/// 修改子视图数据源
- (void)tgtnChangeChildData {
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:i];
        [mainCustomView tgtnSetModel:childModel];
        [mainCustomView tgtnChangeChildData];
    }
}
/// 插入视图列
/// @param index 索引
- (void)tgtnInsetViewSectionWithIndex:(NSInteger) index {
    TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:index];
    
    TGTNMyExcelToolExcelMainCustomView *mainCustomView = [TGTNMyExcelToolExcelMainCustomView new];
    [mainCustomView tgtnSetModel:childModel];
    [mainCustomView tgtnAddChildView];
    [self addSubview:mainCustomView];
    if (index >= self.viewList.count) {
        [self.viewList addObject:mainCustomView];
    } else {
        [self.viewList insertObject:mainCustomView atIndex:index];
    }
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 插入视图列
/// @param index 索引
- (void)tgtnInsetViewRowWithIndex:(NSInteger) index {
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:i];
        [mainCustomView tgtnSetModel:childModel];
        [mainCustomView tgtnInsetChildView:index];
    }
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 删除视图列
/// @param index 索引
- (void)tgtnDeleteViewRowWithIndex:(NSInteger) index {
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:i];
        [mainCustomView tgtnSetModel:childModel];
        [mainCustomView tgtnDeleteChildView:index];
    }
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 删除视图行
/// @param index 索引
- (void)tgtnDeleteViewSectionWithIndex:(NSInteger) index {
    TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:index];
    [mainCustomView tgtnDeleteAllChildView];
    [mainCustomView removeFromSuperview];
    // 删除视图行
    [self.viewList removeObjectAtIndex:index];
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 获取当前选中视图
/// @param indexPath 索引
- (UIView *)tgtnGetCurrenSelectViewWithIndex:(NSIndexPath *) indexPath {
    TGTNMyExcelToolExcelMainCustomView *mainCustomView = [self.viewList objectAtIndex:indexPath.section];
    return [mainCustomView tgtnGetCurrenSelectViewWithIndex:indexPath.row];
}

@end
