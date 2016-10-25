//
//  LoopView.m
//  无限图片轮播器
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "LoopView.h"
#import "LoopViewCell.h"
#import "LoopViewLayout.h"

static NSString *const loopViewCellId = @"LoopViewCellId";


@interface LoopView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end


@implementation LoopView{
    NSArray <NSURL *> *_urls;
}


- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls {
    // UICollectionViewFlowLayout
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[LoopViewLayout alloc] init]];
    if (self) {
        _urls = urls;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[LoopViewCell class] forCellWithReuseIdentifier:loopViewCellId];
        
        // 初始显示第二组 [0,1,2] [3(_urls.count),4,5]
        // 主队列：
        // 1. 安排任务在主线程上执行
        // 2. 如果主线程当前有任务，主队列暂时不调度任务！所以等cell的数据源和代理方法执行完毕后才执行这个block里面的滚动任务.
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            
            // 滚动位置！
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //这里为了防止滚动到最后一页来回跳动导致的卡顿,多写点组数让一直到不了最后一组,因为cell重用,所以不影响内存.
    return _urls.count * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:loopViewCellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    
    cell.url = _urls[indexPath.item % _urls.count];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 1. 获取当前停止的页面
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    
    // 2. 第0页，调转到，第1组的第0页
    // 最后一页，跳转到第0组的最后一页
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
//        NSLog(@"%zd", offset);
        
        // 第 0 页
        if (offset == 0) {
            offset = _urls.count;
        } else {
            offset = _urls.count - 1;
        }
        
        // 重新调整 contentOffset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    
}

@end
