
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

   static const String apiUrl = 'http://192.168.1.10:8000/api/v1/friends/';

   Future<void> submitName(BuildContext context, String name) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'name': name},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name submitted successfully!')),
        );
      }                                                                       
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error. Please check your internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 submitName(context, nameController.text);
                 nameController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                foregroundColor: Colors.white, 
                elevation: 4, 
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 24), 
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), 
                ),
              ),
              child: const Text('Submit')
            ),
          ],
        ),
      ),
    );
  }
}
