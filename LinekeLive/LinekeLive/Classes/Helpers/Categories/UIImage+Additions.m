//
//  UIImage+Yasuo.m
//  Link
//
//  Created by apple on 14-6-17.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import "UIImage+Additions.h"
#import "SDImageCache.h"

@implementation UIImage (Additions)

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this newcontext, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)imageToMax800Image
{
    CGSize size = self.size;
    CGFloat height, width;
    if (size.height > size.width) {
        if (size.height > 800) {
            width = size.width * 800 / size.height;
            height = 800;
        }
        else {
            width = size.width;
            height = size.height;
        }
    }
    else {
        if (size.width > 800) {
            height = size.height * 800 / size.width;
            width = 800;
        }
        else {
            height = size.height;
            width = size.width;
        }
    }
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}

- (UIImage *)imageToImageMaxWidthOrHeight:(CGFloat)max
{
    CGSize size = self.size;
    CGFloat height, width;
    if (size.height > size.width) {
        if (size.height > max) {
            width = size.width * max / size.height;
            height = max;
        }
        else {
            width = size.width;
            height = size.height;
        }
    }
    else {
        if (size.width > max) {
            height = size.height * max / size.width;
            width = max;
        }
        else {
            height = size.height;
            width = size.width;
        }
    }
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}

- (UIImage *)imageToImageMaxHeight:(CGFloat)max
{
    CGSize size = self.size;
    CGFloat height, width;
    width = size.width * max / size.height;
    height = max;
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}

- (UIImage *)imageToImageMax:(CGSize)maxSize
{
    CGSize size = self.size;
    CGFloat height, width;
    if (size.height > size.width) {
        if (size.height > maxSize.height) {
            width = size.width * maxSize.height / size.height;
            height = maxSize.height;
        }
        else {
            width = size.width;
            height = size.height;
        }
    }
    else {
        if (size.width > maxSize.width) {
            height = size.height * maxSize.width / size.width;
            width = maxSize.width;
        }
        else {
            height = size.height;
            width = size.width;
        }
    }
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}

- (UIImage *)imageToMaxImage:(CGSize)maxSize
{
    CGSize size = self.size;
    CGFloat height, width;
    if (size.height > size.width) {
        if (size.height > maxSize.height) {
            width = size.width * maxSize.height / size.height;
            height = maxSize.height;
        }
        else {
            width = size.width;
            height = size.height;
        }
        
        if (width > maxSize.width) {
            width = maxSize.width;
            height = size.height * maxSize.width / size.width;
        }
    }
    else {
        if (size.width > maxSize.width) {
            height = size.height * maxSize.width / size.width;
            width = maxSize.width;
        }
        else {
            height = size.height;
            width = size.width;
        }
        
        if (height > maxSize.height) {
            width = size.width * maxSize.height / size.height;
            height = maxSize.height;
        }
    }
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}
/**
 *  按照viewsize 对图片进行等比缩放
 *
 *  @param viewSize
 *
 *  @return 适配的图片
 */
- (UIImage *)imageFixImageViewSize:(CGSize)viewSize
{
    CGSize imageSize = self.size;
    //缩放比例
    int width  = imageSize.width;
    int height = imageSize.height;
    
    if (viewSize.width != width) {
        //适配宽度
        width = viewSize.width;
        height = imageSize.height/(float)imageSize.width*width;
    }
    if (viewSize.height>height) {
        //适配高度
        height = viewSize.height;
        width = imageSize.width/(float)imageSize.height*height;
    }
    
    UIImage *img = [UIImage imageWithImageSimple:self scaledToSize:CGSizeMake(width, height)];
    return img;
}

