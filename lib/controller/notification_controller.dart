import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigma_digital_solution/model/notification_model.dart';

class NotificationController extends GetxController {
  RxBool isProgressing = false.obs;

  NotificationController() {
    getNotificationData();
  }

  late List<NotificationModel> notifications;
  getNotificationData() async {
    isProgressing.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? notificationString = await prefs.getString('notification_data');
    notifications = NotificationModel.decode(notificationString!);
    isProgressing.value = false;
  }

}