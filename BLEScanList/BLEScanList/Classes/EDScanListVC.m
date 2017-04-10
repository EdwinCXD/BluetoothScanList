//
//  EDScanListVC.m
//  BLEScanList
//
//  Created by EdwinChen on 2017/4/10.
//  Copyright © 2017年 EdwinChen. All rights reserved.
//

#import "EDScanListVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "EDBluetoothModel.h"
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"
@interface EDScanListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allBluetoothModel;
@property (nonatomic, strong) NSMutableArray *sortArr;
@property (nonatomic, strong) NSTimer *scanTimer;
@property (nonatomic, strong) NSTimer *scanTimerOut;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndi;

@property (nonatomic, strong) BabyBluetooth *baby;

@end

@implementation EDScanListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    _sortArr = [NSMutableArray array];
    
    _baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}



- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    
    
    
}

- (void)babyDelegate {
    __weak typeof(self)weakSelf = self;
    
    [_baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        switch (central.state) {
            case CBManagerStatePoweredOn:
                [SVProgressHUD showInfoWithStatus:@"蓝牙打开成功，开始扫描设备"];
                break;
                
            case CBManagerStateUnsupported:
                [SVProgressHUD showInfoWithStatus:@"模拟器不支持蓝牙扫描"];
                break;
                
            case CBManagerStatePoweredOff:
                [SVProgressHUD showInfoWithStatus:@"蓝牙关闭，请确认"];
                break;
                
            case CBManagerStateUnauthorized:
                [SVProgressHUD showInfoWithStatus:@"未能正常获取权限，请去设置中允许应用使用蓝牙"];
                break;
                
            default:
                break;
        }
    }];
    //扫描到设备
    [_baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"扫描到设备：");
        //新建外设模型
        EDBluetoothModel *model = [[EDBluetoothModel alloc] init];
        model.peripheral = peripheral;
        model.RSSI = RSSI;
        //解析广播数据得到mac地址。等设备到了之后再对接
#warning waiting for device
        
        //第一次扫到设备直接加进数组中
        if (_allBluetoothModel.count == 0) {
            [_allBluetoothModel addObject:model];
        } else {
            //遍历蓝牙模型数组，更新信号数据
            for (NSInteger i=0; i < _allBluetoothModel; i++) {
                EDBluetoothModel *tempModel = _allBluetoothModel[i];
                CBPeripheral *per = tempModel.peripheral;
                
                if ([peripheral.identifier.UUIDString isEqualToString:per.identifier.UUIDString]) {
                    [_allBluetoothModel replaceObjectAtIndex:i withObject:model];//更新数组中数据
                    //数组依照信号排序
                    _sortArr = [NSMutableArray arrayWithArray:[_allBluetoothModel sortedArrayUsingComparator:^NSComparisonResult(EDBluetoothModel *obj1, EDBluetoothModel *obj2) {
                        return [obj2.RSSI compare:obj1.RSSI];
                    }]];
                    //刷新列表
                    [_tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                }
                
            }
            if (![_allBluetoothModel containsObject:model]) {
                [_allBluetoothModel addObject:model];
            }
        }
        
        
    }];
    
    //扫描到
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sortArr.count;
}

@end
