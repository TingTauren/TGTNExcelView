//
//  ViewController.m
//  TGTNExcelView
//
//  Created by Mac on 2022/3/16.
//

#import "ViewController.h"

#import "TGTNMyExcelToolExcelView.h"

@interface ViewController ()
/// 表格视图
@property (nonatomic, strong) TGTNMyExcelToolExcelView *myExcelView;

/// 头部数据源
@property (nonatomic, strong) NSMutableArray *headListData;
/// 内容数据源
@property (nonatomic, strong) NSMutableArray *contentListData;
@end

@implementation ViewController

- (TGTNMyExcelToolExcelView *)myExcelView {
    if (_myExcelView) return _myExcelView;
    _myExcelView = [TGTNMyExcelToolExcelView new];
    _myExcelView.haveLeft = NO;
    _myExcelView.leftWidth = 0.0;
    return _myExcelView;
}
- (NSMutableArray *)headListData {
    if (_headListData) return _headListData;
    _headListData = [NSMutableArray new];
    
    NSArray *headList = @[@"画面内容", @"详细描述", @"台词文案", @"更多"];
    for (NSInteger i = 0; i < headList.count; i++) {
        TGTNMyExcelToolExcelHeadCustomDataModel *model = [TGTNMyExcelToolExcelHeadCustomDataModel new];
        model.columnType = @"0";
        model.title = [headList objectAtIndex:i];
        model.content = @"";
        model.canDel = (i < 3 ? @"0" : @"1");
        model.hint = @"点击输入标题(示例：时长)";
        NSString *contentHint = @"点击输入台词";
        contentHint = (i % 3 == 0 ? @"点击输入画面内容" : contentHint);
        contentHint = (i % 3 == 1 ? @"点击输入描述" : contentHint);
        model.contentColumnHint = contentHint;
        [_headListData addObject:model];
    }
    
    return _headListData;
}
- (NSMutableArray *)contentListData {
    if (_contentListData) return _contentListData;
    _contentListData = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 5; i++) {
        NSMutableArray *itemList = [NSMutableArray array];
        for (NSInteger j = 0; j < self.headListData.count; j++) {
            TGTNMyExcelToolExcelMainChildCustomDataModel *dataModel = [TGTNMyExcelToolExcelMainChildCustomDataModel new];
            dataModel.columnType = (j == 1 ? @"0" : @"0");
            dataModel.title = @"提示文本";
            dataModel.content = @"";
            dataModel.hint = @"提示文本";
            dataModel.videoPath = @"";
            dataModel.imagePath = @"";
            [itemList addObject:dataModel];
        }
        [_contentListData addObject:itemList];
    }
    
    return _contentListData;
}

/// 插入列数据
/// @param index 索引
- (void)_tgtnInserRowWithIndex:(NSInteger) index {
    TGTNMyExcelToolExcelHeadCustomDataModel *model = [TGTNMyExcelToolExcelHeadCustomDataModel new];
    model.columnType = @"0";
    model.title = @"添加数据";
    model.content = @"";
    model.canDel = @"1";
    model.hint = @"点击输入标题(示例：时长)";
    model.contentColumnHint = @"添加点击输入台词";
    
    if (index >= self.headListData.count) {
        [self.headListData addObject:model];
    } else {
        [self.headListData insertObject:model atIndex:index];
    }
    
    for (NSInteger i = 0; i < _contentListData.count; i++) {
        NSMutableArray *itemList = [_contentListData objectAtIndex:i];
        
        TGTNMyExcelToolExcelMainChildCustomDataModel *dataModel = [TGTNMyExcelToolExcelMainChildCustomDataModel new];
        dataModel.columnType = @"0";
        dataModel.title = @"添加提示文本";
        dataModel.content = @"";
        dataModel.hint = @"添加提示文本";
        dataModel.videoPath = @"";
        dataModel.imagePath = @"";
        
        if (index >= itemList.count) {
            [itemList addObject:dataModel];
        } else {
            [itemList insertObject:dataModel atIndex:index];
        }
    }
}
/// 删除列数据
/// @param index 索引
- (void)_tgtnDeleteRowWithIndex:(NSInteger) index {
    [self.headListData removeObjectAtIndex:index];
    
    for (NSInteger i = 0; i < _contentListData.count; i++) {
        NSMutableArray *itemList = [_contentListData objectAtIndex:i];
        
        [itemList removeObjectAtIndex:index];
    }
}
/// 插入行数据
/// @param index 索引
- (void)_tgtnInserSectionWithIndex:(NSInteger) index {
    NSMutableArray *itemList = [NSMutableArray array];
    for (NSInteger j = 0; j < self.headListData.count; j++) {
        TGTNMyExcelToolExcelMainChildCustomDataModel *dataModel = [TGTNMyExcelToolExcelMainChildCustomDataModel new];
        dataModel.columnType = (j == 1 ? @"0" : @"0");
        dataModel.title = @"添加提示文本";
        dataModel.content = @"";
        dataModel.hint = @"添加提示文本";
        dataModel.videoPath = @"";
        dataModel.imagePath = @"";
        [itemList addObject:dataModel];
    }
    if (index >= self.contentListData.count) {
        [self.contentListData addObject:itemList];
    } else {
        [self.contentListData insertObject:itemList atIndex:index];
    }
}
/// 删除行
/// @param index 索引
- (void)_tgtnDeleteSectionWithIndex:(NSInteger) index {
    [self.contentListData removeObjectAtIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myExcelView.frame = CGRectMake(0.0, 88.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88.0 - 34.0 - 20.0);
    [self.view addSubview:self.myExcelView];
    
    _myExcelView.headListData = self.headListData;
    _myExcelView.contentListData = self.contentListData;
    
    __weak typeof(self) weakSelf = self;
    _myExcelView.headFunctionClickConfig = ^(NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) self = weakSelf;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"向左增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger rowIndex = indexPath.row;
            // 修改数据源
            [self _tgtnInserRowWithIndex:rowIndex];
            self.myExcelView.headListData = self.headListData;
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnInsetRowWithIndexPath:rowIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"向右增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger rowIndex = indexPath.row+1;
            // 修改数据源
            [self _tgtnInserRowWithIndex:rowIndex];
            self.myExcelView.headListData = self.headListData;
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnInsetRowWithIndexPath:rowIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger rowIndex = indexPath.row;
            // 修改数据源
            [self _tgtnDeleteRowWithIndex:rowIndex];
            self.myExcelView.headListData = self.headListData;
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnDeleteRowWithIndexPath:rowIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    _myExcelView.leftFunctionClickConfig = ^(NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) self = weakSelf;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"向上增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger sectionIndex = indexPath.section;
            // 修改数据源
            [self _tgtnInserSectionWithIndex:sectionIndex];
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnInsetSectionWithIndexPath:sectionIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"向下增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger sectionIndex = indexPath.section+1;
            // 修改数据源
            [self _tgtnInserSectionWithIndex:sectionIndex];
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnInsetSectionWithIndexPath:sectionIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger sectionIndex = indexPath.section;
            // 修改数据源
            [self _tgtnDeleteSectionWithIndex:sectionIndex];
            self.myExcelView.contentListData = self.contentListData;
            // 修改视图
            [self.myExcelView tgtnDeleteSectionWithIndexPath:sectionIndex];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
}

@end
