//
//  TGTNMyExcelToolExcelMainCustomView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import "TGTNMyExcelToolExcelMainCustomView.h"

#import "TGTNMyExcelToolExcelMainCustomItemView.h"

@interface TGTNMyExcelToolExcelMainCustomView()
/// 视图列表
@property (nonatomic, strong) NSMutableArray *viewList;
@end

@implementation TGTNMyExcelToolExcelMainCustomView

#pragma mark ------ get
- (NSMutableArray *)viewList {
    if (_viewList) return _viewList;
    _viewList = [NSMutableArray new];
    return _viewList;
}

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
/// 初始化视图
- (void)_tgtnInitView {
}
/// 添加事件
- (void)_tgtnInitEvent {
}

#pragma mark ------ Private

#pragma mark ------ Public
/// 设置数据源
- (void)tgtnSetModel:(id)model {
    _model = model;
}
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
        TGTNMyExcelToolExcelMainCustomItemView *mainCustomItemView = [TGTNMyExcelToolExcelMainCustomItemView new];
        [mainCustomItemView tgtnAddChildView];
        [self addSubview:mainCustomItemView];
        [self.viewList addObject:mainCustomItemView];
    }
}
/// 插入子视图
- (void)tgtnInsetChildView:(NSInteger) index {
    TGTNMyExcelToolExcelMainCustomItemView *mainCustomItemView = [TGTNMyExcelToolExcelMainCustomItemView new];
    [mainCustomItemView tgtnAddChildView];
    [self addSubview:mainCustomItemView];
    if (index >= self.viewList.count) {
        [self.viewList addObject:mainCustomItemView];
    } else {
        [self.viewList insertObject:mainCustomItemView atIndex:index];
    }
}
/// 删除子视图
- (void)tgtnDeleteChildView:(NSInteger) index {
    UIView *view = [self.viewList objectAtIndex:index];
    [view removeFromSuperview];
    [self.viewList removeObjectAtIndex:index];
}
/// 删除全部子视图
- (void)tgtnDeleteAllChildView {
    for (UIView *view in self.viewList) {
        [view removeFromSuperview];
    }
}
/// 修改子视图大小
- (void)tgtnChangeChildFrame {
    float customItemViewX = 0.0;
    for (NSInteger i = 0; i < self.model.listData.count; i++) {
        TGTNMyExcelToolExcelMainChildItemModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomItemView *mainCustomItemView = [self.viewList objectAtIndex:i];
        mainCustomItemView.frame = CGRectMake(customItemViewX, 0.0, childModel.itemWidth, childModel.itemHeight);
        [mainCustomItemView tgtnChangeChildFrame];
        customItemViewX += childModel.itemWidth;
    }
}
/// 修改子视图数据源
- (void)tgtnChangeChildData {
    for (NSInteger i = 0; i < self.viewList.count; i++) {
        TGTNMyExcelToolExcelMainChildItemModel *childModel = [self.model.listData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainCustomItemView *mainCustomItemView = [self.viewList objectAtIndex:i];
        [mainCustomItemView tgtnSetModel:childModel];
    }
}
/// 获取当前选中视图
/// @param index 索引
- (UIView *)tgtnGetCurrenSelectViewWithIndex:(NSInteger) index {
    TGTNMyExcelToolExcelMainCustomItemView *mainCustomItemView = [self.viewList objectAtIndex:index];
    return mainCustomItemView;
}

@end
