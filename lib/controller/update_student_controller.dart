import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_getx/model/model.dart';

class UpdateStudentController extends GetxController {
  final nameController = TextEditingController();
  final gradeController = TextEditingController();
  final ageController = TextEditingController();
  final guardianNameController = TextEditingController();
  final guardianPhoneController = TextEditingController();
  final profileImage = Rxn<File>();

  final ImagePicker _imagePicker = ImagePicker();

  void initialize(StudentModel student) {
    nameController.text = student.name;
    gradeController.text = student.grade;
    ageController.text = student.age;
    guardianNameController.text = student.guardianName;
    guardianPhoneController.text = student.guardianPhone;
    profileImage.value = File(student.profileImage);
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void updateStudent(StudentModel student) {
    final updatedStudent = StudentModel(
      id: student.id,
      name: nameController.text,
      grade: gradeController.text,
      age: ageController.text,
      guardianName: guardianNameController.text,
      guardianPhone: guardianPhoneController.text,
      profileImage: profileImage.value?.path ?? student.profileImage,
    );
    log('Updated student: ${updatedStudent.toMap()}');

    Get.back(result: updatedStudent);
  }
}
