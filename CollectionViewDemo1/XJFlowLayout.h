//
//  XJFlowLayout.h
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJFlowLayout : UICollectionViewLayout
@property (nonatomic)CGSize itemSize;
@property (nonatomic)UIEdgeInsets sectionInset;
@property (nonatomic)CGFloat lineSpace;
@property (nonatomic)CGFloat itemSpace;
@property (strong,nonatomic)NSDictionary *layoutInfo;
@end
