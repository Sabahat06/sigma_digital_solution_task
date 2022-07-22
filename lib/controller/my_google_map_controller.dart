import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sigma_digital_solution/services/http_service.dart';

class MyGoogleMapController extends GetxController{
  Rx<LatLng> latlng = LatLng(0.0, 0.0).obs;
  RxString userAddress = ''.obs;

  onTap(position) {
    latlng.value = position;
    convertLatLngIntoAddress(latlng.value);
  }

  convertLatLngIntoAddress(LatLng currentLatLng) async {
    var response = await HttpService.getAddress(currentLatLng, 'AIzaSyDodI_dtDEr_P9ur1yYfW80QM3NQoStAxA');
    if(response["status"] == "OK"){
      if(response["results"].length > 0){
        Map firstresult = response["results"][0];
        userAddress.value = firstresult["formatted_address"];
      }
    }
  }

}













