//
//  SSStateMachine.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "SSStateMachine.h"
#import <StateMachine/StateMachine.h>

/** 状态枚举转换成字符串 **/
#define STATE_TYPE_STRING(state) [SSStateMachine getStateTypeString:state]

/** 条件枚举转换成字符串 **/
#define EVENT_TYPE_STRING(event) [SSStateMachine getEventTypeString:event]

@implementation SSStateMachine

STATE_MACHINE(^(LSStateMachine * sm) {
    //初始化状态
    sm.initialState = STATE_TYPE_STRING(SSStateTypeInit);
    
    //添加状态
    [sm addState:STATE_TYPE_STRING(SSStateTypeInit)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeCheckPayParameters)];
    
    //逻辑
    [sm when:EVENT_TYPE_STRING(SSEventTypeInit)
transitionFrom:STATE_TYPE_STRING(SSStateTypeInit)
          to:STATE_TYPE_STRING(SSStateTypeCheckPayParameters)
     ];
});

#pragma mark - 初始化方法
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeStateMachine];
    }
    return self;
}

#pragma mark - 状态枚举转换成字符串
+ (NSString *)getStateTypeString:(SSStateType)stateType {
    NSString *result = @"";
    switch (stateType) {
        case SSStateTypeInit:
            result = @"SSStateTypeInit";
            break;
        case SSStateTypeCheckPayParameters:
            result = @"SSStateTypeCheckPayParameters";
            break;
        default:
            break;
    }
    return result;
}

#pragma mark - 条件枚举转换成字符串
+ (NSString *)getEventTypeString:(SSEventType)eventType {
    NSString *result = @"";
    switch (eventType) {
        case SSEventTypeInit:
            result = @"SSEventTypeInit";
            break;
        default:
            break;
    }
    return result;
}

#pragma mark - 执行一个条件
- (BOOL)performEventWithEventType:(SSEventType)eventType {
    BOOL result = NO;
    switch (eventType) {
        case SSEventTypeInit:
            result = [self SSEventTypeInit];
            break;
            
        default:
            break;
    }
    return result;
}
@end
