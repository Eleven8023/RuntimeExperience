//
//  NSURL+url.m
//  RuntimePractice
//
//  Created by Eleven on 2017/8/9.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NSURL+url.h"
#import <objc/runtime.h>
@implementation NSURL (url)
// 当这个类被加载的时候 在这个方法里面 下钩子
+(void)load{
    // 加载之前 理解下 SEL 和 Method IMP  SEL方法编号 编译的时候回去检测  IMP 是方法实现 在运行时的时候检测 Method 是在runtime里面的结构体类型代表着一个成员方法
    
    Method URLWithStr = class_getClassMethod(self, @selector(URLWithString:));
    Method ELUrl = class_getClassMethod(self, @selector(ELURLWithStr:));
    method_exchangeImplementations(URLWithStr, ELUrl);
    
}
// 自定义方法 交换UrlWirhString 方法欺骗
+(instancetype)ELURLWithStr:(NSString *)str{
    NSURL *url = [NSURL ELURLWithStr:str];
    // 此处注意 若使用一下方法会产生循环引用
    // NSURL *url = [NSURL URLWithString:str];
    
    if (url == nil) {
        NSLog(@"兄弟为空啊!");
    }
    return url;
    
}


@end
