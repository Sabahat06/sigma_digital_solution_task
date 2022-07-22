import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationController notificationController = NotificationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () {},),
        title: Text('Notification', style: TextStyle(fontSize: 18.sp, color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => notificationController.isProgressing.value
            ? const Center(child: CircularProgressIndicator(),)
            : ListView.builder(
                // itemCount: notificationController.notifications.length,
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return renderingNotification();
                },
              ),
        ),
      ),
    );
  }

  renderingNotification() {
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 5.h,
              width: double.infinity,
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notification Title', style: TextStyle(fontSize: 17.sp, color: Colors.white),),
                      Text('date', style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text('First, in order to use the SharedPreferences , we have to use Flutters plugin for it. To do so, make sure dependencies in your pubspec. yaml file looks similar to this', style: TextStyle(fontSize: 17.sp), textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }

}
