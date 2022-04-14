//
//  TGTNMyExcelToolExcelHeadView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelHeadView.h"

#import "TGTNMyExcelToolExcelHeadCustomView.h"

@interface TGTNMyExcelToolExcelHeadView()
/// 视图列表
@property (nonatomic, strong) NSMutableArray *viewList;
@end

@implementation TGTNMyExcelToolExcelHeadView

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
        TGTNMyExcelToolExcelHeadChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelHeadCustomView *headCustomView = [TGTNMyExcelToolExcelHeadCustomView new];
        [headCustomView tgtnSetModel:childModel];
        [self addSubview:headCustomView];
        [self.viewList addObject:headCustomView];
    }
}
/// 修改子视图大小
- (void)tgtnChangeChildFrame {
    float customViewX = 0.0;
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolExcelHeadChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelHeadCustomView *headCustomView = [self.viewList objectAtIndex:i];
        headCustomView.frame = CGRectMake(customViewX, 0.0, childModel.itemWidth, childModel.itemHeight);
        customViewX += childModel.itemWidth;
    }
}
/// 修改子视图数据源
- (void)tgtnChangeChildData {
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolExcelHeadChildModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelHeadCustomView *headCustomView = [self.viewList objectAtIndex:i];
        [headCustomView tgtnSetModel:childModel];
    }
}
/// 插入视图列
/// @param index 索引
- (void)tgtnInsetViewRowWithIndex:(NSInteger) index {
    TGTNMyExcelToolExcelHeadChildModel *childModel = [self.model.listData objectAtIndex:index];
    
    TGTNMyExcelToolExcelHeadCustomView *headCustomView = [TGTNMyExcelToolExcelHeadCustomView new];
    [headCustomView tgtnSetModel:childModel];
    [self addSubview:headCustomView];
    if (index >= self.viewList.count) {
        [self.viewList addObject:headCustomView];
    } else {
        [self.viewList insertObject:headCustomView atIndex:index];
    }
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 删除视图列
/// @param index 索引
- (void)tgtnDeleteViewRowWithIndex:(NSInteger) index {
    UIView *view = [self.viewList objectAtIndex:index];
    [view removeFromSuperview];
    [self.viewList removeObjectAtIndex:index];
    // 修改子视图数据源
    [self tgtnChangeChildData];
    // 修改子视图大小
    [self tgtnChangeChildFrame];
}
/// 获取当前选中视图
/// @param indexPath 索引
- (UIView *)tgtnGetCurrenSelectViewWithIndex:(NSIndexPath *) indexPath {
    TGTNMyExcelToolExcelHeadCustomView *headCustomView = [self.viewList objectAtIndex:indexPath.row];
    return headCustomView;
}

@end
