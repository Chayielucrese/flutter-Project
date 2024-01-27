import 'package:flutter/material.dart';

class PlayChosenMusic extends StatelessWidget {
  const PlayChosenMusic({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Play Music'),
                  content: Text('Chosen Music Name'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Implement play music logic here
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Play'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Play Music'),
        ),
      ),
    );
  }
}