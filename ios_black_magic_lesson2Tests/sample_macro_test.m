//
//  sample_macro_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/5.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

SpecBegin(sample_macro_test)

describe(@"sample_macro_test", ^{
    it(@"can include other file not only .h files", ^{
        #import "SampleFile.txt"
        #include "SampleFile2.txt"
    });
    
    it(@"can define some macro in project configurations", ^{
        NSLog(@"MY_MACRO is %d", MY_MACRO);
    });
    
    it(@"can use # to transform a parameter to string", ^{
#define STR(arg)    #arg
        NSLog(@"%s", STR(no more qutoes));
        
#define OCSTR(arg)  @#arg
        NSLog(OCSTR(Correct?));
    });
    
    it(@"can use # with log", ^{
#define TRUE_AND_LOG(condition)                              \
    do {                                                     \
        if (condition) {                                     \
            NSLog(@"Your condition '"#condition"' is true"); \
        }                                                    \
    } while(0)
        TRUE_AND_LOG(1 + 1 == 2);
    });
    
    it(@"can use ## to concat", ^{
#define DEF_VAR(type, name)    type type##_##name
        DEF_VAR(int, a) = 5;
        NSLog(@"%d", int_a);
    });
    
    it(@"can use ## to concat for making another macro or function name", ^{
#define NAME_1      @"William"
#define NAME_2      @"John"
#define NAME_3      @"Hugo"
#define NAME_WITH(i)    NAME_##i
        NSLog(@"Name is %@", NAME_WITH(1));
    });
    
    it(@"can use __FILE__ and __LINE__ show current file and line", ^{
        NSLog(@"%s\n%d\n%s\n%s\n%s\n%s",
              __FILE__,
              __LINE__,
              __DATE__,
              __TIME__,
              __TIMESTAMP__,
              __FUNCTION__);
    });
    
    it(@"can use ... to receive multi parameters", ^{
#define MY_LOG(str, ...)   NSLog(@"【"__FILE__":%d】"str, __LINE__, __VA_ARGS__)
        MY_LOG("%d %d %d", 1, 2, 3);
//        MY_LOG("no parameters");
        
#define MY_LOG2(str, ...)   NSLog(@"【"__FILE__":%d】"str, __LINE__, ##__VA_ARGS__)
        MY_LOG2("no parameters");
    });
});
SpecEnd
