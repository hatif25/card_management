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
    if(fname.text!="" || lname.text!="" || email.text!="" || phone.text!="" || password.text!="" || uname.text!=""  )
    {
      try{
        String uri ="http://192.168.99.173/card_management/insert_record.php";

        var res = await http.post(Uri.parse(uri),body: {
          "fname": fname.text,
          "lname": lname.text,
          "email": email.text,
          "phone": phone.text,
          "password": password.text,
          "uname": uname.text,
        });
        print('Raw Response: ${res.body}');

        var response = jsonDecode(res.body);
        if(response["success"]) {
          print("Record inserted successfully");
        } 
        else {
          print("Some issues were encountered");
        }
      }
      catch(e){
        print("Error decoding JSON response: $e");
      }

    } else {
      print("Please fill all fields");
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
