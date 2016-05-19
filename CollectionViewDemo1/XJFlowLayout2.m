//
//  XJFlowLayout2.m
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import "XJFlowLayout2.h"

@interface XJFlowLayout2()
@property (strong,nonatomic)NSDictionary *layoutInfo;
@property (nonatomic)NSDictionary *lastYOfColums;
@property (nonatomic)NSInteger numColums;//总共有多少列
@end

@implementation XJFlowLayout2

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //设置默认值
        self.itemSpace = 20.0f;
        self.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        self.itemWidth = 50.0f;
    }
    return self;
}

-(void)prepareLayout{
    //1 get numColums
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    CGFloat excepWidth = mainSize.width - self.sectionInset.left - self.sectionInset.right + self.itemSpace;
    CGFloat interWidth = self.itemWidth + self.itemSpace;
    self.numColums = floorf(excepWidth / interWidth);
    //2 init lastY of colums
    NSMutableDictionary *lastYOfColumsDict = [NSMutableDictionary dictionaryWithCapacity:self.numColums];
    for (int colum = 0; colum < self.numColums; colum++) {
        [lastYOfColumsDict setObject:@(self.sectionInset.top) forKey:@(colum)];
    }
    //3 caculate
    NSMutableDictionary *layoutInformations = [NSMutableDictionary dictionary];
    NSInteger sections = [self.collectionView numberOfSections];
    NSIndexPath *indexPath;
    int currentColum = 0;
    for (int section = 0; section < sections; section++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < items; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGFloat x = self.sectionInset.left + (self.itemWidth + self.itemSpace)*currentColum;
            CGFloat y = [lastYOfColumsDict[@(currentColum)] floatValue];
            CGFloat height = [self.dataSource collection:self.collectionView layout:self heightForIndexPath:indexPath];
            attrs.frame = CGRectMake(x, y, self.itemWidth, height);
            //update lastY
            y += (height + self.itemSpace);
            lastYOfColumsDict[@(currentColum)] = @(y);
            currentColum++;
            if (currentColum >= self.numColums) {
                currentColum = 0;
            }
            
            [layoutInformations setObject:attrs forKey:indexPath];
        }
    }
    
    self.lastYOfColums = lastYOfColumsDict;
    self.layoutInfo = layoutInformations;
}

-(CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @0;
    [self.lastYOfColums enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, NSNumber*  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.lastYOfColums[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    CGFloat height = [self.lastYOfColums[maxIndex] floatValue];
    CGFloat width = self.sectionInset.left  + self.sectionInset.right + (self.itemWidth + self.itemSpace)*self.numColums;
    return CGSizeMake(width, height);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attrsArr = [NSMutableArray array];
    for (NSIndexPath *key in self.layoutInfo) {
        UICollectionViewLayoutAttributes *attrs = [self.layoutInfo objectForKey:key];
        if (CGRectIntersectsRect(attrs.frame, rect)) {
            [attrsArr addObject:attrs];
        }
    }
    return attrsArr;
}





@end
