import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/controller/student_details_controller.dart';
import 'package:student_management_getx/model/model.dart';
import 'package:student_management_getx/screens/update_student_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final StudentDetailsController _controller = Get.put(StudentDetailsController());
  final StudentModel student;

  StudentDetailsScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedStudent = await Get.to(() => UpdateStudentScreen(student: student));
              if (updatedStudent != null && updatedStudent is StudentModel) {
                _controller.updateStudentDetails(updatedStudent);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _controller.deleteStudent(student);
            },
          ),
        ],
      ),
      body: Obx(() {
        final updatedStudent = _controller.students.firstWhereOrNull((s) => s.id == student.id);

        if (updatedStudent == null) {
          return Center(child: Text('Student not found'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(updatedStudent.profileImage)),
                ),
                SizedBox(height: 20),
                Text('Name: ${updatedStudent.name}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('Grade: ${updatedStudent.grade}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Age: ${updatedStudent.age}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Guardian Name: ${updatedStudent.guardianName}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Guardian Phone: ${updatedStudent.guardianPhone}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
