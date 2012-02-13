//
//  MKMapView+ZoomLevel.h
//  iTarantula
//
//  Created by cescofry Freezone on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(double)zoomLevel
                   animated:(BOOL)animated;

@end 