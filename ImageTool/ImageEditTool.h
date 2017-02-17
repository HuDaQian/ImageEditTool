//
//  ImageEditTool.h
//  ImageTool
//
//  Created by HuDaQian on 2017/2/10.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

/*
 *edit:pm九点 2017-2-17
 *version 1.0
 *未处理问题:iOS8之前的高斯模糊的问题，方法走完以后，生成的图片周围有透明区域导致无法正确覆盖图片。
 *
 *version 1.1
 *处理问题iOS8之前的高斯模糊的问题，因为高斯模糊是卷积操作，所以模糊出来有一定的区域偏差，不影响使用。此版本暂不修改。
 */



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageEditTool : UIView

///创建纯色图片
+ (UIImage *)createApureColorImageWithColor:(UIColor *)color;

+ (UIImage *)createAPureColorImageWithColor:(UIColor *)color andSize:(CGSize)size;

///图片缩放
+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale;

+ (UIImage *)scaleImage:(UIImage *)image withWidth:(CGFloat)scaleWidth andHeight:(CGFloat)scaleHeight;


///增加文字水印
+ (UIImage *)addMarkAtImage:(UIImage *)image
                   withText:(NSString *)markString
                      point:(CGPoint)textPoint
              andAttributes:(NSDictionary *)attributes;

+ (UIImage *)addMarkAtImage:(UIImage *)image
                   withText:(NSString *)markString
                       rect:(CGRect)textRect
              andAttributes:(NSDictionary *)attributes;

///增加图片水印
+ (UIImage *)addMarkAtImage:(UIImage *)image
                  withImage:(UIImage *)markImage
                     atRect:(CGRect)rect;

///局部高斯模糊
+ (UIImage *)coreBlurImage:(UIImage *)image
             imageViewSize:(CGSize)viewSize
            withBlurNumber:(CGFloat)blurNumber
                  withRect:(CGRect)blurRect;

///图片裁剪
+ (UIImage *)cutImageWithImage:(UIImage *)image
                 imageViewSize:(CGSize)viewSize
                       cutRect:(CGRect)rect;

///图片快照
+ (UIImage *)snapImageWithView:(UIView *)view;

///图片擦除
+ (UIImage *)wipeImageWithImageView:(UIView *)imageV
                          point:(CGPoint)point
                           size:(CGSize)size;
///图片不规则裁剪
+ (UIImage *)cutImageWithImage:(UIImage *)image
                 imageViewSize:(CGSize)imageViewSize
                    clipPoints:(NSArray *)pointsArray;


@end
