import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_management_getx/controller/student_controller.dart';
import 'package:student_management_getx/model/model.dart';
import 'package:student_management_getx/screens/student_details_screen.dart';

class StudentSearchDelegate extends SearchDelegate<String> {
  final List<StudentModel> students;

  StudentSearchDelegate(this.students);

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = students.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildSearchListView(suggestions);
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = students.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildSearchListView(results);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // Reusable list view builder for search results
  Widget _buildSearchListView(List<StudentModel> filteredStudents) {
    if (filteredStudents.isEmpty) {
      return Center(
        child: Text('No students found'),
      );
    }

    return ListView.builder(
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(File(student.profileImage)),
          ),
          title: Text(student.name),
          subtitle: Text('Grade: ${student.grade}, Age: ${student.age}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Get.find<HomeController>().deleteStudent(student);
            },
          ),
          onTap: () {
            Get.to(() => StudentDetailsScreen(student: student));
          },
        );
      },
    );
  }
}
