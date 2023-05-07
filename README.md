The setup part of this repository can be found [here](https://medium.com/@theutsavg1/flutter-background-tasks-dda02f98182)
# Flutter-background-tasks
In mobile application development, background tasks are vital in ensuring a seamless and interactive user experience. While users interact with the foreground of an app, background tasks quietly operate in the background, handling critical processes without interrupting the app's primary functionality.

### Types of tasks in a Mobile Application:
**Foreground** refers to the state of an application when it is actively being used and visible on the screen.
**Background** describes the state of an application when it is still open but not actively visible, typically because the user has switched to another app or pressed the "home" button.
**Terminated** refers to the state of an application when it is no longer running, either because the user has locked the device or explicitly closed the app using the app switcher.

### Why do we need background services?
Background services are crucial for providing a better user experience in mobile applications. They ensure uninterrupted functionality by allowing apps to continue essential tasks and processes in the background, even when not actively used.

#### Some of the use cases of background tasks to enhance user experience are:
**Real-time Updates:** Apps can receive and process data in the background through background tasks, eliminating the need for users to refresh the app manually and ensuring that they stay up to date.
**Multitasking:** Users can perform other activities while the app works in the background, thanks to background tasks. This enhances their multitasking capabilities.
**Content Updates:** The app's content is continuously updated through background tasks, allowing users to access new information effortlessly without requiring manual action.
**Resource Management:** Efficient management of system resources is made possible by background tasks, which balance priorities based on user interactions and app requirements.

---
#### Implementation Explanation

`lib/services/background_services.dart`
- The `FlutterBackgroundService` class is utilized for managing background services.
- The class is implemented as a singleton, meaning that only one instance of the `BackgroundServices` class can exist. This is achieved by using a private static variable `_instance` and a private unnamed constructor `BackgroundServices._()`.
- The `getInstance()` method is used to retrieve the singleton instance of the `BackgroundServices` class. It initializes the instance if it hasn't been created yet.
- The `_onBackgroundService()` method is the entry point for the background service execution. It is annotated with `@pragma('vm:entry-point')` to mark it as the starting point for the Dart VM when running in the background.
- Whenever the `createTask` event is triggered, the payload is processed. After the delay of 10 seconds, the payload is saved to shared preferences. Finally, the background service is stopped.

---

`lib/main.dart`
- In line 66, the method `await prefs.reload()` is called so that whenever the shared preferences data may be modified externally by another process(background process), it is properly synchronized. 