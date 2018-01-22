//
//  AppInfo.m
//  QKDM001
//
//  Created by 李加建 on 2017/8/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AppInfo.h"


#import <AdSupport/AdSupport.h>

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>


#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>


//加入头文件
#import <sys/sysctl.h>
#import <mach/mach.h>


#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>


#import <CoreBluetooth/CoreBluetooth.h>



@implementation AppInfo




// iPhoneName

+ (NSString *)iPhoneName {
    
    
    // 手机名称
    NSString *iPhoneName = [UIDevice currentDevice].name;
    // 手机类型
    NSString *model = [UIDevice currentDevice].model;
    // 系统类型
    NSString *systemName = [UIDevice currentDevice].systemName;
    // 系统版本
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    
    // 地区性 手机类型
    NSString *localizedModel = [UIDevice currentDevice].localizedModel;
    
    // UUID
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    
    // 运行商
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    
//    [AppInfo deviceInfo];
    
    NSLog(@"%@%@%@%@%@%@",iPhoneName,model,systemVersion,localizedModel,identifierNumber,mCarrier);
    
    return iPhoneName ;
}



+ (NSString *)carrierName {
    // 运行商
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    
    return mCarrier;
}




+ (void)deviceInfo {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    
}



+ (NSString*)getCurrentLocalIP {
    
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


+ (NSString *)getCurreWiFiName {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    

    
    NSString *wifiName = [(NSDictionary*)info objectForKey:@"SSID"];
    
    return wifiName;
}

+ (NSString *)getCurreBSSID {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return [(NSDictionary*)info objectForKey:@"BSSID"];
}







- (void)GetMemoryStatistics {
    
    // Get Page Size
    int mib[2];
    int page_size;
    size_t len;
    
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    len = sizeof(page_size);
    
        // 方法一: 16384
//        int status = sysctl(mib, 2, &page_size, &len, NULL, 0);
//        if (status < 0) {
//            perror("Failed to get page size");
//        }
    //    // 方法二: 16384
    //    page_size = getpagesize();
//     方法三: 4096
    if( host_page_size(mach_host_self(), &page_size)!= KERN_SUCCESS ){
        perror("Failed to get page size");
    }
    printf("Page size is %d bytes\n", page_size);
    
    // Get Memory Size
    mib[0] = CTL_HW;
    mib[1] = HW_MEMSIZE;
    long ram;
    len = sizeof(ram);
    if (sysctl(mib, 2, &ram, &len, NULL, 0)) {
        perror("Failed to get ram size");
    }
    printf("Ram size is %f MB\n", ram / (1024.0) / (1024.0));
    
    // Get Memory Statistics
    //    vm_statistics_data_t vm_stats;
    //    mach_msg_type_number_t info_count = HOST_VM_INFO_COUNT;
    vm_statistics64_data_t vm_stats;
    mach_msg_type_number_t info_count64 = HOST_VM_INFO64_COUNT;
    //    kern_return_t kern_return = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm_stats, &info_count);
    kern_return_t kern_return = host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vm_stats, &info_count64);
    if (kern_return != KERN_SUCCESS) {
        printf("Failed to get VM statistics!");
    }
    
    double vm_total = vm_stats.wire_count + vm_stats.active_count + vm_stats.inactive_count + vm_stats.free_count;
    double vm_wire = vm_stats.wire_count;
    double vm_active = vm_stats.active_count;
    double vm_inactive = vm_stats.inactive_count;
    double vm_free = vm_stats.free_count;
    double unit = (1024.0) * (1024.0);
    
    NSLog(@"Total Memory: %f", vm_total * page_size / unit);
    NSLog(@"Wired Memory: %f", vm_wire * page_size / unit);
    NSLog(@"Active Memory: %f", vm_active * page_size / unit);
    NSLog(@"Inactive Memory: %f", vm_inactive * page_size / unit);
    NSLog(@"Free Memory: %f", vm_free * page_size / unit);
    
    self.scaleMemory = vm_total*page_size/ram;
    
    NSString * total = [NSString stringWithFormat:@"%.1f MB",ram/unit];
    
    self.TotalMemory = total;
    self.UsedMemory = [NSString stringWithFormat:@"%.1f MB",vm_total*page_size/unit];
    
    self.WiredMemory = [NSString stringWithFormat:@"%.1f MB",vm_wire*page_size/unit];
    self.ActiveMemory = [NSString stringWithFormat:@"%.1f MB",vm_active*page_size/unit];
    self.InactiveMemory = [NSString stringWithFormat:@"%.1f MB",vm_inactive*page_size/unit];
    
    self.FreeMemory = [NSString stringWithFormat:@"%.1f MB",ram*(1-self.scaleMemory)/unit];

}

@end
