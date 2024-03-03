import 'package:card_management/views/expense_query.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

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
                padding:
                    EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 20),
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
                          'Md Hatif Farooque',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'mthraza72@gmail.com',
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
