//
//  ViewController.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "ViewController.h"
#import "SSStateMachineModel.h"

@interface ViewController () <SSStateMachineModelDelegate>
/** 状态机Model **/
@property (nonatomic, strong) SSStateMachineModel *SMModel;
/** 是否需要冲正 **/
@property (nonatomic, assign) BOOL isNeedReversal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.SMModel = [[SSStateMachineModel alloc] init];
    
    [self.SMModel setDelegate:self];
    
    [self.SMModel performEventWithEventType:SSEventTypeInit];
    
    _isNeedReversal = NO;
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
            [self.SMModel performEventWithEventType:SSEventTypeConsume];
            break;
        case SSStateTypeConsume:
            [self.SMModel performEventWithEventType:SSEventTypeResponseSuccess];
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
