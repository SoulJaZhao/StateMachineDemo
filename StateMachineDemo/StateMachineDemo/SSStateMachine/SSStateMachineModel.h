//
//  SSStateMachineModel.h
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/9.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import <Foundation/Foundation.h>

//引入状态机
#import "SSStateMachine.h"

//监听的KeyPath
extern NSString *const SSStateMachineKeyPath;

@class SSStateMachineModel;
@protocol SSStateMachineModelDelegate <NSObject>

/**
 *  状态机状态的变化
 *  @param  stateMachineModel  状态机Model
 *  @param  currentStateType  上一次的状态
 *  @param  nextStateType  下一步的状态
 */
- (void)stateMachineModel:(SSStateMachineModel *)stateMachineModel ChangeFromState:(SSStateType)currentStateType toState:(SSStateType)nextStateType;

@end

@interface SSStateMachineModel : NSObject

/** 记录当前状态 **/
@property (nonatomic, assign) SSStateType currentStateType;

/** 代理 **/
@property (nonatomic, weak) id<SSStateMachineModelDelegate> delegate;

/**
 *  执行触发条件
 *  @param  eventType  事件类型
 */
- (BOOL)performEventWithEventType:(SSEventType)eventType;
@end
