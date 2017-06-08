//
//  ViewController.m
//  StateMachineDemo
//
//  Created by SoulJa on 2017/6/8.
//  Copyright © 2017年 sdp. All rights reserved.
//

#import "ViewController.h"

#import "SSStateMachine.h"

static NSString *const kKeyPath = @"state";

@interface ViewController ()
@property (nonatomic, strong) SSStateMachine *stateMachine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.stateMachine = [[SSStateMachine alloc] init];
    [self.stateMachine addObserver:self forKeyPath:kKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self.stateMachine performEventWithEventType:SSEventTypeInit];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kKeyPath]) {
        NSLog(@"%@",change);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
