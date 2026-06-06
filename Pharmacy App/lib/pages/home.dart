//
// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/detail_page.dart';
// import 'package:pharmacyapp/pages/login.dart';
// import 'package:pharmacyapp/widgets/support_widget.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool allmedicine = true, suppliment = false, vitamins = false, herbal = false;
//
//   Widget medicineCard() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const DetailPage()),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 20, right: 20),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xffbab3a6),
//               Color(0xffddd7cd),
//               Color(0xffa59c8f)
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: Image.asset(
//                 "images/medicine.png",
//                 height: 250,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               height: 250,
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: const EdgeInsets.all(15),
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.85),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text("Unique Medicine",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                         Text("\$100",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     const Text("Panadol"),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 184, 182, 218),
//
//
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text("Pharmacy App",
//             style: TextStyle(color: Colors.black)),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Navigator.pushReplacement( // yaha mana chara ha
//                 context,
//                 MaterialPageRoute(builder: (context) => const Login()),
//               );
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 20),
//               child: Icon(Icons.logout, color: Colors.black),
//             ),
//           )
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, top: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(60),
//                 child: Image.asset("images/boy1.jpg",
//                     height: 80, width: 80, fit: BoxFit.cover),
//               ),
//
//               const SizedBox(height: 20),
//               Text("Your Trusted",
//                   style: AppWidget.headlineTextStyle(26.0)),
//               Text("Online Pharmacy",
//                   style: AppWidget.lightTextStyle(26.0)),
//
//               const SizedBox(height: 20),
//
//               // Search Bar
//               Container(
//                 margin: const EdgeInsets.only(right: 20),
//                 padding: const EdgeInsets.only(left: 20),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 227, 222, 247),
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(color: Colors.white, width: 1.5),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Search Medicine...",
//                     suffixIcon: Container(
//                       margin: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: const Icon(Icons.search, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Categories
//               SizedBox(
//                 height: 50,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     category("All", allmedicine, () {
//                       setState(() {
//                         allmedicine = true;
//                         suppliment = vitamins = herbal = false;
//                       });
//                     }),
//                     category("Suppliment", suppliment, () {
//                       setState(() {
//                         suppliment = true;
//                         allmedicine = vitamins = herbal = false;
//                       });
//                     }),
//                     category("Vitamins", vitamins, () {
//                       setState(() {
//                         vitamins = true;
//                         allmedicine = suppliment = herbal = false;
//                       });
//                     }),
//                     category("Herbal", herbal, () {
//                       setState(() {
//                         herbal = true;
//                         allmedicine = suppliment = vitamins = false;
//                       });
//                     }),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               medicineCard(),
//               medicineCard(),
//               medicineCard(),
//               medicineCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget category(String title, bool active, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(right: 20),
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           color: active ? Colors.black : Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: active ? Colors.white : Colors.black,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }





