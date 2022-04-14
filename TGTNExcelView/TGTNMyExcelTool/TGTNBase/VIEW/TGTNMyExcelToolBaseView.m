//
//  TGTNMyExcelToolBaseView.m
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import "TGTNMyExcelToolBaseView.h"

@interface TGTNMyExcelToolBaseView()<UIScrollViewDelegate>
/// 背景视图
@property (nonatomic, strong) UIView *backView;
/// 头部操作滚动视图
@property (nonatomic, readwrite) UIScrollView *headFunctionScroll;
/// 头部滚动视图
@property (nonatomic, readwrite) UIScrollView *headScroll;
/// 左边操作滚动视图
@property (nonatomic, readwrite) UIScrollView *leftFunctionScroll;
/// 左边滚动视图
@property (nonatomic, readwrite) UIScrollView *leftScroll;
/// 主列表视图
@property (nonatomic, readwrite) UIScrollView *mainScrollView;

/// 主视图
@property (nonatomic, readwrite) TGTNMyExcelToolBaseMainView *mainView;
/// 头部视图
@property (nonatomic, readwrite) TGTNMyExcelToolBaseHeadView *headView;
/// 左边视图
@property (nonatomic, readwrite) TGTNMyExcelToolBaseLeftView *leftView;
/// 头部功能视图
@property (nonatomic, readwrite) TGTNMyExcelToolBaseHeadFunctionView *headFunctionView;
/// 左边功能视图
@property (nonatomic, readwrite) TGTNMyExcelToolBaseLeftFunctionView *leftFunctionView;

/// 是否第一次刷新视图
@property (nonatomic, assign) BOOL isFirstLayoutSubView;
/// 滚动开始偏移
@property (nonatomic, assign) CGPoint mainScrollBeginPoint;
@end

@implementation TGTNMyExcelToolBaseView

#pragma mark ------ get
- (UIView *)backView {
    if (_backView) return _backView;
    _backView = [UIView new];
    _backView.hidden = YES;
    return _backView;
}

