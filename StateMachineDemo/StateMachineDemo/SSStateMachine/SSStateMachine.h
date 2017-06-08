//
//  SSStateMachine.h
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import <Foundation/Foundation.h>

//状态枚举
typedef NS_ENUM(NSInteger,SSStateType) {
    /** 初始化状态 **/
    SSStateTypeInit,
    /** 检测支付参数 **/
    SSStateTypeCheckPayParameters
};

//条件枚举
typedef NS_ENUM(NSInteger,SSEventType) {
    /** 开启状态机 **/
    SSEventTypeInit,
};

@interface SSStateMachine : NSObject
/** 状态 **/
@property (nonatomic, assign) SSStateType *stateType;

@property (nonatomic, copy) NSString *state;

/**
 *  状态枚举转换成字符串
 */
+ (NSString *)getStateTypeString:(SSStateType)stateType;

/**
 *  条件枚举转换成字符串
 */
+ (NSString *)getEventTypeString:(SSEventType)eventType;

/**
 *  执行一个条件
 */
- (BOOL)performEventWithEventType:(SSEventType)eventType;
@end

@interface SSStateMachine (State)
/**
 *  初始化状态机
 */
- (void)initializeStateMachine;

/**
 *  开启状态机
 */
- (BOOL)SSEventTypeInit;

@end
