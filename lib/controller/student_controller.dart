import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/db_functions.dart';
import 'package:student_management_getx/model/model.dart';

class HomeController extends GetxController {
  var students = <StudentModel>[].obs;  
  var isGridView = true.obs;  

  @override
  void onInit() {
    super.onInit();
    fetchStudents(); 
  }

 Future<void> fetchStudents() async {
    try {
      final studentList = await DatabaseHelper().fetchStudents();  
      students.assignAll(studentList);  
    } catch (e) {
      print('Error fetching students: $e');
    }
  }



  void addStudent(StudentModel student) {
    students.add(student); 
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
    void toggleView() {
    isGridView.value = !isGridView.value; 
    }

}
