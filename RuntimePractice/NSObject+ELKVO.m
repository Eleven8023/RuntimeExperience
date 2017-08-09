//
//  NSObject+ELKVO.m
//  RuntimePractice
//
//  Created by Eleven on 2017/8/9.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NSObject+ELKVO.h"
#import <objc/message.h>
@implementation NSObject (ELKVO)

- (void)ELaddObserver:(NSObject *)oberserver forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    // 动态创建一个类 动态类名
    NSString *oldName = NSStringFromClass([self class]);
    
    NSString *newName = [@"elKVO" stringByAppendingString:oldName]; // 名字随便起
    
    const char *newStr = [newName UTF8String]; // 转C
    // 继承的类 类名
    Class MyClass = objc_allocateClassPair([self class], newStr, 0);
    // 添加set方法
    class_addMethod(MyClass, @selector(setName:), (IMP)setName, "v@:@");// v - void @表示对象: SEL 类型
    // 注册该类
    objc_registerClassPair(MyClass);
    // 修改观察者的isa指针
    object_setClass(self, MyClass);
    // 将观察者保存到当前的对象中
    objc_setAssociatedObject(self, @"el666", oberserver, OBJC_ASSOCIATION_ASSIGN);
        
}

// 函数 底层所有的方法调用都带两个参数 id self  SEL _cmd
void setName(id self, SEL _cmd, NSString *newName){
    // 调用super 1.保存当前类型
    Class class = [self class];
    // 改变
    object_setClass(self, class_getSuperclass(class));
    objc_msgSend(self, @selector(setName:), newName);// 这里相当于调用了super
    object_setClass(self, class);
    
    // 调用observer 通知外界
    // 拿到观察者
    id observer = objc_getAssociatedObject(self, @"el666");
    // 发送消息 通知观察者
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,nil,nil);
    
}


@end

