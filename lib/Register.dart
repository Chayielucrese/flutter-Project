import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'playlist.dart';
import 'package:http/http.dart' as http;

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showLoginForm = false;
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleLoginForm() {
    setState(() {
      _showLoginForm = !_showLoginForm;
    });
  }
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String surname = _surnameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      final response = await registerEndPoint(name, surname, email, password);
      if (response.statusCode == 200) {
        _formKey.currentState!.reset();
        _showLoginDialog(context);
      } else {
        response.statusCode;
      }
    }
  }

  Future<http.Response> registerEndPoint(
      String name, String surname, String email, String password) async {
    const url = 'http://localhost:4000/api/createuser';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
      },
    );
    return response;
  }
  void _showLoginDialog(BuildContext context) {
    void _submitForm() async {
      if (_formKey.currentState!.validate()) {
        String name = _nameController.text;
        String surname = _surnameController.text;
        String email = _emailController.text;
        String password = _passwordController.text;

        Future<http.Response> login(String email, String password) async {
          const url = 'http://localhost:4000/api/login';
          final response = await http.post(
            Uri.parse(url),
            body: {
              "email": email,
              "pwd": password,
            },
          );
          return response;
        }

        final response = await login(email, password);
        if (response.statusCode == 200) {
          _formKey.currentState!.reset();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => playList()),
          );
        } else {
          response.statusCode;
        }
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple.shade200.withOpacity(0.9),
          title: Text('Sign In'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email',   labelStyle: TextStyle(color: Colors.white, fontSize: 15), ),

              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password',  labelStyle: TextStyle(color: Colors.white, fontSize: 15)),
                obscureText: true,

              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>playList()));
              },
              child: Text('Login', style: TextStyle(color: Colors.purple, fontSize: 20),

              ),
            ),


          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(fontSize: 30, color: Colors.purple),
        ),
      ),
      body: Center(
        child: Container(
          height: 900,
          width: 500,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'data:image/jpeg;base64,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'),
            fit: BoxFit.cover,
          )),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                      labelText: 'Surname',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    // You can add additional email validation logic here
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add additional password validation logic here
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.green)
                  ),
                  onPressed: (){
                    _showLoginDialog(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      backgroundColor: Colors.green
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
