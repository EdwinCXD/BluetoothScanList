//
//  EDBluetoothModel.h
//  BLEScanList
//
//  Created by EdwinChen on 2017/4/10.
//  Copyright © 2017年 EdwinChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface EDBluetoothModel : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSNumber *RSSI;
@property (nonatomic, copy)   NSString *macAddress;
@property (nonatomic, strong) NSDictionary *advertisementData;

@end
