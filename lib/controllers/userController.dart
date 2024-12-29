import 'dart:convert';
import 'dart:io';
import 'package:demo_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/db_helper.dart';

class UserController extends GetxController {
  var userList = <UserModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading(true);
    final dbUsers = await DBHelper().fetchUsers();
    if (dbUsers.isNotEmpty) {
      userList.assignAll(
        dbUsers.map((user) => UserModel.fromMap(user)).toList(),
      );
    } else {
      final apiUsers = await getUsers();
      for (var user in apiUsers) {
        await DBHelper().insertUser(user.toMap());
      }
      userList.assignAll(apiUsers);
    }
    isLoading(false);
  }

  Future<void> updateUserImage(int index, File imageFile) async {
    final user = userList[index];
    user.localImagePath = imageFile.path;
    await DBHelper().updateUserImage(user.id!, imageFile.path);
    userList[index] = user;
  }

  Future<List<UserModel>> getUsers() async {
    const String userUrl = "https://reqres.in/api/users?page=2";
    final response = await http.get(Uri.parse(userUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      userList.value = result.map((e) => UserModel.fromJson(e)).toList();
      return userList;
    } else {
      return [];
    }
  }
}
