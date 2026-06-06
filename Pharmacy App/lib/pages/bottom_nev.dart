// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/Home.dart';
// import 'package:pharmacyapp/pages/order.dart';
// import 'package:pharmacyapp/pages/profile.dart';
// import 'package:pharmacyapp/pages/wallet.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//
// class BottomNev extends StatefulWidget {
//   const BottomNev({super.key});
//
//   @override
//   State<BottomNev> createState() => _BottomNevState();
// }
//
// class _BottomNevState extends State<BottomNev> {
//   late List<Widget> pages;
//   late Home home;
//   late Order order;
//   late Wallet wallet;
//   late Profile profile;
//
//   int currentTabIndex=0;
//
//   @override
//   void initState() {
//     home = Home();
//     order = Order();
//     wallet = Wallet();
//     profile = Profile();
//     pages=[home,order,wallet,profile];
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         height: 60,
//         backgroundColor: Color.fromARGB(253, 184, 182, 218),
//         color: Colors.black,
//         animationDuration: Duration(milliseconds: 500),
//         onTap: (int index){
//           setState(() {
//             currentTabIndex = index;
//           });
//         },
//         items: [
//           currentTabIndex ==0?Icon(Icons.home, color: Colors.white,size: 30.0,): Icon(Icons.home, color: Colors.white,),
//           currentTabIndex ==1?Icon(Icons.shopping_cart, color: Colors.white,size: 30.0,): Icon(Icons.shopping_cart, color: Colors.white),
//           currentTabIndex ==2?Icon(Icons.wallet, color: Colors.white,size: 30.0,): Icon(Icons.wallet, color: Colors.white),
//           currentTabIndex ==3?Icon(Icons.person, color: Colors.white,size: 30.0,): Icon(Icons.person, color: Colors.white),
//         ],
//       ),
//
//       body: pages[currentTabIndex],
//     );
//   }
// }
//
//
//



// Grock
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/Home.dart';
import 'package:pharmacyapp/pages/order.dart';
import 'package:pharmacyapp/pages/profile.dart';
import 'package:pharmacyapp/pages/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNev extends StatefulWidget {
  const BottomNev({super.key});
  @override
  State<BottomNev> createState() => _BottomNevState();
}

class _BottomNevState extends State<BottomNev> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: const Color.fromARGB(253, 184, 182, 218),
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() => currentTabIndex = index);
        },
        items: const [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.shopping_cart, color: Colors.white, size: 30),
          Icon(Icons.wallet, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
      ),
      body: IndexedStack(
        index: currentTabIndex,
        children: const [
          Home(),
          Order(medicine: null),
          Wallet(),
          Profile(),
        ],
      ),
    );
  }
}