import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:demo_app/controllers/geo_controller.dart';
import 'package:demo_app/utils.dart';
import 'package:demo_app/views/locator_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/userController.dart';
import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put<UserController>(UserController());
    controller.fetchUsers();
  }

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> _pickImage(int index, UserController controller) async {
    final XFile? pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.updateUserImage(index, File(pickedFile.path));
    }
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<UserController>(UserController());
    List<UserModel> userList = controller.userList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: Text(
          "Demo App",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(spacing: 4,
          children: [
            LocationView(),
        Flexible(
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                    color: AppColors.greenColor,
                    child: ListTile(
                      title: Text(
                        '${userList[index].firstName} ${userList[index].lastName}',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                      subtitle: Text(
                        '${userList[index].email}',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: userList[index].localImagePath != null
                            ? FileImage(File(userList[index].localImagePath!))
                            : NetworkImage(userList[index].avatar.toString())
                        as ImageProvider,
                      ),
                      trailing: IconButton(
                          onPressed: () => _pickImage(index, controller),
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.whiteColor,
                          )),
                    ),
                  ),
                );
              })),
        )

          ],
        ),
      ),
    );
  }
}
