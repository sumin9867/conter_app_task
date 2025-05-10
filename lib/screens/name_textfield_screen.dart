import 'package:flutter/material.dart';

class NameTextfieldScreen extends StatelessWidget {
  const NameTextfieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedName = nameController.text.isNotEmpty
                    ? nameController.text
                    : 'User';
                Navigator.pop(context, updatedName);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}