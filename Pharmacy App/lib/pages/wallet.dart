//
//
// import 'package:flutter/material.dart';
//
// class Wallet extends StatefulWidget {
//   const Wallet({super.key});
//
//   @override
//   State<Wallet> createState() => _WalletState();
// }
//
// class _WalletState extends State<Wallet> {
//   double balance = 250.75;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 184, 182, 218),
//
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 50, left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(60),
//                   ),
//                   child: Icon(Icons.arrow_back, color: Colors.black),
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//
//               Text(
//                 "My Wallet",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "FredokaBold",
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//
//               Container(
//                 padding: EdgeInsets.all(20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xfff7bc3c), Color(0xfff2a900)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(
//                       "Available Balance",
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 18,
//                       ),
//                     ),
//
//                     SizedBox(height: 10),
//
//                     Text(
//                       "\$${balance.toStringAsFixed(2)}",
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 30),
//
//
//               Text(
//                 "Recent Transactions",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               SizedBox(height: 15),
//
//
//               transactionCard("Panadol Purchase", "-\$200", Colors.red),
//
//               SizedBox(height: 10),
//
//
//               transactionCard("Vitamin Order", "-\$100", Colors.red),
//
//               SizedBox(height: 10),
//
//
//               transactionCard("Wallet Top-up", "+\$100.00", Colors.green),
//
//               SizedBox(height: 30),
//
//
//               Container(
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Add Money",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget transactionCard(String title, String amount, Color color) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//
//           Text(
//             title,
//             style: TextStyle(fontSize: 16),
//           ),
//
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 16,
//               color: color,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }



// new


// ========================== WALLET.DART ==========================

import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
const Wallet({super.key});

@override
State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

double balance = 250.75;

void addMoney() {

setState(() {

balance += 100;
});

ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(
backgroundColor: Colors.green,
content: Text("100 Added Successfully"),
),
);
}

@override
Widget build(BuildContext context) {

return Scaffold(
backgroundColor: const Color(0xfff5f5f5),

appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,

iconTheme: const IconThemeData(color: Colors.black),

title: const Text(
"My Wallet",

style: TextStyle(
color: Colors.black,
),
),
),

body: Padding(
padding: const EdgeInsets.all(20),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

Container(
width: double.infinity,
padding: const EdgeInsets.all(25),

decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xfff7bc3c),
Color(0xfff2a900),
],
),

borderRadius: BorderRadius.circular(25),
),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

const Text(
"Available Balance",

style: TextStyle(
fontSize: 18,
),
),

const SizedBox(height: 10),

Text(
"\$${balance.toStringAsFixed(2)}",

style: const TextStyle(
fontSize: 35,
fontWeight: FontWeight.bold,
),
),
],
),
),

const SizedBox(height: 30),

const Text(
"Recent Transactions",

style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 20),

transactionCard(
"Panadol Purchase",
"-\$100",
Colors.red,
),

const SizedBox(height: 10),

transactionCard(
"Wallet Top Up",
"+\$100",
Colors.green,
),

const Spacer(),

GestureDetector(
onTap: addMoney,

child: Container(
height: 55,
width: double.infinity,

decoration: BoxDecoration(
color: Colors.black,
borderRadius: BorderRadius.circular(30),
),

child: const Center(
child: Text(
"Add Money",

style: TextStyle(
color: Colors.white,
fontSize: 18,
),
),
),
),
)
],
),
),
);
}

Widget transactionCard(
String title,
String amount,
Color color,
) {

return Container(
padding: const EdgeInsets.all(15),

decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
),

child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,

children: [

Text(
title,

style: const TextStyle(
fontSize: 16,
),
),

Text(
amount,

style: TextStyle(
fontSize: 16,
color: color,
fontWeight: FontWeight.bold,
),
),
],
),
);
}
}


