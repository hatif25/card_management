import 'package:card_management/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController uname= TextEditingController();
  TextEditingController cpassword = TextEditingController();


  Future<void> insertrecord() async {
  final url = "http://192.168.205.173/practice/insert_record.php";

  try {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(Uri.parse(url), body: {
        "uname": uname.text,
        "fname": fname.text,
        "lname": lname.text,
        "email": email.text,
        "phone": phone.text,
        "password": password.text,
      });

      print('Raw Response: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseBody = json.decode(response.body);

        if (responseBody["success"] != null && responseBody["success"]) {
          // Registration successful, show dialog
          print("Record inserted successfully");
          await showGenericDialog(
            context: context,
            title: 'Registration Successful',
            content: 'You have successfully registered.',
            optionsBuilder: () {
              return {
                'OK': 'OK',
              };
            },
          );
        } else {
          // Registration failed, show error message
          print("Registration failed: ${responseBody["message"]}");
          // Handle showing error message to user
        }
      } else {
        // Handle HTTP error response
        print('HTTP Error: ${response.statusCode}');
      }
    }
  } catch (e) {
    print("Error: $e");
  }
}


    
  

  bool _obscureText = true;

  // Validation functions
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name cannot be empty';
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Last name cannot be empty';
    }
    return null;
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Last name cannot be empty';
    }
    return null;
  }
  String? validateEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.length != 10) {
      return 'Phone number must contain 10 digits';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
    String? confirmPassword(String value) {
    if (value != password.text) {
      return "Password doesn't match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/register.png'),
              SizedBox(height: 10),
              TextFormField(
                controller: fname,
                validator: (value) => validateFirstName(value!),
                decoration: InputDecoration(
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lname,
                validator: (value) => validateLastName(value!),
                decoration: InputDecoration(
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
               TextFormField(
                controller: uname,
                validator: (value) => validateUsername(value!),
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                  labelText: 'Username',
                  prefixIcon: Icon(
                    Icons.assignment_ind_outlined,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
               SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                validator: (value) => validateEmail(value!),
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  labelText: 'Email address',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phone,
                validator: (value) => validatePhone(value!),
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  labelText: 'Phone number',
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: password,
                obscureText: _obscureText,
                validator: (value) => validatePassword(value!),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  prefixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
                            TextFormField(
                controller: cpassword,
                obscureText: _obscureText,
                validator: (value) => confirmPassword(value!),
                decoration: InputDecoration(
                  hintText: 'Enter the passowrd again',
                  labelText: 'Confirm Password',
                  prefixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                   insertrecord();
                    }
                  },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
