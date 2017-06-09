//
//  ViewController.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "ViewController.h"
#import "SSStateMachineModel.h"

typedef NS_ENUM(NSInteger,TransactionType) {
    /** 消费 **/
    TransactionTypeConsume,
    /** 退还 **/
    TransactionTypeRefund,
    /** 交换 **/
    TransactionTypeTransfer,
    /** 撤回 **/
    TransactionTypeRevocation
};

@interface ViewController () <SSStateMachineModelDelegate>
/** 状态机Model **/
@property (nonatomic, strong) SSStateMachineModel *SMModel;
/** 是否需要冲正 **/
@property (nonatomic, assign) BOOL isNeedReversal;
/** 交易返回是否成功 **/
@property (nonatomic, assign) BOOL isTransactionSuccess;
/** 交易方式 **/
@property (nonatomic, assign) TransactionType transType;
/** 需要APP端输入密码 **/
@property (nonatomic, assign) BOOL isNeedPin;
@property (nonatomic, assign) BOOL pinSuccess;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.SMModel = [[SSStateMachineModel alloc] init];
    
    [self.SMModel setDelegate:self];
    
    //是否需要冲正
    _isNeedReversal = NO;
    //交易返回是否成功
    _isTransactionSuccess = YES;
    //交易方式
    _transType = TransactionTypeConsume;
    //需要APP端输入密码
    _isNeedPin = YES;
    _pinSuccess = NO;
    
    [self.SMModel performEventWithEventType:SSEventTypeInit];
}

- (void)stateMachineModel:(SSStateMachineModel *)stateMachineModel ChangeFromState:(SSStateType)currentStateType toState:(SSStateType)nextStateType {
    NSLog(@"%ld-%ld",(SSStateType)currentStateType,(SSStateType)nextStateType);
    //根据当前状态执行触发事件
    switch (nextStateType) {
        case SSStateTypeCheckPayParameters:
            [self.SMModel performEventWithEventType:SSEventTypeCheckDeviceId];
            break;
        case SSStateTypeCheckDeviceId:
            [self.SMModel performEventWithEventType:SSEventTypeCheckDeviceComplete];
            break;
        case SSStateTypeCheckIfNeedReversal:
            //需要冲正
            if (_isNeedReversal) {
                [self.SMModel performEventWithEventType:SSEventTypeNeedReversal];
            }
            //不需要冲正
            else {
                [self.SMModel performEventWithEventType:SSEventTypeSwipeCard];
            }
            break;
        case SSStateTypeReversalComplete:
            [self.SMModel performEventWithEventType:SSEventTypeSwipeCard];
            break;
        case SSStateTypeSwipeCard:
            if (_isNeedPin) {
                if (_pinSuccess) {
                    //消费
                    if (_transType == TransactionTypeConsume) {
                        NSLog(@"开始消费");
                        [self.SMModel performEventWithEventType:SSEventTypeConsume];
                    }
                    //退还
                    else if (_transType == TransactionTypeRefund) {
                        NSLog(@"开始退还");
                        [self.SMModel performEventWithEventType:SSEventTypeRefund];
                    }
                    //交换
                    else if (_transType == TransactionTypeTransfer) {
                        NSLog(@"开始交换");
                        [self.SMModel performEventWithEventType:SSEventTypeTransfer];
                    }
                    //撤回
                    else if (_transType == TransactionTypeRevocation) {
                        [self.SMModel performEventWithEventType:SSEventTypeRevocation];
                    }
                } else {
                    NSLog(@"开始手动输入密码");
                    _pinSuccess = YES;
                    NSLog(@"密码输入成功");
                    [self.SMModel performEventWithEventType:SSEventTypeGetEncryptionPin];
                }
            } else{
                //消费
                if (_transType == TransactionTypeConsume) {
                    NSLog(@"开始消费");
                    [self.SMModel performEventWithEventType:SSEventTypeConsume];
                }
                //退还
                else if (_transType == TransactionTypeRefund) {
                    NSLog(@"开始退还");
                    [self.SMModel performEventWithEventType:SSEventTypeRefund];
                }
                //交换
                else if (_transType == TransactionTypeTransfer) {
                    NSLog(@"开始交换");
                    [self.SMModel performEventWithEventType:SSEventTypeTransfer];
                }
                //撤回
                else if (_transType == TransactionTypeRevocation) {
                    [self.SMModel performEventWithEventType:SSEventTypeRevocation];
                }
            }
            break;
        case SSStateTypeConsume:
            //交易成功
            if (_isTransactionSuccess ==YES) {
                [self.SMModel performEventWithEventType:SSEventTypeResponseSuccess];
            }
            //交易失败
            else {
                [self.SMModel performEventWithEventType:SSEventTypeCurrentRequestReversal];
            }
            break;
        case SSStateTypeTransactionSuccess:
            NSLog(@"交易成功");
            break;
        case SSStateTypeCurrentRequestReversal:
            NSLog(@"冲正交易");
            break;
        case SSStateTypeRefund:
            //退还交易不需要冲正
            if (_isTransactionSuccess) {
                [self.SMModel performEventWithEventType:SSEventTypeResponseSuccess];
            }
            //退还交易失败
            else {
                NSLog(@"退还交易失败");
            }
            break;
        case SSStateTypeTransfer:
            //交换交易不需要冲正
            if (_isTransactionSuccess) {
                [self.SMModel performEventWithEventType:SSEventTypeResponseSuccess];
            }
            //交换交易失败
            else {
                NSLog(@"交换交易失败");
            }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
