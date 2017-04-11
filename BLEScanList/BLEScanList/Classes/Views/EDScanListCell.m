//
//  EDScanListCell.m
//  BLEScanList
//
//  Created by EdwinChen on 2017/4/11.
//  Copyright © 2017年 EdwinChen. All rights reserved.
//

#import "EDScanListCell.h"

@interface EDScanListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *signalImage;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sevices;
@property (weak, nonatomic) IBOutlet UILabel *distance;


@end


@implementation EDScanListCell

- (void)setBluetoothModel:(EDBluetoothModel *)bluetoothModel {
    _bluetoothModel = bluetoothModel;
    
    NSNumber *RSSI = bluetoothModel.RSSI;
    self.signalLabel.text = [RSSI stringValue];
    
    self.name.text = bluetoothModel.peripheral.name;
    self.sevices.text = [NSString stringWithFormat:@"%lu services", (unsigned long)((NSArray *)bluetoothModel.advertisementData[@"kCBAdvDataServiceUUIDs"]).count];
    
    //蓝牙距离
    int rssi = abs([RSSI intValue]);
    float power = (rssi-59)/(10*2.0);
    float distance = pow(10, power);
//    self.distance.text = [NSString stringWithFormat:@"%.3f米", distance];
    self.distance.text = bluetoothModel.macAddress;
    
    
    if (rssi < 40) {
        self.signalImage.image = [UIImage imageNamed:@"信号-4"];
    } else if (rssi >100) {
        self.signalImage.image = [UIImage imageNamed:@"信号-0"];
    } else {
        self.signalImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"信号-%01d",5-(rssi - 25)/15]];
    }
}




@end