// new code
// ========================== HOME.DART ==========================
// import 'package:http/http.dart' as http;
// import 'package:pharmacyapp/pages/order.dart';
// import 'package:pharmacyapp/services/api.dart';
//
//
// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/detail_page.dart';
// import 'package:pharmacyapp/pages/login.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool allmedicine = true,
//       suppliment = false,
//       vitamins = false,
//       herbal = false;
//
//   List medicines = [
//     {
//       "name": "Panadol",
//       "price": "\$100",
//       "category": "All",
//       "image": "images/medicine.png",
//     },
//     {
//       "name": "Vitamin C",
//       "price": "\$150",
//       "category": "Vitamins",
//       "image": "images/medicine.png",
//     },
//     {
//       "name": "Herbal Syrup",
//       "price": "\$200",
//       "category": "Herbal",
//       "image": "images/medicine.png",
//     },
//     {
//       "name": "Omega 3",
//       "price": "\$300",
//       "category": "Suppliment",
//       "image": "images/medicine.png",
//     },
//   ];
//
//   List filteredMedicine = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredMedicine = medicines;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff5f5f5),
//
//       drawer: Drawer(
//         child: ListView(
//           children: [
//
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Color(0xfff7bc3c),
//               ),
//
//               child: Column(
//                 children: [
//
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: AssetImage("images/boy1.jpg"),
//                   ),
//
//                   SizedBox(height: 10),
//
//                   Text(
//                     "Abdul Wajid",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text("Home"),
//             ),
//
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text("Logout"),
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Login()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//
//         title: const Text(
//           "Pharmacy App",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const Text(
//               "Find Your Medicine",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//
//               child: const TextField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Search medicines...",
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             SizedBox(
//               height: 45,
//
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//
//                   category(
//                     "All",
//                     allmedicine,
//                         () {
//                       setState(() {
//
//                         filteredMedicine = medicines;
//
//                         allmedicine = true;
//                         suppliment = vitamins = herbal = false;
//                       });
//                     },
//                   ),
//
//                   category(
//                     "Vitamins",
//                     vitamins,
//                         () {
//                       setState(() {
//
//                         filteredMedicine = medicines.where((item) =>
//                         item["category"] == "Vitamins").toList();
//
//                         vitamins = true;
//                         allmedicine = suppliment = herbal = false;
//                       });
//                     },
//                   ),
//
//                   category(
//                     "Herbal",
//                     herbal,
//                         () {
//                       setState(() {
//
//                         filteredMedicine = medicines.where((item) =>
//                         item["category"] == "Herbal").toList();
//
//                         herbal = true;
//                         allmedicine = suppliment = vitamins = false;
//                       });
//                     },
//                   ),
//
//                   category(
//                     "Suppliment",
//                     suppliment,
//                         () {
//                       setState(() {
//
//                         filteredMedicine = medicines.where((item) =>
//                         item["category"] == "Suppliment").toList();
//
//                         suppliment = true;
//                         allmedicine = vitamins = herbal = false;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Expanded(
//               child: GridView.builder(
//                 itemCount: filteredMedicine.length,
//
//                 gridDelegate:
//                 const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                   crossAxisSpacing: 15,
//                   mainAxisSpacing: 15,
//                 ),
//
//                 itemBuilder: (context, index) {
//
//                   var medicine = filteredMedicine[index];
//
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => Order(medicine: medicine),
//                       //     ),
//                       // );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Order(
//                             medicine: medicine,
//                           ),
//                         ),
//                       );
//                     },
//
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 5,
//                           )
//                         ],
//                       ),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//
//                           Expanded(
//                             child: Image.asset(
//                               medicine["image"],
//                             ),
//                           ),
//
//                           Text(
//                             medicine["name"],
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//
//                           const SizedBox(height: 5),
//
//                           Text(
//                             medicine["price"],
//                             style: const TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget category(String title, bool active, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//
//       child: Container(
//         margin: const EdgeInsets.only(right: 10),
//
//         padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10
//         ),
//
//         decoration: BoxDecoration(
//           color: active ? Colors.black : Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//
//         child: Text(
//           title,
//
//           style: TextStyle(
//             color: active ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }




// Grock
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/order.dart';
import 'package:pharmacyapp/services/api.dart';
import 'package:pharmacyapp/pages/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> medicines = [];
  List<dynamic> filteredMedicine = [];
  bool isLoading = true;

  bool allmedicine = true, suppliment = false, vitamins = false, herbal = false;

  @override
  void initState() {
    super.initState();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      final data = await ApiService.getMedicines();
      setState(() {
        medicines = data;
        filteredMedicine = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xfff7bc3c)),
              child: Column(
                children: const [
                  CircleAvatar(radius: 40, backgroundImage: AssetImage("images/boy1.jpg")),
                  SizedBox(height: 10),
                  Text("Abdul Wajid", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(leading: const Icon(Icons.home), title: const Text("Home")),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login())),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Pharmacy App", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Find Your Medicine", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: "Search medicines...", prefixIcon: Icon(Icons.search))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category("All", allmedicine, () => setState(() { filteredMedicine = medicines; allmedicine = true; suppliment = vitamins = herbal = false; })),
                  category("Vitamins", vitamins, () => setState(() { filteredMedicine = medicines.where((item) => item["category"] == "Vitamins").toList(); vitamins = true; allmedicine = suppliment = herbal = false; })),
                  category("Herbal", herbal, () => setState(() { filteredMedicine = medicines.where((item) => item["category"] == "Herbal").toList(); herbal = true; allmedicine = suppliment = vitamins = false; })),
                  category("Suppliment", suppliment, () => setState(() { filteredMedicine = medicines.where((item) => item["category"] == "Suppliment").toList(); suppliment = true; allmedicine = vitamins = herbal = false; })),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: filteredMedicine.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  var medicine = filteredMedicine[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Order(medicine: medicine))),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image.asset(medicine["image"] ?? "images/medicine.png")),
                          Text(medicine["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("\$${medicine["price"]}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget category(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: active ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Text(title, style: TextStyle(color: active ? Colors.white : Colors.black)),
      ),
    );
  }
}