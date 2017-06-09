//
//  SSStateMachineModel.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/9.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "SSStateMachineModel.h"

@interface SSStateMachineModel ()
//状态机类
@property (nonatomic, strong) SSStateMachine *stateMachine;
@end

@implementation SSStateMachineModel

//监听的KeyPath
NSString *const SSStateMachineKeyPath = @"state";

#pragma mark - 初始化方法
- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化状态机
        self.stateMachine = [[SSStateMachine alloc] init];
        
        //记录状态机的状态
        self.currentStateType = STATE_TYPE_ENUM(self.stateMachine.state);
        
        //监听KVO
        [self.stateMachine addObserver:self forKeyPath:SSStateMachineKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - 监听KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:SSStateMachineKeyPath]) {
        //当前状态
        SSStateType currentStateType = _currentStateType;
        //下次状态
        SSStateType nextStateType = STATE_TYPE_ENUM([change objectForKey:@"new"]);
        _currentStateType = nextStateType;
        
        if (_delegate && [_delegate respondsToSelector:@selector(stateMachineModel:ChangeFromState:toState:)]) {
            [_delegate stateMachineModel:self ChangeFromState:currentStateType toState:nextStateType];
        }
    }
}

#pragma mark - 执行触发条件
- (BOOL)performEventWithEventType:(SSEventType)eventType {
    return [self.stateMachine performEventWithEventType:eventType];
}
@end
