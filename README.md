UIApplication+Permissions
=========================

Category on UIApplication that adds permission helpers.


```objc
NSLog(@"Access to Cotacts: %d", [UIApplication hasAccessToContacts]);
```



```objc
[UIApplication requestAccessToContactsWithSuccess:^{
        NSLog(@"Access Granted");
    } andFailure:^(kPermissionAccess rejectReason) {
        NSLog(@"Access Denied");
    }];
```
