import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:student_management_getx/controller/update_student_controller.dart';
import 'package:student_management_getx/model/model.dart';

class UpdateStudentScreen extends StatelessWidget {
  final StudentModel student;

  UpdateStudentScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateStudentController());
    controller.initialize(student);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                GestureDetector(
                  onTap: controller.pickImageFromGallery,
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!)
                          : AssetImage('assets/default_avatar.png') as ImageProvider,
                      child: controller.profileImage.value == null
                          ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                          : null,
                    );
                  }),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.nameController,
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
                  controller: controller.gradeController,
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
                  controller: controller.ageController,
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
                  controller: controller.guardianNameController,
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
                  controller: controller.guardianPhoneController,
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

                ElevatedButton(
                  onPressed: () => controller.updateStudent(student),
                  child: Text('Update Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
