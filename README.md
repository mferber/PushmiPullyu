# PushmiPullyu

A small test app for the express purpose of experimenting with different push
notification payloads and timings, and logging the resulting behavior.

## Usage

This app must be run on an actual device; push notifications are not enabled in the iOS Simulator.  Use any available third-party utility, such as [NWPusher](https://github.com/noodlewerk/NWPusher) or a web-based tool, to send push notifications to the app.

To send notifications, you will need both the appropriate APNs push certificate and the device token for the device running the app.

### APNs certificate

You will need a push certificate to install in the push-sending tool.  Certificates for this app (and, should they be needed, the corresponding private keys) can be found in the `APNs certificates` directory, exported without a password.  They can be imported into the Keychain and accessed from there, or, if the push-sending utility supports it, directly into the utility.

### Obtaining the device push token

To obtain the device push token, run the app from Xcode, with the device attached, and watch the Xcode log for the token almost immediately after startup.  Once you have the token, the app can be run on the device with or without being attached to Xcode, as long as that token remains valid.

The token is also displayed on the app's own log screen, but it's easier to copy and paste it from the Xcode log than to copy it manually.

### "Force quit" and background notifications

If you try force-quitting this app and then sending it a background notification (with `"content-available": 1` in the payload, it will fail, because Apple's policy is to [block background execution in apps that the user has force-quit](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html#//apple_ref/doc/uid/TP40007072-CH4-SW7).  Therefore, to support testing this case, the app has a "Force quit" button that causes the app to immediately crash and terminate.  That doesn't count as a user-driven force-quit, so background notifications will still be handled.


---

Author: Matthias Ferber, Cantina Consulting, Inc.

http://cantina.co
