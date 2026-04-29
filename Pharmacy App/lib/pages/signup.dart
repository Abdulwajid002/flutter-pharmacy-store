
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

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

                Icon(Icons.person_add, size: 60, color: Colors.black),

                SizedBox(height: 10),

                Text(
                  "Join Us",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "FredokaBold",
                  ),
                ),

                Text(
                  "Create your account",
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
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "FredokaBold",
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: Text(
                      "Fill details to continue",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 30),


                  Text("Full Name",
                      style: TextStyle(fontFamily: "FredokaBold")),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Enter your name",
                      ),
                    ),
                  ),

                  SizedBox(height: 20),


                  Text("Email",
                      style: TextStyle(fontFamily: "FredokaBold")),

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
                        hintText: "Enter email",
                      ),
                    ),
                  ),

                  SizedBox(height: 20),


                  Text("Password",
                      style: TextStyle(fontFamily: "FredokaBold")),

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
                        hintText: "Enter password",
                      ),
                    ),
                  ),

                  SizedBox(height: 20),


                  Text("Confirm Password",
                      style: TextStyle(fontFamily: "FredokaBold")),

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
                        icon: Icon(Icons.lock_outline),
                        border: InputBorder.none,
                        hintText: "Re-enter password",
                      ),
                    ),
                  ),

                  SizedBox(height: 30),


                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff7bc3c),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "FredokaBold",
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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
