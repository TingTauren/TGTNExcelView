//
//  TGTNMyExcelToolExcelHeadCustomDataModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolExcelHeadCustomDataModel : NSObject

/// 类型 (0:文本 1:视频文本 2:图片)
@property (nonatomic, strong) NSString *columnType;
/// 标题
@property (nonatomic, strong) NSString *title;
/// 内容
@property (nonatomic, strong) NSString *content;
/// 是否可以删除 (1:可删除 0:不可删除)
@property (nonatomic, strong) NSString *canDel;
/// 提示文本
@property (nonatomic, strong) NSString *hint;
/// 内容提示文本
@property (nonatomic, strong) NSString *contentColumnHint;

/// 获取字典
- (NSMutableDictionary *)tgtnGetCustomDataDict;

@end

NS_ASSUME_NONNULL_END
