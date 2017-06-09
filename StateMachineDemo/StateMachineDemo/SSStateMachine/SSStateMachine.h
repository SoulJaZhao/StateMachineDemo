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
    SSStateTypeCheckPayParameters,
    /** 检测设备ID **/
    SSStateTypeCheckDeviceId,
    /** 检测是否需要冲正 **/
    SSStateTypeCheckIfNeedReversal,
    /** 完成冲正操作 **/
    SSStateTypeReversalComplete,
    /** 刷卡状态 **/
    SSStateTypeSwipeCard,
    /** 消费状态 **/
    SSStateTypeConsume,
    /** 交易成功 **/
    SSStateTypeTransactionSuccess,
};

//条件枚举
typedef NS_ENUM(NSInteger,SSEventType) {
    /** 开启状态机 **/
    SSEventTypeInit,
    /** 进入检测设备DeviceId **/
    SSEventTypeCheckDeviceId,
    /** 检测设备完成 **/
    SSEventTypeCheckDeviceComplete,
    /** 执行冲正操作 **/
    SSEventTypeNeedReversal,
    /** 执行刷卡 **/
    SSEventTypeSwipeCard,
    /** 执行消费 **/
    SSEventTypeConsume,
    /** 交易返回成功 **/
    SSEventTypeResponseSuccess,
};

/** 状态枚举转换成字符串 **/
#define STATE_TYPE_STRING(state) [SSStateMachine getStateTypeString:state]

/** 字符串转状态枚举 **/
#define STATE_TYPE_ENUM(state) [SSStateMachine getStateTypeEnum:state]

/** 条件枚举转换成字符串 **/
#define EVENT_TYPE_STRING(event) [SSStateMachine getEventTypeString:event]

@interface SSStateMachine : NSObject
/** 状态 **/
@property (nonatomic, assign) SSStateType *stateType;

@property (nonatomic, copy) NSString *state;

/**
 *  状态枚举转换成字符串
 */
+ (NSString *)getStateTypeString:(SSStateType)stateType;

/**
 *  字符串转换状态枚举
 */
+ (SSStateType)getStateTypeEnum:(NSString *)stateType;

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

/**
 *  检测设备DeviceId
 */
- (BOOL)SSEventTypeCheckDeviceId;

/**
 *  检测设备完成
 */
- (BOOL)SSEventTypeCheckDeviceComplete;

/**
 *  执行冲正操作
 */
- (BOOL)SSEventTypeNeedReversal;

/**
 *  执行刷卡
 */
- (BOOL)SSEventTypeSwipeCard;

/**
 *  执行消费
 */
- (BOOL)SSEventTypeConsume;

/**
 *  交易返回成功
 */
- (BOOL)SSEventTypeResponseSuccess;
@end
