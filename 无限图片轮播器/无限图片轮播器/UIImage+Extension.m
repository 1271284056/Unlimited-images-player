//
//  UIImage+Extension.m
//  UI-01-图片轮播
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


- (UIImage *)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize{
    // 1. 根据 imageView 的大小，重新调整 image 的大小
    // 使用 CG 重新生成一张和目标尺寸相同的图片
    UIGraphicsBeginImageContextWithOptions(imgeSize, YES, 0);
    // 绘制图像
    [image drawInRect:CGRectMake(0, 0, imgeSize.width, imgeSize.height)];
    // 取得结果
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return result;
}
@end
