
#import <Foundation/Foundation.h>

typedef enum {
    kDeviceSpecificationHigh,
    kDeviceSpecificationMedium,
    kDeviceSpecificationLow
}kDeviceSpecificationValue;

@interface UIDevice (ApsmartUtils)

@property (readonly) double availableMemory; // Bytes
@property (readonly) NSString* machine;
@property (readonly) bool isAbove3G;
@property (readonly) NSString* platformString;
@property (readonly) NSString* manufacturer;
@property (readonly) kDeviceSpecificationValue deviceSpecificationValue;
@property (readonly) NSString* userAgentString;

@end
