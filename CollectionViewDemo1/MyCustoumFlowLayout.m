//
//  MyCustoumFlowLayout.m
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import "MyCustoumFlowLayout.h"

@implementation MyCustoumFlowLayout

-(void)test{
    //总列
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    CGFloat allWidth= mainSize.width - self.sectionInset.left - self.sectionInset.right;
    NSInteger itemNumOfRow = allWidth / (self.itemSize.width + self.minimumInteritemSpacing);
    //列间距
    CGFloat spaceOfColum = self.minimumInteritemSpacing;
    //行间距
    CGFloat spaceOfRow = self.minimumLineSpacing;
    //section到collectionView的边距
    UIEdgeInsets sectionInset = self.sectionInset;
}

//每行有几列
-(NSInteger)itemNumOfRow{
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    CGFloat allWidth= mainSize.width - self.sectionInset.left - self.sectionInset.right;
    NSInteger itemNumOfRow = allWidth / (self.itemSize.width + self.minimumInteritemSpacing);
    return itemNumOfRow;
}

-(void)prepareLayout{
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *attrsInfo = [NSMutableArray arrayWithCapacity:itemNum];
    
    for (int i  = 0; i < itemNum; i++) {
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attrsInfo addObject:attr];
    }
    
    self.attributes = attrsInfo;
    
    //2 获取最大的Y值
    NSInteger itemNumOfRow = [self itemNumOfRow];
    NSMutableDictionary *maxYDict = [NSMutableDictionary dictionaryWithCapacity:itemNumOfRow];
    for (int i = 0; i < itemNumOfRow; i++) {
        maxYDict[@(i)] = @(self.sectionInset.top);
    }
    self.maxYOfColum = maxYDict;
    
}


-(CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @0;
    [self.maxYOfColum enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYOfColum[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    
    CGFloat maxY = [self.maxYOfColum[maxIndex] floatValue];
    
    return CGSizeMake(0, maxY+self.sectionInset.bottom);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return nil;
}





@end
