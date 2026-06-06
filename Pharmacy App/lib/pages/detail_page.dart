//
// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/order.dart';
// import 'package:pharmacyapp/widgets/support_widget.dart';
//
// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key});
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   int quantity = 1;
//
//   void increaseQty() {
//     setState(() {
//       quantity++;
//     });
//   }
//
//   void decreaseQty() {
//     setState(() {
//       if (quantity > 1) quantity--;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 184, 182, 218),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             const SizedBox(height: 50),
//
//
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.arrow_back, color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               height: MediaQuery.of(context).size.height / 2.8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xffbab3a6),
//                     Color(0xffddd7cd),
//                     Color(0xffa59c8f),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Center(
//                 child: Image.asset(
//                   "images/medicine.png",
//                   height: 220,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   // Title + Qty
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Panadol",
//                         style: AppWidget.headlineTextStyle(22.0),
//                       ),
//
//                       // Quantity Box
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.black12,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           children: [
//
//                             GestureDetector(
//                               onTap: decreaseQty,
//                               child: const Icon(Icons.remove, size: 20),
//                             ),
//
//                             const SizedBox(width: 10),
//
//                             Text(
//                               "$quantity",
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//
//                             const SizedBox(width: 10),
//
//                             GestureDetector(
//                               onTap: increaseQty,
//                               child: const Icon(Icons.add, size: 20),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   Text(
//                     "Description",
//                     style: AppWidget.lightTextStyle(18.0),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   const Text(
//                     "Panadol is a widely used medicine for pain relief and fever reduction. It helps in headache, body pain, and flu symptoms effectively.",
//                     style: TextStyle(height: 1.4),
//                   ),
//
//                   const SizedBox(height: 25),
//
//
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.05),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Total Price",
//                               style: AppWidget.lightTextStyle(16.0),
//                             ),
//                             Text(
//                               "\$${quantity * 100}",
//                               style: AppWidget.headlineTextStyle(22.0),
//                             ),
//                           ],
//                         ),
//
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const Order()));
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 25, vertical: 15),
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: const Text(
//                               "Order Now",
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//




// new

// ========================== DETAIL_PAGE.DART ==========================

// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/order.dart';
//
// class DetailPage extends StatefulWidget {
// const DetailPage({super.key});
//
// @override
// State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//
// int quantity = 1;
//
// @override
// Widget build(BuildContext context) {
//
// return Scaffold(
// backgroundColor: const Color(0xfff5f5f5),
//
// appBar: AppBar(
// backgroundColor: Colors.white,
// elevation: 0,
//
// iconTheme: const IconThemeData(color: Colors.black),
// ),
//
// body: Padding(
// padding: const EdgeInsets.all(20),
//
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
//
// Center(
// child: Image.asset(
// "images/medicine.png",
// height: 250,
// ),
// ),
//
// const SizedBox(height: 20),
//
// const Text(
// "Panadol",
//
// style: TextStyle(
// fontSize: 30,
// fontWeight: FontWeight.bold,
// ),
// ),
//
// const SizedBox(height: 10),
//
// const Text(
// "Best medicine for pain and fever.",
//
// style: TextStyle(
// fontSize: 18,
// color: Colors.grey,
// ),
// ),
//
// const SizedBox(height: 20),
//
// Row(
// children: [
//
// GestureDetector(
// onTap: () {
//
// setState(() {
//
// if (quantity > 1) {
// quantity--;
// }
// });
// },
//
// child: Container(
// padding: const EdgeInsets.all(10),
//
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.circular(10),
// ),
//
// child: const Icon(
// Icons.remove,
// color: Colors.white,
// ),
// ),
// ),
//
// const SizedBox(width: 20),
//
// Text(
// quantity.toString(),
//
// style: const TextStyle(
// fontSize: 25,
// fontWeight: FontWeight.bold,
// ),
// ),
//
// const SizedBox(width: 20),
//
// GestureDetector(
// onTap: () {
//
// setState(() {
//
// quantity++;
// });
// },
//
// child: Container(
// padding: const EdgeInsets.all(10),
//
// decoration: BoxDecoration(
// color: Colors.green,
// borderRadius: BorderRadius.circular(10),
// ),
//
// child: const Icon(
// Icons.add,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
//
// const Spacer(),
//
// GestureDetector(
// onTap: () {
//
// Navigator.push(
// context,
//
// MaterialPageRoute(
// builder: (context) => const Order(),
// ),
// );
// },
//
// child: Container(
// height: 55,
// width: double.infinity,
//
// decoration: BoxDecoration(
// color: Colors.black,
// borderRadius: BorderRadius.circular(30),
// ),
//
// child: const Center(
// child: Text(
// "Order Now",
//
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// ),
// ),
// ),
// ),
// )
// ],
// ),
// ),
// );
// }
// }



// Grock

import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/order.dart';

class DetailPage extends StatefulWidget {
  final dynamic medicine;   // ← Added this

  const DetailPage({super.key, required this.medicine});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double price = double.tryParse(widget.medicine['price'].toString()) ?? 100.0;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.medicine['name'], style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.medicine['image'] ?? "images/medicine.png",
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.medicine['name'],
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.medicine['description'] ?? "Best medicine for pain and fever.",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Quantity Selector
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(
                      medicine: widget.medicine,   // ← Fixed: Passing data
                    ),
                  ),
                );
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


