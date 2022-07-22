import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  RxBool isProgressing = false.obs;
  List<String>? notificationTitle =[];
  List<String>? notificationBody = [];
  List<String>? notificationDate = [];

      NotificationController() {
    getNotificationData();
  }

  getNotificationData() async {
    isProgressing.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationTitle = await prefs.getStringList('notification_title')??[];
    notificationBody = await prefs.getStringList('notification_body')??[];
    notificationDate = await prefs.getStringList('notification_date')??[];
    isProgressing.value = false;
  }

}