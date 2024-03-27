import 'package:flutter/material.dart';

class BorrowedPage extends StatelessWidget {
  const BorrowedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belonging'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'What',
                border: OutlineInputBorder(),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'To who',
                border: OutlineInputBorder(),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'When',
                border: OutlineInputBorder(),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Return',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // API call dre? idk
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
