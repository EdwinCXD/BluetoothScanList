//
//  ViewController.m
//  BLEScanList
//
//  Created by EdwinChen on 2017/4/10.
//  Copyright © 2017年 EdwinChen. All rights reserved.
//

#import "ViewController.h"
#import "EDScanListVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)scanIt:(UIButton *)sender {
    [self.navigationController pushViewController:[[EDScanListVC alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