+ (NSArray *)getBigImageFromImage:(UIImage *)image
{
    CGSize size = image.size;
    CGFloat bigHeight, bigWidth, smallHeight, smallWidth;
    if (size.height > size.width) {
        if (size.height > 800) {
            bigWidth = size.width * 800 / size.height;
            bigHeight = 800;
        }
        else {
            bigWidth = size.width;
            bigHeight = size.height;
        }
        if (bigHeight > 100) {
            smallWidth = bigWidth * 100 / bigHeight;
            smallHeight = 100;
        }
        else {
            smallWidth = bigWidth;
            smallHeight = bigHeight;
        }
    }
    else {
        if (size.width > 800) {
            bigHeight = size.height * 800 / size.width;
            bigWidth = 800;
        }
        else {
            bigHeight = size.height;
            bigWidth = size.width;
        }
        if (bigWidth > 100) {
            smallHeight = bigHeight * 100 / bigWidth;
            smallWidth = 100;
        }
        else {
            smallHeight = bigHeight;
            smallWidth = bigWidth;
        }
    }
    UIImage *bigImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(bigWidth, bigHeight)];
    UIImage *smallImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(smallWidth, smallHeight)];
    
    return @[bigImage,smallImage];
}

-(id)diskImageDataBySearchingAllPathsForKey:(id)key{return nil;}

+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
    if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            
//            NSData *data = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
        else {
            return CGSizeMake(220, 220);
        }
    }
    else {
        return CGSizeMake(220, 220);
    }
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
//    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
//    
//    CGSize size = CGSizeZero;
//    if([pathExtendsion isEqualToString:@"png"]){
//        size =  [self downloadPNGImageSizeWithRequest:request];
//    }
//    else if([pathExtendsion isEqual:@"gif"])
//    {
//        size =  [self downloadGIFImageSizeWithRequest:request];
//    }
//    else{
//        size = [self downloadJPGImageSizeWithRequest:request];
//    }
//    if(CGSizeEqualToSize(CGSizeZero, size))
//    {
//        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
//        UIImage* image = [UIImage imageWithData:data];
//        if(image)
//        {
//            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
//            size = image.size;
//        }
//    }
//    return size;
}

+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}


+ (UIImage *)imageFitScreen:(UIImage *)image withSize:(CGSize)size
{
    UIImage *resultsImg;
    
    CGSize origImgSize = [image size];
    
    CGRect newRect = CGRectZero;
    newRect.size = size;
    
    float widthProportion = newRect.size.width / origImgSize.width;
    float heightProportion = newRect.size.height / origImgSize.height;

    //确定缩放倍数
    float ratio;
    CGRect rect;

    if (widthProportion >=1 && heightProportion >=1) {
        ratio = MIN(widthProportion, heightProportion);
        rect.size.width = ratio * origImgSize.width;
        rect.size.height = ratio * origImgSize.height;
    }
    else if (widthProportion <=1 && heightProportion <=1) {
        ratio = MAX(widthProportion, heightProportion);
        rect.size.width = ratio * origImgSize.width;
        rect.size.height = ratio * origImgSize.height;
    }
    else if (widthProportion >1 && heightProportion <1) {
        if (widthProportion < -heightProportion) {
            ratio = widthProportion;
            rect.size.width = ratio * origImgSize.width;
            rect.size.height = ratio * origImgSize.height;
        }
        else {
            ratio = -heightProportion;
            rect.size.width = ratio * origImgSize.width;
            rect.size.height = ratio * origImgSize.height;
        }
    }
    else if (widthProportion <1 && heightProportion >1) {
        if (heightProportion < -widthProportion) {
            ratio = heightProportion;
            rect.size.width = ratio * origImgSize.width;
            rect.size.height = ratio * origImgSize.height;
        }
        else {
            ratio = -widthProportion;
            rect.size.width = ratio * origImgSize.width;
            rect.size.height = ratio * origImgSize.height;
        }
    }
    else {
        ratio = MIN(newRect.size.width / origImgSize.width, newRect.size.height / origImgSize.height);
        rect.size.width = ratio * origImgSize.width;
        rect.size.height = ratio * origImgSize.height;
    }
    
//    rect.origin.x = (newRect.size.width - rect.size.width) / 2.0;
    rect.origin.x = 0;
    rect.origin.y = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1.0);
    
    [image drawInRect:rect];
    
    resultsImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultsImg;
}

@end
