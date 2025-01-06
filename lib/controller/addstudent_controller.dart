import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_getx/db_functions.dart';
import 'package:student_management_getx/model/model.dart';

class AddStudentController extends GetxController {
  var nameController = TextEditingController();
  var gradeController = TextEditingController();
  var ageController = TextEditingController();
  var guardianNameController = TextEditingController();
  var guardianPhoneController = TextEditingController();
  Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void saveStudent() async {
    if (nameController.text.isEmpty || gradeController.text.isEmpty || ageController.text.isEmpty || guardianNameController.text.isEmpty || guardianPhoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (profileImage.value == null) {
      Get.snackbar('Error', 'Please select a profile image');
      return;
    }

    final student = StudentModel(
      name: nameController.text,
      grade: gradeController.text,
      age: ageController.text,
      guardianName: guardianNameController.text,
      guardianPhone: guardianPhoneController.text,
      profileImage: profileImage.value!.path,
    );

    await DatabaseHelper().insertStudent(student);

    Get.back(); 
  }
}
