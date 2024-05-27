import 'dart:convert';
import 'package:card_management/views/expense_query.dart';
import 'package:card_management/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  final String loggedInUsername;

  const ProfileView({Key? key, required this.loggedInUsername}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // late String firstName;
  // late String lastName;
  // late String email;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserInfo();
  // }

  // Future<void> fetchUserInfo() async {
  //   try {
  //     // Perform API call to retrieve user info using loggedInUsername
  //     final url = Uri.parse('http://192.168.205.173/practice/user_info.php');
  //     final response = await http.post(url, body: {'username': widget.loggedInUsername});

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> userData = json.decode(response.body);

  //       setState(() {
  //         firstName = userData['fname'];
  //         lastName = userData['lname'];
  //         email = userData['email'];
  //       });
  //     } else {
  //       throw Exception('Failed to fetch user info');
  //     }
  //   } catch (e) {
  //     print('Error fetching user info: $e');
  //     // Handle error here
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0, top: 16.0),
              child: Text(
                'My Profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 8.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 70,
                      minRadius: 30,
                      backgroundImage: AssetImage('assets/images/836.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Full Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Your Email ID',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    // wrap with Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Your Expense manager'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FilterScreen()));
                      },
                    ),
                  ),
                  Card(
                    // wrap with Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Change Password'),
                      onTap: () {
                        // Handle change password action
                      },
                    ),
                  ),
                  Card(
                    // wrap with Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Logout'),
                      onTap: () {
                        // Handle logout action
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginView()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
