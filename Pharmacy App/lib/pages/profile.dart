
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/login.dart';
import 'package:pharmacyapp/widgets/support_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb8b6d8),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60, bottom: 30),
              decoration: BoxDecoration(
                color: Color(0xfff7bc3c),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [

                  Text(
                    "Profile Page",
                    style: AppWidget.lightTextStyle(28.0),
                  ),

                  SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        "images/boy1.jpg",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Abdul Wajid",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "FredokaBold",
                    ),
                  ),

                  Text(
                    "Software Engineer",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            profileCard(Icons.person, "Name", "Abdul Wajid"),
            profileCard(Icons.email, "Email", "abdulwajid@gmail.com"),

            SizedBox(height: 10),


            actionCard(
              Icons.logout,
              "LogOut",
              Colors.red,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
              },
            ),

            SizedBox(height: 10),


            actionCard(
              Icons.delete,
              "Delete Account",
              Colors.black,
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }


  Widget profileCard(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }


  Widget actionCard(IconData icon, String title, Color color,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
