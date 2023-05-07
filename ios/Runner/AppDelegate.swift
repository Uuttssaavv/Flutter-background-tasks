import UIKit
import Flutter
import flutter_background_service_ios // add this

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    /// Add following lines line
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "com.app.bgService.taskName1"
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "com.app.bgService.taskName2"

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}