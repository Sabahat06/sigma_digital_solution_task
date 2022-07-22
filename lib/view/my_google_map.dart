import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/my_google_map_controller.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen();
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  MyGoogleMapController controller = Get.find();
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(
          () => GestureDetector(
            onTap: () {Get.to(() => CurrentLocationScreen());},
            child: controller.userAddress.value == ''
              ? const Icon(Icons.location_on, color: Colors.white)
              : Container(width: 90.w, child: Text(controller.userAddress.value, style: TextStyle(fontSize: 15.sp),)),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => GoogleMap(
          onTap: controller.onTap,
          initialCameraPosition: CameraPosition(target: controller.latlng.value, zoom: 10,),
          markers: {
            Marker(
              draggable: true,
              onDragEnd: (laln) {
                controller.latlng.value = laln;
              },
              markerId: MarkerId('Current Location'),
              position: controller.latlng.value,
            ),
          },
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
      ),
    );
  }
}
