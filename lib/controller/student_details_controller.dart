
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/db_functions.dart';
import 'package:student_management_getx/model/model.dart';

class StudentDetailsController extends GetxController {
  var students = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }
  

  Future<void> fetchStudents() async {
  try {
    final studentList = await DatabaseHelper().fetchStudents();
    students.assignAll(studentList); 
    log('Fetched students: ${studentList.map((s) => s.toMap()).toList()}');
  } catch (e) {
    print('Error fetching students: $e');
  }
}

 void deleteStudent(StudentModel student) {
  Get.dialog(
    AlertDialog(
      title: Text('Delete Student'),
      content: Text('Are you sure you want to delete ${student.name}?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); 
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await DatabaseHelper().deleteStudent(student.id!);  // Delete student
            fetchStudents(); 
            Get.back();  
          },
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
void updateStudentDetails(StudentModel updatedStudent) {
  log('updateStudentDetails called with: ${updatedStudent.toMap()}');
  int index = students.indexWhere((s) => s.id == updatedStudent.id);
  if (index != -1) {
    students[index] = updatedStudent;
    log('Updating student in list: ${updatedStudent.toMap()}');
    students.refresh();
    updateStudentInDatabase(updatedStudent);
  } else {
    log('Student with id ${updatedStudent.id} not found.');
  }
}

Future<void> updateStudentInDatabase(StudentModel updatedStudent) async {
  try {
    await DatabaseHelper().updateStudent(updatedStudent);  
    fetchStudents(); 
  } catch (e) {
    log('Error updating student in database: $e');
  }
}

}
