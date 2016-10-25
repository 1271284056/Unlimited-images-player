//
//  LoopViewLayout.m
//  无限图片轮播器
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "LoopViewLayout.h"

@implementation LoopViewLayout


// 在 collectionView 的第一次布局的时候，被调用，此时 collectionView 的 frame 已经设置完毕
- (void)prepareLayout {
    // 一定 super
    [super prepareLayout];
    
//    NSLog(@"%@", self.collectionView);
    // 直接利用 collectionView 的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end
