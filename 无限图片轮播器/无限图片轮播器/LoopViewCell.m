//
//  LoopViewCell.m
//  无限图片轮播器
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//
#define kMainScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define kMainScreenHeight       ([[UIScreen mainScreen] bounds].size.height)

#import "LoopViewCell.h"
#import "UIImage+Extension.h"

@interface LoopViewCell (){
    UIImageView *_imageView;
}


@end

@implementation LoopViewCell



// collectionViewCell 的 frame 是根据之前的 layout 已经确定好的！
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog(@"%@", NSStringFromCGRect(frame));
        
        // 添加图像视图
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    
    // 1. 根据 URL 获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 2. 将二进制数据转换成图像
    UIImage *image = [UIImage imageWithData:data];
//    image = [image rightSizeImage:image andSize:CGSizeMake(kMainScreenWidth - 40, 400)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.image = image;
}

@end
