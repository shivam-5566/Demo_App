import 'package:demo_app/controllers/geo_controller.dart';
import 'package:demo_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black54, width: 1),
        color: Colors.green.shade200,
      ),
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
                "Latitude: ${locationController.latitude.value}",
                style: TextStyle(color: AppColors.blackColor),
              )),
          Obx(() => Text(
                "Longitude: ${locationController.longitude.value}",
                style: TextStyle(color: AppColors.blackColor),
              )),
          Obx(() => Text(
                "Address: ${locationController.address.value}",
                style: TextStyle(color: AppColors.blackColor),
              )),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green)),
              onPressed: locationController.fetchLocation,
              child: Center(
                child: Text(
                  "Tap for loading....",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
