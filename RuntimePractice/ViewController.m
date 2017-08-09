//
//  ViewController.m
//  RuntimePractice
//
//  Created by Eleven on 2017/8/9.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Dog.h"
#import "NSObject+ELKVO.h"
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic, strong) Person *p;

@property (nonatomic, strong) Dog *d;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 一个类的底层初始化  alloc init  和 方法实现过程
    [self classLowlayerAllocAndInit];
    // 2. hook思想(钩子思想)
    [self hookThought];
    // 3. 自定义KVO底层实现
    [self completeKVO];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)classLowlayerAllocAndInit{
    // Person *p = [[Person alloc] init];
    
    // 用消息机制 代替 alloc init(此处就是 对一个类的 alloc init的底层实现)
    // class是类类型 用[person class] 就是特殊的对象 (万物皆对象)
    Person *p = objc_msgSend([Person class], @selector(alloc));
    p = objc_msgSend(p, @selector(init));
    // 消息发送调用 person类的eat方法
    objc_msgSend(p, @selector(eat));
}

- (void)hookThought{
    NSURL *url = [NSURL URLWithString:@"我是URL"];
    
}

- (void)completeKVO{
    Dog *d = [[Dog alloc] init];
    d.name = @"luna";
    // KVO观察属性 取新值 系统封装方法
    // [d addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    // 用自定义的KVO方法调用
    [d ELaddObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _d = d;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // KVO响应式编程  一般不管状态什么时候会来 只要来了就执行
    NSLog(@"观察到了%@",_d.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int i = 0;
    i++;
    _d.name = [NSString stringWithFormat:@"%d",i];
    _d.name = @"hank1";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