#pragma mark ------ set

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitData];
        [self tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
- (void)dealloc {
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect selfFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    if (!CGRectIsEmpty(self.frame) && _isFirstLayoutSubView) {
        _isFirstLayoutSubView = NO;
        
        _backView.frame = selfFrame;
        
        // 改变主视图位置大小
        [self _tgtnChangeMainViewFrame];
        
        // 刷新数据源和视图
        [self tgtnReloadDataAndView];
    } else {
        if (!CGRectEqualToRect(_backView.frame, selfFrame)) {
            _backView.frame = selfFrame;
            
            // 改变主视图位置大小
            [self _tgtnChangeMainViewFrame];
        }
    }
}
/// 初始化数据
- (void)_tgtnInitData {
    // 是否第一次刷新视图
    _isFirstLayoutSubView = YES;
    // 头部操作视图高度
    _headFunctionHeight = 20.0;
    // 是否存在头部操作视图
    _haveHeadFunction = YES;
    // 头部滚动视图高度
    _headHeight = 40.0;
    // 是否存在头部视图
    _haveHead = YES;

    // 左边操作视图宽度
    _leftFunctionWidth = 20.0;
    // 是否存在左边操作视图
    _haveLeftFunction = YES;
    // 左边滚动视图宽度
    _leftWidth = 40.0;
    // 是否存在左边视图
    _haveLeft = YES;
}
/// 添加事件
- (void)_tgtnInitEvent {
}
/// 改变主视图位置大小
- (void)_tgtnChangeMainViewFrame {
    float mainX = 0.0;
    mainX += (_haveLeftFunction ? _leftFunctionWidth : 0.0);
    mainX += (_haveLeft ? _leftWidth : 0.0);
    float mainY = 0.0;
    mainY += (_haveHeadFunction ? _headFunctionHeight : 0.0);
    mainY += (_haveHead ? _headHeight : 0.0);
    CGRect mainScrollFrame = CGRectMake(mainX, mainY, CGRectGetWidth(self.bounds) - mainX, CGRectGetHeight(self.bounds) - mainY);
    if (!CGRectEqualToRect(_mainScrollView.frame, mainScrollFrame)) {
        _mainScrollView.frame = mainScrollFrame;
    }
    
    float headX = mainX;
    float headY = 0.0;
    headY += (_haveHeadFunction ? _headFunctionHeight : 0.0);
    CGRect headFrame = CGRectMake(headX, headY, CGRectGetWidth(self.bounds) - headX, _headHeight);
    if (!CGRectEqualToRect(_headScroll.frame, headFrame)) {
        _headScroll.frame = headFrame;
    }
    
    float headFunctionX = headX;
    float headFunctionY = 0.0;
    CGRect headFunctionFrame = CGRectMake(headFunctionX, headFunctionY, CGRectGetWidth(self.bounds) - headFunctionX, _headFunctionHeight);
    if (!CGRectEqualToRect(_headFunctionScroll.frame, headFunctionFrame)) {
        _headFunctionScroll.frame = headFunctionFrame;
    }
    
    float leftX = 0.0;
    leftX += (_haveLeftFunction ? _leftFunctionWidth : 0.0);
    float leftY = mainY;
    CGRect leftFrame = CGRectMake(leftX, leftY, _leftWidth, CGRectGetHeight(self.bounds) - leftY);
    if (!CGRectEqualToRect(_leftScroll.frame, leftFrame)) {
        _leftScroll.frame = leftFrame;
    }
    
    float leftFunctionX = 0.0;
    float leftFunctionY = mainY;
    CGRect leftFunctionFrame = CGRectMake(leftFunctionX, leftFunctionY, _leftFunctionWidth, CGRectGetHeight(self.bounds) - leftFunctionY);
    if (!CGRectEqualToRect(_leftFunctionScroll.frame, leftFunctionFrame)) {
        _leftFunctionScroll.frame = leftFunctionFrame;
    }
    
    // 刷新其它视图大小
    [self tgtnReloadOtherViewFrame];
}

#pragma mark ------ UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *) scrollView {
    if ([scrollView isEqual:_mainScrollView]) {
        _mainScrollBeginPoint = scrollView.contentOffset;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *) scrollView {
    if ([scrollView isEqual:_mainScrollView]) {
        float scrollW = fabs((scrollView.contentOffset.x - _mainScrollBeginPoint.x));
        float scrollH = fabs((scrollView.contentOffset.y - _mainScrollBeginPoint.y));
        if (scrollW > scrollH) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, _mainScrollBeginPoint.y);
        } else {
            scrollView.contentOffset = CGPointMake(_mainScrollBeginPoint.x, scrollView.contentOffset.y);
        }
        
        _headScroll.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
        _headFunctionScroll.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
        
        _leftScroll.contentOffset = CGPointMake(0.0, scrollView.contentOffset.y);
        _leftFunctionScroll.contentOffset = CGPointMake(0.0, scrollView.contentOffset.y);
    }
    if ([scrollView isEqual:_headScroll]) {
        _headFunctionScroll.contentOffset = CGPointMake(scrollView.contentOffset.x, _headFunctionScroll.contentOffset.y);
        _mainScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, _mainScrollView.contentOffset.y);
    }
    if ([scrollView isEqual:_headFunctionScroll]) {
        _headScroll.contentOffset = CGPointMake(scrollView.contentOffset.x, _headScroll.contentOffset.y);
        _mainScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, _mainScrollView.contentOffset.y);
    }
    if ([scrollView isEqual:_leftScroll]) {
        _leftFunctionScroll.contentOffset = CGPointMake(_leftFunctionScroll.contentOffset.x, scrollView.contentOffset.y);
        _mainScrollView.contentOffset = CGPointMake(_mainScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
    if ([scrollView isEqual:_leftFunctionScroll]) {
        _leftScroll.contentOffset = CGPointMake(_leftScroll.contentOffset.x, scrollView.contentOffset.y);
        _mainScrollView.contentOffset = CGPointMake(_mainScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
}

#pragma mark ------ Private
/// 滚动视图默认属性
/// @param scrollView 滚动视图
- (void)_tgtnScrollDefaultStatus:(UIScrollView *) scrollView {
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    if (@available(iOS 11.0, *)) {
        if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

#pragma mark ------ Data Source
/// 头部列表宽度
/// @param index 列表索引
- (float)tgtnHeadChildWidthAtIndex:(NSInteger) index {
    return [self tgtnPreferredHeadChildWidthAtIndex:index];
}
/// 头部列表高度
/// @param index 列表索引
- (float)tgtnHeadChildHeightAtIndex:(NSInteger) index {
    return [self tgtnPreferredHeadChildHeightAtIndex:index];
}
/// 左边列表宽度
/// @param index 列表索引
- (float)tgtnLeftChildWidthAtIndex:(NSInteger) index {
    return [self tgtnPreferredLeftChildWidthAtIndex:index];
}
/// 左边列表高度
/// @param index 列表索引
- (float)tgtnLeftChildHeightAtIndex:(NSInteger) index {
    return [self tgtnPreferredLeftChildHeightAtIndex:index];
}
/// 内容列表宽度
/// @param row 列
/// @param section 行
- (float)tgtnItemChildWidthAtRow:(NSInteger) row section:(NSInteger) section {
    return [self tgtnPreferredItemChildWidthAtRow:row section:section];
}
/// 内容列表高度
/// @param row 列
/// @param section 行
- (float)tgtnItemChildHeightAtRow:(NSInteger) row section:(NSInteger) section {
    return [self tgtnPreferredItemChildHeightAtRow:row section:section];
}

#pragma mark ------ Public
/// 刷新数据源和视图
- (void)tgtnReloadDataAndView {
    // 初始化数据源
    [self tgtnInitDataSource];
    
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 设置视图添加子视图
    [self tgtnSetViewAddChildView];
    
    // 刷新数据源
    [self tgtnRefreshDataSource];
    // 改变主视图位置大小
    [self _tgtnChangeMainViewFrame];
    // 设置视图滚动大小并设置视图大小
    [self tgtnSetScrollContentAndReloadView];
    
    // 设置视图数据模型
    [self tgtnSetViewModel];
    // 设置视图刷新子视图数据
    [self tgtnSetViewReloadChildViewData];
    // 设置视图刷新子视图
    [self tgtnSetViewReloadChildView];
}
/// 设置视图数据模型
- (void)tgtnSetViewModel {
    [self.mainView tgtnSetModel:self.mainModel];
    if (_haveHead) {
        [self.headView tgtnSetModel:self.headModel];
    }
    if (_haveLeft) {
        [self.leftView tgtnSetModel:self.leftModel];
    }
    if (_haveHeadFunction) {
        [self.headFunctionView tgtnSetModel:self.headFunctionModel];
    }
    if (_haveLeftFunction) {
        [self.leftFunctionView tgtnSetModel:self.leftFunctionModel];
    }
}
/// 设置视图添加子视图
- (void)tgtnSetViewAddChildView {
    [self.mainView tgtnAddChildView];
    if (_haveHead) {
        [self.headView tgtnAddChildView];
    }
    if (_haveLeft) {
        [self.leftView tgtnAddChildView];
    }
}
/// 设置视图刷新子视图
- (void)tgtnSetViewReloadChildView {
    [self.mainView tgtnChangeChildFrame];
    if (_haveHead) {
        [self.headView tgtnChangeChildFrame];
    }
    if (_haveLeft) {
        [self.leftView tgtnChangeChildFrame];
    }
}

@end

#pragma mark ------ 分割线

@implementation TGTNMyExcelToolBaseView (TGTNMyExcelToolBaseViewAdd)

#pragma mark ------ set
- (UIScrollView *)headFunctionScroll {
    if (_headFunctionScroll) return _headFunctionScroll;
    _headFunctionScroll = [UIScrollView new];
    [self _tgtnScrollDefaultStatus:_headFunctionScroll];
    return _headFunctionScroll;
}
- (UIScrollView *)headScroll {
    if (_headScroll) return _headScroll;
    _headScroll = [UIScrollView new];
    [self _tgtnScrollDefaultStatus:_headScroll];
    return _headScroll;
}
- (UIScrollView *)leftFunctionScroll {
    if (_leftFunctionScroll) return _leftFunctionScroll;
    _leftFunctionScroll = [UIScrollView new];
    [self _tgtnScrollDefaultStatus:_leftFunctionScroll];
    return _leftFunctionScroll;
}
- (UIScrollView *)leftScroll {
    if (_leftScroll) return _leftScroll;
    _leftScroll = [UIScrollView new];
    [self _tgtnScrollDefaultStatus:_leftScroll];
    return _leftScroll;
}
- (UIScrollView *)mainScrollView {
    if (_mainScrollView) return _mainScrollView;
    _mainScrollView = [UIScrollView new];
    [self _tgtnScrollDefaultStatus:_mainScrollView];
    return _mainScrollView;
}
- (TGTNMyExcelToolBaseMainView *)mainView {
    if (_mainView) return _mainView;
    _mainView = [[self tgtnPreferredMainViewClass] new];
    return _mainView;
}
- (TGTNMyExcelToolBaseHeadView *)headView {
    if (_headView) return _headView;
    _headView = [[self tgtnPreferredHeadClass] new];
    return _headView;
}
- (TGTNMyExcelToolBaseLeftView *)leftView {
    if (_leftView) return _leftView;
    _leftView = [[self tgtnPreferredLeftClass] new];
    return _leftView;
}
- (TGTNMyExcelToolBaseHeadFunctionView *)headFunctionView {
    if (_headFunctionView) return _headFunctionView;
    _headFunctionView = [[self tgtnPreferredHeadFunctionClass] new];
    return _headFunctionView;
}
- (TGTNMyExcelToolBaseLeftFunctionView *)leftFunctionView {
    if (_leftFunctionView) return _leftFunctionView;
    _leftFunctionView = [[self tgtnPreferredLeftFunctionClass] new];
    return _leftFunctionView;
}

#pragma mark ------ init
/// 初始化视图
- (void)tgtnInitView {
    // 添加背景视图
    [self addSubview:self.backView];
    // 添加滚动视图
    [self addSubview:self.mainScrollView];
    [_mainScrollView addSubview:self.mainView];
    // 添加顶部视图
    [self addSubview:self.headScroll];
    [_headScroll addSubview:self.headView];
    // 添加左边视图
    [self addSubview:self.leftScroll];
    [_leftScroll addSubview:self.leftView];
    // 添加顶部操作视图
    [self addSubview:self.headFunctionScroll];
    [_headFunctionScroll addSubview:self.headFunctionView];
    // 添加左边操作视图
    [self addSubview:self.leftFunctionScroll];
    [_leftFunctionScroll addSubview:self.leftFunctionView];
}
/// 设置视图滚动大小并设置视图大小
- (void)tgtnSetScrollContentAndReloadView {
    _headFunctionScroll.contentSize = CGSizeMake(self.mainModel.mainAllWidth, CGRectGetHeight(_headFunctionScroll.bounds));
    _headFunctionView.frame = self.headFunctionModel.showRect;
    
    _headScroll.contentSize = CGSizeMake(self.mainModel.mainAllWidth, CGRectGetHeight(_headScroll.bounds));
    _headView.frame = CGRectMake(0.0, 0.0, self.mainModel.mainAllWidth, CGRectGetHeight(_headScroll.bounds));
    
    float leftContentSize = self.mainModel.mainAllHeight + CGRectGetHeight(self.mainScrollView.bounds) - 100.0;
    
    _leftFunctionScroll.contentSize = CGSizeMake(CGRectGetWidth(_leftFunctionScroll.bounds), leftContentSize);
    _leftFunctionView.frame = self.leftFunctionModel.showRect;
    
    _leftScroll.contentSize = CGSizeMake(CGRectGetWidth(_leftScroll.bounds), self.mainModel.mainAllHeight);
    _leftView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(_leftScroll.bounds), leftContentSize);
    
    _mainScrollView.contentSize = CGSizeMake(self.mainModel.mainAllWidth, leftContentSize);
    _mainView.frame = CGRectMake(0.0, 0.0, self.mainModel.mainAllWidth, self.mainModel.mainAllHeight);
}
/// 刷新其它视图大小
- (void)tgtnReloadOtherViewFrame {
}
/// 初始化数据源
- (void)tgtnInitDataSource {
    // 初始化头部数据模型
    TGTNMyExcelToolBaseHeadModel *headModel = [TGTNMyExcelToolBaseHeadModel new];
    [headModel.listData removeAllObjects];
    for (NSInteger i = 0; i < 4; i++) {
        TGTNMyExcelToolBaseHeadChildModel *headChildModel = [TGTNMyExcelToolBaseHeadChildModel new];
        [headModel.listData addObject:headChildModel];
    }
    self.headModel = headModel;
    
    // 初始化左边数据模型
    TGTNMyExcelToolBaseLeftModel *leftModel = [TGTNMyExcelToolBaseLeftModel new];
    [leftModel.listData removeAllObjects];
    for (NSInteger i = 0; i < 4; i++) {
        TGTNMyExcelToolBaseLeftChildModel *leftChildModel = [TGTNMyExcelToolBaseLeftChildModel new];
        [leftModel.listData addObject:leftChildModel];
    }
    self.leftModel = leftModel;
    
    // 初始化主视图数据模型
    TGTNMyExcelToolBaseMainModel *mainModel = [TGTNMyExcelToolBaseMainModel new];
    [mainModel.listData removeAllObjects];
    for (NSInteger i = 0; i < self.leftModel.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [TGTNMyExcelToolBaseMainChildModel new];
        [mainChildModel.listData removeAllObjects];
        
        for (NSInteger j = 0; j < self.headModel.listData.count; j++) {
            TGTNMyExcelToolBaseMainChildItemModel *childItemModel = [TGTNMyExcelToolBaseMainChildItemModel new];
            [mainChildModel.listData addObject:childItemModel];
        }
        
        [mainModel.listData addObject:mainChildModel];
    }
    self.mainModel = mainModel;
    
    // 初始化头部功能数据模型
    self.headFunctionModel = [TGTNMyExcelToolBaseHeadFunctionModel new];
    
    // 初始化左边功能数据模型
    self.leftFunctionModel = [TGTNMyExcelToolBaseLeftFunctionModel new];
}
/// 刷新数据源
- (void)tgtnRefreshDataSource {
    // 刷新头部数据
    float headAllWidth = 0.0;
    float headMaxHeight = 0.0;
    for (NSInteger i = 0; i < self.headModel.listData.count; i++) {
        TGTNMyExcelToolBaseHeadChildModel *headChildModel = [self.headModel.listData objectAtIndex:i];
        headChildModel.index = i;
        headChildModel.allCount = self.headModel.listData.count;
        headChildModel.itemWidth = [self tgtnHeadChildWidthAtIndex:i];
        headChildModel.itemHeight = [self tgtnHeadChildHeightAtIndex:i];
        
        headAllWidth += headChildModel.itemWidth;
        if (headChildModel.itemHeight > headMaxHeight) {
            headMaxHeight = headChildModel.itemHeight;
        }
    }
    if (headMaxHeight != self.headHeight) {
        self.headHeight = headMaxHeight;
    }
    self.headModel.headAllWidth = headAllWidth;
    self.headModel.headMaxHeight = headMaxHeight;
    
    // 刷新左边数据
    float leftAllHeight = 0.0;
    float leftMaxWidth = 0.0;
    for (NSInteger i = 0; i < self.leftModel.listData.count; i++) {
        TGTNMyExcelToolBaseLeftChildModel *leftChildModel = [self.leftModel.listData objectAtIndex:i];
        
        leftChildModel.index = i;
        leftChildModel.allCount = self.leftModel.listData.count;
        leftChildModel.itemWidth = [self tgtnLeftChildWidthAtIndex:i];
        leftChildModel.itemHeight = [self tgtnLeftChildHeightAtIndex:i];
        
        leftAllHeight += leftChildModel.itemHeight;
        if (leftChildModel.itemWidth > leftMaxWidth) {
            leftMaxWidth = leftChildModel.itemWidth;
        }
    }
    if (leftMaxWidth != self.leftWidth) {
        self.leftWidth = leftMaxWidth;
    }
    self.leftModel.leftAllHeight = leftAllHeight;
    self.leftModel.leftMaxWidth = leftMaxWidth;
    
    // 刷新内容数据
    float mainAllWidth = 0.0;
    float mainAllHeight = 0.0;
    for (NSInteger i = 0; i < self.mainModel.listData.count; i++) {
        TGTNMyExcelToolBaseMainChildModel *mainChildModel = [self.mainModel.listData objectAtIndex:i];
        mainChildModel.index = i;
        
        float childItemAllWidth = 0.0;
        float childItemMaxHeight = 0.0;
        float childItemMinHeight = 0.0;
        
        for (NSInteger j = 0; j < mainChildModel.listData.count; j++) {
            TGTNMyExcelToolBaseMainChildItemModel *childItemModel = [mainChildModel.listData objectAtIndex:j];
            childItemModel.indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            childItemModel.allCount = mainChildModel.listData.count;
            childItemModel.allSectionCount = self.mainModel.listData.count;
            childItemModel.itemWidth = [self tgtnItemChildWidthAtRow:j section:i];
            childItemModel.itemHeight = [self tgtnItemChildHeightAtRow:j section:i];
            
            childItemAllWidth += childItemModel.itemWidth;
            if (childItemModel.itemHeight > childItemMaxHeight) {
                childItemMaxHeight = childItemModel.itemHeight;
            }
            if (childItemMinHeight == 0.0) {
                childItemMinHeight = childItemModel.itemHeight;
            } else if (childItemModel.itemHeight < childItemMinHeight) {
                childItemMinHeight = childItemModel.itemHeight;
            }
        }
        
        mainChildModel.allWidth = childItemAllWidth;
        mainChildModel.maxHeight = childItemMaxHeight;
        mainChildModel.minHeight = childItemMinHeight;
        
        mainAllWidth = childItemAllWidth;
        mainAllHeight += childItemMaxHeight;
    }
    self.mainModel.mainAllWidth = mainAllWidth;
    self.mainModel.mainAllHeight = mainAllHeight;
    
    // 刷新头部功能数据
    if (!self.headFunctionModel.isShow) {
        self.headFunctionModel.showRect = CGRectMake(0.0, 0.0, [self tgtnItemChildWidthAtRow:0 section:0], _headFunctionHeight);
    }
    
    // 刷新左边功能数据
    if (!self.leftFunctionModel.isShow) {
        self.leftFunctionModel.showRect = CGRectMake(0.0, 0.0, _leftFunctionWidth, [self tgtnItemChildHeightAtRow:0 section:0]);
    }
}
/// 设置视图刷新子视图数据
- (void)tgtnSetViewReloadChildViewData {
}

/// 返回自定义Main视图的class
- (Class)tgtnPreferredMainViewClass {
    return [TGTNMyExcelToolBaseMainView class];
}
/// 返回自定义head视图的class
- (Class)tgtnPreferredHeadClass {
    return [TGTNMyExcelToolBaseHeadView class];
}
/// 返回自定义left视图的class
- (Class)tgtnPreferredLeftClass {
    return [TGTNMyExcelToolBaseLeftView class];
}
/// 返回自定义headFuntion视图的class
- (Class)tgtnPreferredHeadFunctionClass {
    return [TGTNMyExcelToolBaseHeadFunctionView class];
}
/// 返回自定义leftFuntion视图的class
- (Class)tgtnPreferredLeftFunctionClass {
    return [TGTNMyExcelToolBaseLeftFunctionView class];
}

/// 获取头部宽度
/// @param index 索引
- (float)tgtnPreferredHeadChildWidthAtIndex:(NSInteger) index {
    float width = [UIScreen mainScreen].bounds.size.width;
    width = width - self.leftWidth - self.leftFunctionWidth;
    return (width / 3.0);
}
/// 获取头部高度
/// @param index 索引
- (float)tgtnPreferredHeadChildHeightAtIndex:(NSInteger) index {
    return self.headHeight;
}
/// 获取左边宽度
/// @param index 索引
- (float)tgtnPreferredLeftChildWidthAtIndex:(NSInteger) index {
    return self.leftWidth;
}
/// 获取左边高度
/// @param index 索引
- (float)tgtnPreferredLeftChildHeightAtIndex:(NSInteger) index {
    float height = CGRectGetHeight(self.bounds);
    height = height - self.headHeight - self.headFunctionHeight;
    return (height / 3.0);
}

/// 获取内容宽度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildWidthAtRow:(NSInteger) row section:(NSInteger) section {
    float width = [UIScreen mainScreen].bounds.size.width;
    width = width - self.leftWidth - self.leftFunctionWidth;
    return (width / 3.0);
}
/// 获取内容高度
/// @param row 列
/// @param section 行
- (float)tgtnPreferredItemChildHeightAtRow:(NSInteger) row section:(NSInteger) section {
    float height = CGRectGetHeight(self.bounds);
    height = height - self.headHeight - self.headFunctionHeight;
    return (height / 3.0);
}

@end
