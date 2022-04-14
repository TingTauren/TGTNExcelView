//
//  TGTNMyExcelToolBaseHeadFunctionModel.h
//  TGTNExcelView
//
//  Created by Mac on 2022/3/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNMyExcelToolBaseHeadFunctionModel : NSObject

/// 是否显示
@property (nonatomic, assign) BOOL isShow;

/// 显示位置
@property (nonatomic, assign) CGRect showRect;

@end

NS_ASSUME_NONNULL_END
