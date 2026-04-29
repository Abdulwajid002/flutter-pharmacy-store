
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/detail_page.dart';
import 'package:pharmacyapp/pages/login.dart';
import 'package:pharmacyapp/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool allmedicine = true, suppliment = false, vitamins = false, herbal = false;

  Widget medicineCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xffbab3a6),
              Color(0xffddd7cd),
              Color(0xffa59c8f)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "images/medicine.png",
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 250,
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Unique Medicine",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("\$100",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text("Panadol"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 182, 218),


      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Pharmacy App",
            style: TextStyle(color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.logout, color: Colors.black),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset("images/boy1.jpg",
                    height: 80, width: 80, fit: BoxFit.cover),
              ),

              const SizedBox(height: 20),
              Text("Your Trusted",
                  style: AppWidget.headlineTextStyle(26.0)),
              Text("Online Pharmacy",
                  style: AppWidget.lightTextStyle(26.0)),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 227, 222, 247),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Medicine...",
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Categories (simple row scroll)
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    category("All", allmedicine, () {
                      setState(() {
                        allmedicine = true;
                        suppliment = vitamins = herbal = false;
                      });
                    }),
                    category("Suppliment", suppliment, () {
                      setState(() {
                        suppliment = true;
                        allmedicine = vitamins = herbal = false;
                      });
                    }),
                    category("Vitamins", vitamins, () {
                      setState(() {
                        vitamins = true;
                        allmedicine = suppliment = herbal = false;
                      });
                    }),
                    category("Herbal", herbal, () {
                      setState(() {
                        herbal = true;
                        allmedicine = suppliment = vitamins = false;
                      });
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              medicineCard(),
              medicineCard(),
              medicineCard(),
              medicineCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget category(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
