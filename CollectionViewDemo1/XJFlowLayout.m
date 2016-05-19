//
//  XJFlowLayout.m
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import "XJFlowLayout.h"

@interface XJFlowLayout()
@property (nonatomic)NSInteger numRows;
@end

@implementation XJFlowLayout

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.itemSize = CGSizeMake(50.0, 50.0);
        self.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        self.lineSpace = 8.0f;
        self.itemSpace = 20.0f;
    }
    return self;
}

-(void)prepareLayout{
    NSMutableDictionary *layoutInformation = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    NSInteger numSections = [self.collectionView numberOfSections];
    for (int section = 0; section < numSections; section++) {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < numItems; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attrs.frame = [self frameForCellAtIndexPath:indexPath];
            [layoutInformation setObject:attrs forKey:indexPath];
        }
    }
    self.layoutInfo = layoutInformation;
}


-(CGSize)collectionViewContentSize{
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.sectionInset.top + self.numRows * self.itemSize.height + (self.numRows - 1)*self.lineSpace;
    return CGSizeMake(width, height);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attrArr = [NSMutableArray array];
    for (NSIndexPath *key in self.layoutInfo) {
        UICollectionViewLayoutAttributes *attr = [self.layoutInfo objectForKey:key];
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [attrArr addObject:attr];
        }
    }

    return attrArr;
}

#pragma mark - own defined method
-(CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath{
    //1有几行几列
    NSInteger numItems = [self.collectionView numberOfItemsInSection:indexPath.section];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSInteger numColum = floorf(screenSize.width - self.sectionInset.left - self.sectionInset.right) / (self.itemSize.width + self.itemSpace);
    NSInteger numRow = ceilf(numItems / (float)numColum);
    self.numRows = numRow;

    //2该元素是第几行第几列
    NSInteger numOfRow = indexPath.item / numColum;
    NSInteger numOfColum = indexPath.item % numColum;
    
    //3根据行列，计算出x,y值
    CGFloat originX = self.sectionInset.left + numOfColum * (self.itemSize.width + self.itemSpace);
    CGFloat originY = self.sectionInset.top + numOfRow * (self.itemSize.height + self.lineSpace);
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}


@end
