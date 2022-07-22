import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigma_digital_solution/controller/movie_controller.dart';
import 'package:sigma_digital_solution/controller/my_google_map_controller.dart';
import 'package:sigma_digital_solution/model/notification_model.dart';
import 'package:sigma_digital_solution/services/local_notification_service.dart';
import 'package:sigma_digital_solution/view/movie_screen_tabs.dart';

///background notification
Future<void> backgroundHandler(RemoteMessage message) async {
  saveNotificationData(message);
}

void saveNotificationData(var message) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime date = DateTime.now();
  // Encode and store data in SharedPreferences
  final String encodedData = NotificationModel.encode([
    NotificationModel(title: message.notification!.title),
    NotificationModel(body: message.notification!.body),
    NotificationModel(date: date.toString()),
  ]);
  await prefs.setString('notification_data', encodedData);
  final String? musicsString = await prefs.getString('notification_data');
  final List<NotificationModel> musics = NotificationModel.decode(musicsString!);
  print(musics);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    LocalNotificationService.initialize(context);
    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if(message != null){
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) async {
      saveNotificationData(message);
      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if(message.data != null){
        ///do something
      }
    });
    super.initState();
  }

  MovieController movieController = Get.put(MovieController());
  MyGoogleMapController googleMapController = Get.put(MyGoogleMapController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sigma Digital Solution',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MovieScreenTabs();
        },
      ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
