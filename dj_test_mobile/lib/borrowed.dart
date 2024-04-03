import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BorrowedPage extends StatefulWidget {
  const BorrowedPage({Key? key}) : super(key: key);

  @override
  _BorrowedPageState createState() => _BorrowedPageState();
}

class _BorrowedPageState extends State<BorrowedPage> {
  final TextEditingController returnController = TextEditingController();
  String selectedWhat = '';
  int selectedWhatIndex = 0;
  String selectedToWho = '';
  int selectedToWhoIndex = 0;
  List<String> whatOptions = [];
  List<String> toWhoOptions = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData to populate dropdowns
  }

  Future<void> fetchData() async {
    const apiUrl = 'http://192.168.1.10:8000/api/v1/belongings/';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final List<String> whatList = [];
      for (final item in data) {
        whatList.add(item['name']);
      }
      setState(() {
        whatOptions = whatList.toSet().toList();
        if (whatOptions.isNotEmpty) selectedWhat = whatOptions[0];
      });
    }

    const apiUrl2 = 'http://192.168.1.10:8000/api/v1/friends/';
    final response2 = await http.get(Uri.parse(apiUrl2));
    
    if (response2.statusCode == 200) {
      final data = json.decode(response2.body) as List;
      final List<String> toWho = [];
      for (final item in data) {
       toWho.add(item['name']);
      }
      setState(() {
        toWhoOptions = toWho.toSet().toList();
        if (toWhoOptions.isNotEmpty) selectedToWho = toWhoOptions[0];
      });
    }
  }

  int findSelectedIndex(String selectedValue, List<String> options) {
    return options.indexOf(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedWhat,
              onChanged: (newValue) {
                setState(() {
                  selectedWhat = newValue!;
                });
              },
              items: whatOptions.map((what) {
                return DropdownMenuItem<String>(
                  value: what,
                  child: Text(what),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'What',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedToWho,
              onChanged: (newValue) {
                setState(() {
                  selectedToWho = newValue!;
                });
              },
              items: toWhoOptions.map((toWho) {
                return DropdownMenuItem<String>(
                  value: toWho,
                  child: Text(toWho),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'To who',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                pickDateTime(context);
              },
              child: Text(
                'Return: ${returnController.text.isEmpty ? 'Select date and time' : returnController.text}',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                submitData(selectedWhat, selectedToWho, returnController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 4,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          returnController.text = pickedDateTime.toString();
        });
      }
      selectedWhatIndex = findSelectedIndex(selectedWhat, whatOptions);
      selectedToWhoIndex = findSelectedIndex(selectedToWho, toWhoOptions);
      setState(() {
        selectedWhatIndex = selectedWhatIndex + 1;
        selectedToWhoIndex = selectedToWhoIndex + 1;
      });
      print('SELECTED WHAT: ');
      print(selectedWhatIndex);

      print('SELECTED TO WHO: ');
      print(selectedToWhoIndex);
    }
  }

  void submitData(String selectedWhat, String selectedToWho, String returnDate) async {
    const apiUrl = 'http://192.168.1.10:8000/api/v1/borrowings/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(<String, dynamic>{
          'what': selectedWhatIndex,
          'to_who': selectedToWhoIndex,
          'returned': returnController.text,
        })
      );
      if (response.statusCode == 201) {
        // Successful submission
        print('Data submitted successfully!');
      } else {
        // Failed submission
        print('Failed to submit data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Error handling for network errors
      print('Network error: $error');
    }
  }
}
