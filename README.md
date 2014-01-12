UIApplication+Permissions
=========================

Category on UIApplication that adds permission helpers.


## How to check permissions
```objc
NSLog(@"Access to Cotacts: %d", [UIApplication hasAccessToContacts]);
```


## How to request access
```objc
    [UIApplication requestAccessToContactsWithSuccess:^{
        NSLog(@"Access Granted");
    } andFailure:^{
        NSLog(@"Access Denied");
    }];
```
