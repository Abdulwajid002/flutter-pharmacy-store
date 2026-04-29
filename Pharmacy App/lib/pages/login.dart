
import 'package:flutter/material.dart';
import 'package:pharmacyapp/admin/admin_login.dart';
import 'package:pharmacyapp/pages/Home.dart';
import 'package:pharmacyapp/pages/bottom_nev.dart';
import 'package:pharmacyapp/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfff7bc3c), Color(0xffffd86b)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 60),
                Icon(Icons.local_pharmacy, size: 60, color: Colors.black),
                SizedBox(height: 10),
                Text(
                  "Pharmacy App",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "FredokaBold",
                  ),
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 18,
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
              bottom: 40,
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
                      "Login Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "FredokaBold",
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: Text(
                      "Login to continue",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 30),


                  Text("Email Address",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "FredokaBold")),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Enter your email",
                      ),
                    ),
                  ),

                  SizedBox(height: 20),


                  Text("Password",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "FredokaBold")),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Enter password",
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

                  SizedBox(height: 25),


                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Home()),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BottomNev()),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff7bc3c),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "FredokaBold",
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),


                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminLogin()));

                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Admin Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "FredokaBold",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xfff7bc3c),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
