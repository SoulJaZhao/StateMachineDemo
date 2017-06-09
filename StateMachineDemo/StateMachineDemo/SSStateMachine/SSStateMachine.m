//
//  SSStateMachine.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "SSStateMachine.h"
#import <StateMachine/StateMachine.h>

//State
static NSString *const kSSStateTypeInit = @"SSStateTypeInit";
static NSString *const kSSStateTypeCheckPayParameters = @"SSStateTypeCheckPayParameters";
static NSString *const kSSStateTypeCheckDeviceId = @"SSStateTypeCheckDeviceId";
static NSString *const kSSStateTypeCheckIfNeedReversal = @"SSStateTypeCheckIfNeedReversal";
static NSString *const kSSStateTypeReversalComplete = @"SSStateTypeReversalComplete";
static NSString *const kSSStateTypeSwipeCard = @"SSStateTypeSwipeCard";
static NSString *const kSSStateTypeConsume = @"SSStateTypeConsume";
static NSString *const kSSStateTypeTransactionSuccess = @"SSStateTypeTransactionSuccess";

//Event
static NSString *const kSSEventTypeInit = @"SSEventTypeInit";
static NSString *const kSSEventTypeCheckDeviceId = @"SSEventTypeCheckDeviceId";
static NSString *const kSSEventTypeCheckDeviceComplete = @"SSEventTypeCheckDeviceComplete";
static NSString *const kSSEventTypeNeedReversal = @"SSEventTypeNeedReversal";
static NSString *const kSSEventTypeSwipeCard = @"SSEventTypeSwipeCard";
static NSString *const kSSEventTypeConsume = @"SSEventTypeConsume";
static NSString *const kSSEventTypeResponseSuccess = @"SSEventTypeResponseSuccess";

@implementation SSStateMachine

STATE_MACHINE(^(LSStateMachine * sm) {
    //初始化状态
    sm.initialState = STATE_TYPE_STRING(SSStateTypeInit);
    
    //添加状态
    [sm addState:STATE_TYPE_STRING(SSStateTypeInit)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeCheckPayParameters)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeCheckDeviceId)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeCheckIfNeedReversal)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeReversalComplete)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeSwipeCard)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeConsume)];
    [sm addState:STATE_TYPE_STRING(SSStateTypeTransactionSuccess)];
    
    //逻辑
    [sm when:EVENT_TYPE_STRING(SSEventTypeInit)
transitionFrom:STATE_TYPE_STRING(SSStateTypeInit)
          to:STATE_TYPE_STRING(SSStateTypeCheckPayParameters)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeCheckDeviceId)
transitionFrom:STATE_TYPE_STRING(SSStateTypeCheckPayParameters)
          to:STATE_TYPE_STRING(SSStateTypeCheckDeviceId)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeCheckDeviceComplete)
transitionFrom:STATE_TYPE_STRING(SSStateTypeCheckDeviceId)
          to:STATE_TYPE_STRING(SSStateTypeCheckIfNeedReversal)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeNeedReversal)
transitionFrom:STATE_TYPE_STRING(SSStateTypeCheckIfNeedReversal)
          to:STATE_TYPE_STRING(SSStateTypeReversalComplete)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeSwipeCard)
transitionFrom:STATE_TYPE_STRING(SSStateTypeReversalComplete)
          to:STATE_TYPE_STRING(SSStateTypeSwipeCard)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeSwipeCard)
transitionFrom:STATE_TYPE_STRING(SSStateTypeCheckIfNeedReversal)
          to:STATE_TYPE_STRING(SSStateTypeSwipeCard)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeConsume)
