UIApplication+Permissions
=========================

Category on UIApplication that adds permission helpers.


## How to check permissions

Permissions can be checked without asking the user to accept/reject access. The response is a value from an enumeration `kPermissionAccess`.

```objc
typedef enum {
    kPermissionAccessDenied, //User has rejected feature
    kPermissionAccessGranted, //User has accepted feature
    kPermissionAccessRestricted, //Blocked by parental controls or system settings
    kPermissionAccessUnknown, //Cannot be determined
    kPermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    kPermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} kPermissionAccess;
```

The methods used to query a permission are:


```objc
NSLog(@"Access to Bluetooth: %d", [[UIApplication sharedApplication] hasAccessToBluetoothLE]);
```
```objc
NSLog(@"Access to Calendar: %d", [[UIApplication sharedApplication] hasAccessToCalendar]);
```
```objc
NSLog(@"Access to Contacts: %d", [[UIApplication sharedApplication] hasAccessToContacts]);
```
```objc
NSLog(@"Access to Location: %d", [[UIApplication sharedApplication] hasAccessToLocation]);
```
```objc
NSLog(@"Access to Photos: %d", [[UIApplication sharedApplication] hasAccessToPhotos]);
```
```objc
NSLog(@"Access to Reminders: %d", [[UIApplication sharedApplication] hasAccessToReminders]);
```

## How to request access

You can ask the user to grant a permission by calling each method directly on `UIApplication`. Blocks are used to handle the users response.

```objc
[[UIApplication sharedApplication] requestAccessToContactsWithSuccess:^{
    NSLog(@"Access Granted");
} andFailure:^{
    NSLog(@"Access Denied");
}];
```

##Known issues

BluetoothLE reporting not powered on and is not prompting the user with the default alert. Always automatically reports it is good.

No checks for framework import/API availability which could lead to crashing on pre-iOS7.

No current method for adding a customised string to the permissions alert prompt.