
import 'package:flutter/material.dart';
import 'package:pharmacyapp/admin/add_product.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [


          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Color(0xff1E3A8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 60),

                Icon(Icons.admin_panel_settings,
                    size: 70, color: Colors.white),

                SizedBox(height: 10),

                Text(
                  "Admin Panel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "FredokaBold",
                  ),
                ),

                Text(
                  "Secure Login",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontFamily: "FredokaLight",
                  ),
                ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4,
              left: 20,
              right: 20,
              bottom: 70,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                  spreadRadius: 2,
                )
              ],
            ),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 30),

                  Center(
                    child: Text(
                      "Admin Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "FredokaBold",
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Text("Admin Email",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "FredokaBold")),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Enter Admin Email",
                      ),
                    ),
                  ),

                  SizedBox(height: 20),


                  Text("Password",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "FredokaBold")),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Enter Password",
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 30),


                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProduct()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff1E3A8A),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Login as Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "FredokaBold",
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Center(
                    child: Text(
                      "Only authorized admins can access",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

