//
//  FirstViewController.m
//  CollectionViewDemo1
//
//  Created by sxj on 16/5/9.
//  Copyright © 2016年 com.shixj. All rights reserved.
//

#import "FirstViewController.h"
#import "XJFlowLayout2.h"

@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XJFlowLayoutDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XJFlowLayout2 *flowLayout = (XJFlowLayout2 *)self.collectionView.collectionViewLayout;
    flowLayout.dataSource = self;
}


#pragma mark - collectiion view dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"11");
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"22");
    static NSString *identifier = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - xjFlowLayout dataSource
-(CGFloat)collection:(UICollectionView *)collection layout:(XJFlowLayout2 *)layout heightForIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"33");
    CGFloat height = arc4random() % 100;
    NSLog(@"height:%f",height);
    return height;
}
@end
