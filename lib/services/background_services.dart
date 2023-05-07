import 'dart:convert';
import 'dart:developer';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundServices {
  ///  make the class singleton
  static BackgroundServices? _instance;

  /// this will avoid the inistance of the BackgroundServices class with unnamed constructor
  /// i.e you cannot initialize the object by final BackgroundServices bgService=BackgroundServices();
  BackgroundServices._();

  /// always use the `getInstance` method to initialize the object
  static BackgroundServices getInstance() {
    if (_instance == null) {
      _initialize();
      _instance = BackgroundServices._();
    }
    return _instance!;
  }

  static final FlutterBackgroundService _bgService = FlutterBackgroundService();

  /// _initialize method will intialize the background services
  static Future<void> _initialize() async {
    log('initialized');
    // initialize the shared preferences

    //  configure the background services
    _bgService.configure(
      iosConfiguration: IosConfiguration(
        onBackground: _onBackgroundService,
        onForeground: _onBackgroundService,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _onBackgroundService,
        isForegroundMode: true,
        initialNotificationContent: 'The task is saving in the preferences',
        initialNotificationTitle: 'Creating Task',
      ),
    );
  }

  Future<void> invokeTask(
      {required String task, Map<String, dynamic>? payload}) async {
    if (await _bgService.startService()) {
      _bgService.invoke(task, payload);
    }
  }

  ///  do not forget to add `@pragma('vm:entry-point')`
  /// The @pragma('vm:entry-point') directive ensures that the
  /// specified function is treated as the starting point of the
  /// program's execution. When the Dart VM runs the program, it
  /// looks for the function annotated with @pragma('vm:entry-point')
  /// and executes it first.
  @pragma('vm:entry-point')
  static Future<bool> _onBackgroundService(
      ServiceInstance serviceInstance) async {
    //

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    serviceInstance.on('createTask').listen(
      (Map<String, dynamic>? payload) async {
        log('the payload for createTask is $payload');

        // delay for few seconds
        await Future.delayed(const Duration(seconds: 10));

        await sharedPreferences.setString('createTask', jsonEncode(payload));

        log('Saved the task successfully.');

        /// stop the task when it is completed
        await serviceInstance.stopSelf();
      },
    );

    return false;
  }
}
