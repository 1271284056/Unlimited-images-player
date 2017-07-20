//
//  ViewController.m
//  无限图片轮播器
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "ViewController.h"
#import "LoopView.h"

@interface ViewController (){
    NSArray <NSURL *> *_urls;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    
    NSLog(@"%@", _urls);
    // test
    // 创建 界面
    LoopView *loopView = [[LoopView alloc] initWithURLs:_urls];
    loopView.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, 400);
    
    [self.view addSubview:loopView];
}


- (void)loadData {
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%02zd.jpg", (i + 1)];
        
        // 提示：如果 fileName 不存在 url 返回 nil
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        [arrayM addObject:url];
    }
    
    _urls = arrayM.copy;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
