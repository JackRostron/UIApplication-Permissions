UIApplication+Permissions
=========================

Category on UIApplication that adds permission helpers.


## How to check permissions

Permissions can be checked without asking the user to accept/reject access. The response is a value from an enumeration `kPermissionAccess`.

```objc
NSLog(@"Access to Contacts: %d", [UIApplication hasAccessToContacts]);
```


## How to request access

You can ask the user to grant a permission by calling each method directly on `UIApplication`. Blocks are used to handle the users response.

```objc
[UIApplication requestAccessToContactsWithSuccess:^{
    NSLog(@"Access Granted");
} andFailure:^{
    NSLog(@"Access Denied");
}];
```
