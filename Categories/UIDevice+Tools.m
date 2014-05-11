
#import "UIDevice+Tools.h"

#include <sys/sysctl.h>  
#include <mach/mach.h>

@implementation UIDevice (ApsmartUtils)

- (double)availableMemory {
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
	
	if(kernReturn != KERN_SUCCESS) {
		return NSNotFound;
	}
	
	return ((vm_page_size * vmStats.free_count) ); // / 1024.0 / 1024.0;
}


-(bool)isAbove3G
{
	bool theResult;
	
	NSString* theMachine = self.machine;

	if ([theMachine isEqualToString:@"iPhone1,1"] ||
		[theMachine isEqualToString:@"iPhone1,2"] ||
		[theMachine isEqualToString:@"iPod1,1"] ||
		[theMachine isEqualToString:@"iPod2,1"]
		)
	{
		theResult = false;
	}
	else 
	{
		// i386 (simulator), iPhone2,1 (3GS) or newer
		theResult = true;
	}
	
	return theResult;
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)machine
{
	size_t size;
	
	sysctlbyname("hw.machine", NULL, &size, NULL, 0); 
	
	// Allocate the space to store name
	char *name = malloc(size);
	
	// Get the platform name
	sysctlbyname("hw.machine", name, &size, NULL, 0);
	
	// Place name into a string
	NSString* machine = [NSString stringWithCString:name];
	
	// Done with this
	free(name);
	
	return machine;
}
#pragma GCC diagnostic warning "-Wdeprecated-declarations"

- (kDeviceSpecificationValue) deviceSpecificationValue
{
	NSString *machine = [self machine];
    // Simulator and future iPad3+
	if ([machine isEqualToString:@"i386"] || [machine isEqualToString:@"x86_64"])
        return kDeviceSpecificationHigh;

    // iPad2
    if([machine hasPrefix:@"iPad2"])
        return kDeviceSpecificationMedium;

    // iPad1
    if([machine hasPrefix:@"iPad1"])
        return kDeviceSpecificationLow;

    // Unknown, assume Medium device
    return kDeviceSpecificationMedium;
}

- (NSString*) platformString
{
    /*
     iPhone Simulator == i386
     iPhone == iPhone1,1
     3G iPhone == iPhone1,2
     3GS iPhone == iPhone2,1
     4 iPhone == iPhone3,1
     1st Gen iPod == iPod1,1
     2nd Gen iPod == iPod2,1
     3rd Gen iPod == iPod3,1
     */
    
	NSString *machine = [self machine];
    //DEBUG_NSLog(@"machine = %@", machine);
	if ([machine isEqualToString:@"i386"] || [machine isEqualToString:@"x86_64"])      return @"iPhone Simulator";
	if ([machine isEqualToString:@"iPhone1,1"]) return @"iPhone";
	if ([machine isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
	if ([machine isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
	if ([machine isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
	if ([machine isEqualToString:@"iPod1,1"])   return @"iPod 1st Gen";
	if ([machine isEqualToString:@"iPod2,1"])   return @"iPod 2nd Gen";
	if ([machine isEqualToString:@"iPod3,1"])   return @"iPod 3rd Gen";
	if ([machine hasPrefix:@"iPhone"])          return @"Unknown iPhone";
	if ([machine hasPrefix:@"iPod"])            return @"Unknown iPod";
	if ([machine hasPrefix:@"iPad"])            return @"iPad";
	return [machine length] ? machine : @"Unknown";
}

- (NSString*) manufacturer
{
    return @"Apple"; // who else can make them? :)
}

- (NSString*) userAgentString
{
    UIDevice* device = [UIDevice currentDevice];
	NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
	NSString *marketingVersion = (NSString *)[infoPlist objectForKey:@"CFBundleShortVersionString"];
	NSString *appName = (NSString *)[infoPlist objectForKey:@"CFBundleDisplayName"];
	NSString *buildNumber = (NSString *)[infoPlist objectForKey:@"CFBundleVersion"];
    NSString *locale = [[NSLocale autoupdatingCurrentLocale] localeIdentifier];
    NSString * language = [[NSLocale preferredLanguages] count] ? [[NSLocale preferredLanguages] objectAtIndex:0] : @"en";
    
    // @"<app name>/<app version> (<machine>; <OS>; <software version number>; <language>; <locale>; <app build number>)
    
    //Sanity check
    if(![appName length])
        appName = @"MPme";
    if(![marketingVersion length])
        marketingVersion = @"";
    if(![buildNumber length])
        buildNumber = @"";
    if(![locale length])
        locale = @"";
    // "MPme/1.0 (device=x86_64; os=iPhone OS; osversion=5.0; lang=en; locale=en_IT; build=16)
    return [NSString stringWithFormat:@"%@/%@ (device=%@; os=%@; osversion=%@; lang=%@; locale=%@; build=%@)", appName, marketingVersion, [self machine], device.systemName, device.systemVersion, language, locale, buildNumber];
}

@end