//
//  ImageEditTool.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/10.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "ImageEditTool.h"

@implementation ImageEditTool

///生成纯色的图片
+ (UIImage *)createApureColorImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1),NO,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)createAPureColorImageWithColor:(UIColor *)color andSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size,NO,0);
//贝塞尔曲线做法
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
//    [color setFill];
//    [path fill];
//CoreGraphics做法
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
///按照比例缩放
+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale {
    CGFloat scaleWidth = image.size.width*scale;
    CGFloat scaleHeight = image.size.height*scale;
    CGSize scaleSize = CGSizeMake(scaleWidth, scaleHeight);
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
///任意比例缩放
+ (UIImage *)scaleImage:(UIImage *)image withWidth:(CGFloat)scaleWidth andHeight:(CGFloat)scaleHeight {
    CGFloat newWidth = image.size.width*scaleWidth;
    CGFloat newHeight = image.size.height*scaleHeight;
    CGSize scaleSize = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
///文字水印
+ (UIImage *)addMarkAtImage:(UIImage *)image
                   withText:(NSString *)markString
                      point:(CGPoint)textPoint
              andAttributes:(NSDictionary *)attributes {
    UIGraphicsBeginImageContextWithOptions(image.size,NO,0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [markString drawAtPoint:textPoint withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)addMarkAtImage:(UIImage *)image
                   withText:(NSString *)markString
                       rect:(CGRect)textRect
              andAttributes:(NSDictionary *)attributes {
    UIGraphicsBeginImageContextWithOptions(image.size,NO,0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [markString drawInRect:textRect withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
///图片水印
+ (UIImage *)addMarkAtImage:(UIImage *)image
                  withImage:(UIImage *)markImage
                     atRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(image.size,NO,0);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [markImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//此处高斯模糊因为是一个卷积操作，所以模糊以后形成的图片的尺寸等属性稍微有一点变化，暂时不做处理。
/*此处附加变换操作
 * CIImage *inputImage = [CIImage imageWithCGImage:self.originImage.CGImage];
 * CGImageRef renderImage;
 * //iOS 8以后的模糊生成方法
 * if (NSFoundationVersionNumber >= 1140.11) {
 *      CIImage *filtered = [inputImage imageByClampingToExtent];
 *      filtered = [filtered imageByApplyingFilter:@"CIGaussianBlur" withInputParameters:@{kCIInputRadiusKey:@20}];
 *      filtered = [filtered imageByCroppingToRect:inputImage.extent];
 *      renderImage = [self.imageContext createCGImage:filtered fromRect:inputImage.extent];
 *   }
 */
//tips：另外引出一个问题，为什么添加文字的时候，drawInRect和drawAtPoint两者所在的位置的origin有区别。

///局部高斯模糊
+ (UIImage *)coreBlurImage:(UIImage *)image
             imageViewSize:(CGSize)viewSize
            withBlurNumber:(CGFloat)blurNumber
                  withRect:(CGRect)blurRect {
    //裁剪
    UIImage *newImage = [ImageEditTool cutImageWithImage:image imageViewSize:viewSize cutRect:blurRect];
    //模糊
    CIContext *ctx = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:newImage.CGImage];
    CGImageRef cgImageRef;
    UIImage *lastImage;
    if (NSFoundationVersionNumber >= 1140.11) {
        //iOS 8以后的模糊生成方法
        CIImage *filtered = [inputImage imageByClampingToExtent];
        filtered = [filtered imageByApplyingFilter:@"CIGaussianBlur" withInputParameters:@{kCIInputRadiusKey:[NSNumber numberWithFloat:blurNumber]}];
        filtered = [filtered imageByCroppingToRect:inputImage.extent];
        cgImageRef = [ctx createCGImage:filtered fromRect:inputImage.extent];
        lastImage = [UIImage imageWithCGImage:cgImageRef];
        CGImageRelease(cgImageRef);
    } else {
        inputImage = [CIImage imageWithCGImage:newImage.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValuesForKeysWithDictionary:@{kCIInputImageKey:inputImage,@"inputRadius":[NSNumber numberWithFloat:blurNumber]}];
        CIImage *cgImage = [filter valueForKey:kCIOutputImageKey];
    //修改为传入图片的大小
        cgImage = [cgImage imageByCroppingToRect:inputImage.extent];
    
        cgImageRef = [ctx createCGImage:cgImage fromRect:[cgImage extent]];
        lastImage = [UIImage imageWithCGImage:cgImageRef];
        CGImageRelease(cgImageRef);
    }
    //放缩
    CGFloat scale_width = blurRect.size.width/lastImage.size.width;
    CGFloat scale_height = blurRect.size.height/lastImage.size.height;
    UIImage *scaleImage = [ImageEditTool scaleImage:lastImage withWidth:scale_width andHeight:scale_height];
    //合成
    CGFloat blur_width = image.size.width/viewSize.width;
    CGFloat blur_height = image.size.height/viewSize.height;
    CGRect needBlurRect = CGRectMake(blurRect.origin.x * blur_width, blurRect.origin.y * blur_height, blurRect.size.width * blur_width, blurRect.size.height * blur_height);
    UIImage *resultImage = [ImageEditTool addMarkAtImage:image withImage:scaleImage atRect:needBlurRect];
    return resultImage;
}
//裁剪图片
+ (UIImage *)cutImageWithImage:(UIImage *)image
                 imageViewSize:(CGSize)viewSize
                       cutRect:(CGRect)rect {
    CGFloat scale_width = image.size.width/viewSize.width;
    CGFloat scale_height = image.size.height/viewSize.height;
    CGRect clipRect = CGRectMake(rect.origin.x * scale_width,
                                 rect.origin.y * scale_height,
                                 rect.size.width * scale_width,
                                 rect.size.height * scale_height);
    UIGraphicsBeginImageContext(clipRect.size);
    [image drawAtPoint:CGPointMake(-clipRect.origin.x, -clipRect.origin.y)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
///图片快照
+ (UIImage *)snapImageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
///图片擦除
+ (UIImage *)wipeImageWithImageView:(UIView *)imageV
                          point:(CGPoint)point
                           size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(imageV.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [imageV.layer renderInContext:ctx];
    CGFloat clipX = point.x-size.width/2;
    CGFloat clipY = point.y-size.height/2;
    CGRect clipRect = CGRectMake(clipX, clipY, size.width, size.height);
    CGContextClearRect(ctx, clipRect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)cutImageWithImage:(UIImage *)image
                 imageViewSize:(CGSize)imageViewSize
                    clipPoints:(NSArray *)pointsArray {
    CGFloat scale_width = image.size.width/imageViewSize.width;
    CGFloat scale_height = image.size.height/imageViewSize.height;
    NSArray *point_xArray = [pointsArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint pointA = [obj1 CGPointValue];
        CGPoint pointB = [obj2 CGPointValue];
        return pointA.x>pointB.x;
    }];
    NSArray *point_yArray = [pointsArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint pointA = [obj1 CGPointValue];
        CGPoint pointB = [obj2 CGPointValue];
        return pointA.y>pointB.y;
    }];
    //最大区域
    CGRect maxRect = CGRectMake([point_xArray.firstObject CGPointValue].x, [point_yArray.firstObject CGPointValue].y, ([point_xArray.lastObject CGPointValue].x-[point_xArray.firstObject CGPointValue].x), ([point_yArray.lastObject CGPointValue].y-[point_yArray.firstObject CGPointValue].y));
    UIGraphicsBeginImageContextWithOptions(maxRect.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i=0; i<[pointsArray count]; i++) {
        if (i == 0) {
            [path moveToPoint:CGPointMake([[pointsArray objectAtIndex:i] CGPointValue].x * scale_width, [[pointsArray objectAtIndex:i] CGPointValue].y * scale_height)];
        } else {
            [path addLineToPoint:CGPointMake([[pointsArray objectAtIndex:i] CGPointValue].x * scale_width, [[pointsArray objectAtIndex:i] CGPointValue].y * scale_height)];
        }
    }
    [path closePath];
    [path addClip];
    [image drawAtPoint:[[pointsArray firstObject] CGPointValue]];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