transitionFrom:STATE_TYPE_STRING(SSStateTypeSwipeCard)
          to:STATE_TYPE_STRING(SSStateTypeConsume)
     ];
    [sm when:EVENT_TYPE_STRING(SSEventTypeResponseSuccess)
transitionFrom:STATE_TYPE_STRING(SSStateTypeConsume)
          to:STATE_TYPE_STRING(SSStateTypeTransactionSuccess)
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
            result = kSSStateTypeInit;
            break;
        case SSStateTypeCheckPayParameters:
            result = kSSStateTypeCheckPayParameters;
            break;
        case SSStateTypeCheckDeviceId:
            result = kSSStateTypeCheckDeviceId;
            break;
        case SSStateTypeCheckIfNeedReversal:
            result = kSSStateTypeCheckIfNeedReversal;
            break;
        case SSStateTypeReversalComplete:
            result = kSSStateTypeReversalComplete;
            break;
        case SSStateTypeSwipeCard:
            result = kSSStateTypeSwipeCard;
            break;
        case SSStateTypeConsume:
            result = kSSStateTypeConsume;
            break;
        case SSStateTypeTransactionSuccess:
            result = kSSStateTypeTransactionSuccess;
            break;
        default:
            break;
    }
    return result;
}

#pragma mark - 字符串转换状态枚举
+ (SSStateType)getStateTypeEnum:(NSString *)stateType {
    SSStateType stateTypeEnum = SSStateTypeInit;
    
    if ([stateType isEqualToString:kSSStateTypeInit]) {
        stateTypeEnum = SSStateTypeInit;
    }
    else if ([stateType isEqualToString:kSSStateTypeCheckPayParameters]) {
        stateTypeEnum = SSStateTypeCheckPayParameters;
    }
    else if ([stateType isEqualToString:kSSStateTypeCheckDeviceId]) {
        stateTypeEnum = SSStateTypeCheckDeviceId;
    }
    else if ([stateType isEqualToString:kSSStateTypeCheckIfNeedReversal]) {
        stateTypeEnum = SSStateTypeCheckIfNeedReversal;
    }
    else if ([stateType isEqualToString:kSSStateTypeReversalComplete]) {
        stateTypeEnum = SSStateTypeReversalComplete;
    }
    else if ([stateType isEqualToString:kSSStateTypeSwipeCard]) {
        stateTypeEnum = SSStateTypeSwipeCard;
    }
    else if ([stateType isEqualToString:kSSStateTypeConsume]) {
        stateTypeEnum = SSStateTypeConsume;
    }
    else if ([stateType isEqualToString:kSSStateTypeTransactionSuccess]) {
        stateTypeEnum = SSStateTypeTransactionSuccess;
    }
    return stateTypeEnum;
}

#pragma mark - 条件枚举转换成字符串
+ (NSString *)getEventTypeString:(SSEventType)eventType {
    NSString *result = @"";
    switch (eventType) {
        case SSEventTypeInit:
            result = kSSEventTypeInit;
            break;
        case SSEventTypeCheckDeviceId:
            result = kSSEventTypeCheckDeviceId;
            break;
        case SSEventTypeCheckDeviceComplete:
            result = kSSEventTypeCheckDeviceComplete;
            break;
        case SSEventTypeNeedReversal:
            result = kSSEventTypeNeedReversal;
            break;
        case SSEventTypeSwipeCard:
            result = kSSEventTypeSwipeCard;
            break;
        case SSEventTypeConsume:
            result = kSSEventTypeConsume;
            break;
        case SSEventTypeResponseSuccess:
            result = kSSEventTypeResponseSuccess;
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
        case SSEventTypeCheckDeviceId:
            result = [self SSEventTypeCheckDeviceId];
            break;
        case SSEventTypeCheckDeviceComplete:
            result = [self SSEventTypeCheckDeviceComplete];
            break;
        case SSEventTypeNeedReversal:
            result = [self SSEventTypeNeedReversal];
            break;
        case SSEventTypeSwipeCard:
            result = [self SSEventTypeSwipeCard];
            break;
        case SSEventTypeConsume:
            result = [self SSEventTypeConsume];
            break;
        case SSEventTypeResponseSuccess:
            result = [self SSEventTypeResponseSuccess];
            break;
        default:
            break;
    }
    return result;
}
@end
