import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/movie_controller.dart';
import 'package:sigma_digital_solution/controller/my_google_map_controller.dart';
// import 'package:sigma_digital_solution/services/local_notification_service.dart';
import 'package:sigma_digital_solution/view/movie_screen_tabs.dart';

// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification!.title);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   LocalNotificationService.initialize(context);
  //   ///gives you the message on which user taps
  //   ///and it opened the app from terminated state
  //   FirebaseMessaging.instance.getInitialMessage().then((message) async {
  //     if(message != null){
  //     }
  //   });
  //
  //   ///forground work
  //
  //   FirebaseMessaging.onMessage.listen((message) async {
  //     if(message.notification != null){
  //       final routeFromMessage = message.data["route"];
  //       // currentOrder = await HttpService.getOrderWithID(message.data['order_id']);
  //       // Get.toNamed(routeFromMessage);
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //     LocalNotificationService.display(message);
  //   });
  //
  //   ///When the app is in background but opened and user taps
  //   ///on the notification
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) async {
  //     final routeFromMessage = message.data["route"];
  //     if(message.data != null){
  //       Get.toNamed(routeFromMessage);
  //     }
  //   });
  //   super.initState();
  // }

  MovieController movieController = Get.put(MovieController());
  MyGoogleMapController googleMapController = Get.put(MyGoogleMapController());
  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
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

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        return null;
      }
    }
    LocationData currentLocation = await location.getLocation();
    if(currentLocation!=null) {
      googleMapController.latlng.value = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      googleMapController.convertLatLngIntoAddress(googleMapController.latlng.value);
    }
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
