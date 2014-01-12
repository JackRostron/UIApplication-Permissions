//
//  UIApplication+Permissions.m
//  UIApplication+Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//

#import "UIApplication+Permissions.h"

//Import required frameworks
@import AddressBook;
@import AssetsLibrary;
@import AVFoundation;
@import CoreBluetooth;
@import CoreLocation;
@import CoreMotion;
@import EventKit;


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
+(kPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return kPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return kPermissionAccessDenied;
            break;
            
        default:
            return kPermissionAccessGranted;
            break;
    }
}

+(kPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return kPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return kPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return kPermissionAccessRestricted;
            break;
            
        default:
            return kPermissionAccessUnknown;
            break;
    }
}

+(kPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return kPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return kPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return kPermissionAccessRestricted;
            break;
            
        default:
            return kPermissionAccessUnknown;
            break;
    }
}

+(kPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            return kPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return kPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return kPermissionAccessRestricted;
            break;
            
        default:
            return kPermissionAccessUnknown;
            break;
    }
    return kPermissionAccessUnknown;
}

+(kPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return kPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return kPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return kPermissionAccessRestricted;
            break;
            
        default:
            return kPermissionAccessUnknown;
            break;
    }
}

+(kPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return kPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return kPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return kPermissionAccessRestricted;
            break;
            
        default:
            return kPermissionAccessUnknown;
            break;
    }
    return kPermissionAccessUnknown;
}


#pragma mark - Request permissions
+(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted {
    //REQUIRES DELEGATE - NEEDS RETHINKING
}

+(void)requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

+(void)requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

+(void)requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    //REQUIRES DELEGATE - NEEDS RETHINKING
}

+(void)requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

+(void)requestAccessToMotionWithSuccess:(void(^)())accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

+(void)requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

+(void)requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


@end
