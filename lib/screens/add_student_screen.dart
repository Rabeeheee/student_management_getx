import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/controller/addstudent_controller.dart';

class AddStudentScreen extends StatelessWidget {
  final AddStudentController _controller = Get.put(AddStudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _controller.pickImageFromGallery,
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: _controller.profileImage.value != null
                          ? FileImage(_controller.profileImage.value!)
                          : AssetImage('assets/image.jpg') as ImageProvider,
                      child: _controller.profileImage.value == null
                          ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                          : null,
                    );
                  }),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.gradeController,
                  decoration: InputDecoration(
                    labelText: 'Grade',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the grade';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.guardianNameController,
                  decoration: InputDecoration(
                    labelText: 'Guardian Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the guardian name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.guardianPhoneController,
                  decoration: InputDecoration(
                    labelText: 'Guardian Phone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the guardian phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _controller.saveStudent,
                  child: Text('Save Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
