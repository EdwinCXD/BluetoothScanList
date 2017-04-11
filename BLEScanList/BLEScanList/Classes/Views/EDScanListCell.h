//
//  EDScanListCell.h
//  BLEScanList
//
//  Created by EdwinChen on 2017/4/11.
//  Copyright © 2017年 EdwinChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDBluetoothModel.h"

@interface EDScanListCell : UITableViewCell
@property (nonatomic, strong) EDBluetoothModel *bluetoothModel;
@end
