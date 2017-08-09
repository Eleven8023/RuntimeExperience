//
//  NSObject+ELKVO.h
//  RuntimePractice
//
//  Created by Eleven on 2017/8/9.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ELKVO)
- (void)ELaddObserver:(NSObject *_Nullable)oberserver forKeyPath:(NSString *_Nullable)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
