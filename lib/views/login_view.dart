import 'package:card_management/views/credit_card_view.dart';
import 'package:card_management/views/main_view.dart';
import 'package:card_management/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

Future<void> login(BuildContext context, String uname, String password) async {
  final url = "http://192.168.205.173/practice/login.php";

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'uname': uname,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
      final responseBody = json.decode(response.body);

   if (responseBody['success'] != null && responseBody['success']) {
  // Set uname in UserProvider
  Provider.of<UserProvider>(context, listen: false).setUname(uname);

  // Navigate to MainWidget if login is successful
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MainWidget(),
    ),
  );
}else {
        // Handle login failure here
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        print('Login failed: $errorMessage');
        // Show error message to the user if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Handle error response
      print('Login failed with status: ${response.statusCode}');
      // Show error message to the user if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed with status: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    // Handle network or server errors
    print('Error: $e');
    // Show error message to the user if needed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/login.png',
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
            ),
            TextFormField(
              controller: uname,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              controller: pass,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the login function
                await login(context, uname.text, pass.text);
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Don\'t have an account? ',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterView(),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}



class UserProvider with ChangeNotifier {
  String _uname = '';

  String get uname => _uname;

  void setUname(String uname) {
    _uname = uname;
    notifyListeners();
  }
}