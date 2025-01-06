import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/controller/student_controller.dart';
import 'package:student_management_getx/model/model.dart';
import 'package:student_management_getx/screens/student_search_delegate.dart';
import 'add_student_screen.dart';
import 'student_details_screen.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StudentSearchDelegate(_controller.students),
              );
            },
          ),
          ToggleButtons(
            children: [
              Icon(Icons.list),
              Icon(Icons.grid_view),
            ],
            isSelected: [_controller.isGridView.value == false, _controller.isGridView.value == true],
            onPressed: (index) {
              _controller.toggleView(); 
            },
          ),
        ],
      ),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: _controller.fetchStudents,
          child: _controller.isGridView.value
              ? _buildGridView()
              : _buildListView(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newStudent = await Get.to(() => AddStudentScreen()) as StudentModel?;
          if (newStudent != null) {
            _controller.addStudent(newStudent); 
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Build the list view
  Widget _buildListView() {
    return ListView.builder(
      itemCount: _controller.students.length,
      itemBuilder: (context, index) {
        final student = _controller.students[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(File(student.profileImage)),
          ),
          title: Text(student.name),
          subtitle: Text('Grade: ${student.grade}, Age: ${student.age}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _controller.deleteStudent(student); 
            },
          ),
          onTap: () {
            Get.to(() => StudentDetailsScreen(student: student)); 
          },
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemCount: _controller.students.length,
      itemBuilder: (context, index) {
        final student = _controller.students[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => StudentDetailsScreen(student: student));  // Navigate using GetX
          },
          child: Card(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.file(
                        File(student.profileImage),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        student.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Grade: ${student.grade}, Age: ${student.age}'),
                    ),
                  ],
                ),
                Positioned(
                  right: 4,
                  top: 70,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _controller.deleteStudent(student);  // Delete student using GetX controller
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

