//
//  XJFlowLayout2.h
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XJFlowLayout2;
@protocol XJFlowLayoutDataSource <NSObject>
@required
-(CGFloat)collection:(UICollectionView *)collection layout:(XJFlowLayout2 *)layout heightForIndexPath:(NSIndexPath *)indexPath;
@end

@interface XJFlowLayout2 : UICollectionViewLayout
@property (nonatomic)CGFloat itemSpace;//item间距
@property (nonatomic)UIEdgeInsets sectionInset;//section的间距，暂定只有一个section
@property (strong,nonatomic)id<XJFlowLayoutDataSource> dataSource;
@property (nonatomic)CGFloat itemWidth;//item宽度
@end
