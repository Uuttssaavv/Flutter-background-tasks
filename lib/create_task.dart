// ignore_for_file: use_build_context_synchronously

import 'package:bg_service_demo/services/background_services.dart';
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  //  initialize the bg services
  final backgroundServices = BackgroundServices.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () async {
          await backgroundServices.invokeTask(
            task: 'createTask',
            payload: {
              'title': titleController.text,
              'description': descriptionController.text,
            },
          );

          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: [
            textField(
              titleController,
              hintText: 'Task name',
            ),
            const SizedBox(height: 12.0),
            textField(
              descriptionController,
              hintText: 'Task description',
              lines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(TextEditingController controller,
      {required String hintText, int lines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
