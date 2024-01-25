import 'package:flutter/material.dart';

class loginForm extends StatelessWidget {
  const loginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            // Add your login form fields and logic here
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            // Add your login form fields and logic here
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add your login button logic here
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

