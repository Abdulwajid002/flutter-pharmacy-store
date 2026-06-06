//
// import 'package:flutter/material.dart';
//
// class Order extends StatefulWidget {
//   const Order({super.key});
//
//   @override
//   State<Order> createState() => _OrderState();
// }
//
// class _OrderState extends State<Order> {
//   int quantity = 1;
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
//                 "My Order",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "FredokaBold",
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//
//               Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//
//                     // Image
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset(
//                         "images/medicine.png",
//                         height: 80,
//                         width: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//
//                     SizedBox(width: 15),
//
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Panadol",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//
//                           SizedBox(height: 5),
//
//                           Text("Company: GSK"),
//
//                           SizedBox(height: 5),
//
//                           Text(
//                             "\$100",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Quantity
//                     Column(
//                       children: [
//
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               quantity++;
//                             });
//                           },
//                           child: Icon(Icons.add_circle, color: Colors.black),
//                         ),
//
//                         Text(
//                           quantity.toString(),
//                           style: TextStyle(fontSize: 18),
//                         ),
//
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (quantity > 1) quantity--;
//                             });
//                           },
//                           child: Icon(Icons.remove_circle, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 30),
//
//
//               Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Total Price"),
//                         SizedBox(height: 9),
//                         Text(
//                           "\$${(100 * quantity).toStringAsFixed(2)}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Container(
//                       height: 45,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Checkout",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//


// new


// import 'package:flutter/material.dart';
// import 'package:pharmacyapp/pages/checkout.dart';
//
// class Order extends StatefulWidget {
// const Order({super.key});
//
// @override
// State<Order> createState() => _OrderState();
// }
//
// class _OrderState extends State<Order> {
// int quantity1 = 1;
// int quantity2 = 2;
//
// double price1 = 100;
// double price2 = 150;
//
// double get totalPrice {
// return (quantity1 * price1) + (quantity2 * price2);
// }
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// backgroundColor: const Color(0xfff5f5f5),
//
// appBar: AppBar(
// backgroundColor: Colors.white,
// elevation: 0,
// iconTheme: const IconThemeData(color: Colors.black),
//
// title: const Text(
// "My Orders",
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
//
// body: Padding(
// padding: const EdgeInsets.all(20),
// child: Column(
// children: [
//
// Expanded(
// child: SingleChildScrollView(
// child: Column(
// children: [
//
// orderCard(
// image: "images/medicine.png",
// title: "Panadol",
// company: "GSK Company",
// price: price1,
// quantity: quantity1,
// onAdd: () {
// setState(() {
// quantity1++;
// });
// },
// onRemove: () {
// setState(() {
// if (quantity1 > 1) {
// quantity1--;
// }
// });
// },
// ),
//
// const SizedBox(height: 20),
//
// orderCard(
// image: "images/medicine.png",
// title: "Vitamin C",
// company: "ABC Pharma",
// price: price2,
// quantity: quantity2,
// onAdd: () {
// setState(() {
// quantity2++;
// });
// },
// onRemove: () {
// setState(() {
// if (quantity2 > 1) {
// quantity2--;
// }
// });
// },
// ),
// ],
// ),
// ),
// ),
//
// Container(
// padding: const EdgeInsets.all(20),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(25),
// boxShadow: [
// BoxShadow(
// color: Colors.black12,
// blurRadius: 8,
// ),
// ],
// ),
//
// child: Column(
// children: [
//
// priceRow("Subtotal", "\$${totalPrice.toStringAsFixed(0)}"),
//
// const SizedBox(height: 10),
//
// priceRow("Delivery Fee", "\$20"),
//
// const Divider(height: 30),
//
// priceRow(
// "Total",
// "\$${(totalPrice + 20).toStringAsFixed(0)}",
// isBold: true,
// ),
//
// const SizedBox(height: 20),
//
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const Checkout(),
// ),
// );
// },
//
// child: Container(
// height: 55,
// width: double.infinity,
// decoration: BoxDecoration(
// color: Colors.black,
// borderRadius: BorderRadius.circular(30),
// ),
//
// child: const Center(
// child: Text(
// "Proceed To Checkout",
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// )
// ],
// ),
// )
// ],
// ),
// ),
// );
// }
//
// Widget orderCard({
// required String image,
// required String title,
// required String company,
// required double price,
// required int quantity,
// required VoidCallback onAdd,
// required VoidCallback onRemove,
// }) {
// return Container(
// padding: const EdgeInsets.all(15),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(25),
// boxShadow: [
// BoxShadow(
// color: Colors.black12,
// blurRadius: 6,
// )
// ],
// ),
//
// child: Row(
// children: [
//
// Container(
// padding: const EdgeInsets.all(10),
// decoration: BoxDecoration(
// color: const Color(0xfff3f3f3),
// borderRadius: BorderRadius.circular(20),
// ),
// child: Image.asset(
// image,
// height: 90,
// width: 90,
// ),
// ),
//
// const SizedBox(width: 15),
//
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
//
// Text(
// title,
// style: const TextStyle(
// fontSize: 22,
// fontWeight: FontWeight.bold,
// ),
// ),
//
// const SizedBox(height: 5),
//
// Text(
// company,
// style: TextStyle(
// color: Colors.grey.shade700,
// ),
// ),
//
// const SizedBox(height: 12),
//
// Text(
// "\$${price.toStringAsFixed(0)}",
// style: const TextStyle(
// fontSize: 20,
// color: Colors.green,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ),
//
// Column(
// children: [
//
// GestureDetector(
// onTap: onAdd,
// child: Container(
// padding: const EdgeInsets.all(5),
// decoration: BoxDecoration(
// color: Colors.black,
// borderRadius: BorderRadius.circular(10),
// ),
// child: const Icon(
// Icons.add,
// color: Colors.white,
// ),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 10),
// child: Text(
// quantity.toString(),
// style: const TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
//
// GestureDetector(
// onTap: onRemove,
// child: Container(
// padding: const EdgeInsets.all(5),
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.circular(10),
// ),
// child: const Icon(
// Icons.remove,
// color: Colors.white,
// ),
// ),
// ),
// ],
// )
// ],
// ),
// );
// }
//
// Widget priceRow(String title, String value,
// {bool isBold = false}) {
// return Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
//
// Text(
// title,
// style: TextStyle(
// fontSize: isBold ? 22 : 18,
// fontWeight:
// isBold ? FontWeight.bold : FontWeight.normal,
// ),
// ),
//
// Text(
// value,
// style: TextStyle(
// fontSize: isBold ? 22 : 18,
// fontWeight:
// isBold ? FontWeight.bold : FontWeight.normal,
// color: isBold ? Colors.green : Colors.black,
// ),
// ),
// ],
// );
// }
// }



// 4 new
// import 'package:flutter/material.dart';
// import 'checkout.dart';
//
// class Order extends StatefulWidget {
//   final dynamic medicine;
//
//   const Order({super.key, required this.medicine});
//
//   @override
//   State<Order> createState() => _OrderState();
// }
//
// class _OrderState extends State<Order> {
//   int quantity = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     double price = double.parse(widget.medicine["price"].toString());
//     double total = price * quantity;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Order")),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//
//             // ✅ SHOW SELECTED MEDICINE
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 children: [
//                   Image.asset(widget.medicine["image"], height: 120),
//
//                   Text(
//                     widget.medicine["name"],
//                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//
//                   Text("Price: \$${price.toStringAsFixed(0)}"),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // QUANTITY
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     if (quantity > 1) {
//                       setState(() => quantity--);
//                     }
//                   },
//                   icon: const Icon(Icons.remove),
//                 ),
//
//                 Text(quantity.toString(), style: const TextStyle(fontSize: 22)),
//
//                 IconButton(
//                   onPressed: () {
//                     setState(() => quantity++);
//                   },
//                   icon: const Icon(Icons.add),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             Text(
//               "Total: \$${total.toStringAsFixed(0)}",
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//
//             const Spacer(),
//
//             // ✅ NEXT TO CHECKOUT
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Checkout(
//                       medicine: widget.medicine,
//                       quantity: quantity,
//                       total: total,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text("Proceed to Checkout"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// Grock
import 'package:flutter/material.dart';
import 'package:pharmacyapp/pages/checkout.dart';

class Order extends StatefulWidget {
  final dynamic medicine;
  const Order({super.key, required this.medicine});
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.medicine == null) {
      return const Scaffold(body: Center(child: Text("No medicine selected")));
    }

    double price = double.tryParse(widget.medicine['price'].toString()) ?? 100.0;
    double totalPrice = price * quantity;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(title: const Text("My Orders", style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            orderCard(
              image: widget.medicine['image'] ?? "images/medicine.png",
              title: widget.medicine['name'],
              company: "GSK Company",
              price: price,
              quantity: quantity,
              onAdd: () => setState(() => quantity++),
              onRemove: () => setState(() { if (quantity > 1) quantity--; }),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  priceRow("Subtotal", "\$${totalPrice.toStringAsFixed(0)}"),
                  priceRow("Delivery Fee", "\$20"),
                  const Divider(),
                  priceRow("Total", "\$${(totalPrice + 20).toStringAsFixed(0)}", isBold: true),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Checkout(medicine: widget.medicine, quantity: quantity, total: totalPrice + 20))),
                    child: Container(height: 55, width: double.infinity, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)), child: const Center(child: Text("Proceed To Checkout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCard({required String image, required String title, required String company, required double price, required int quantity, required VoidCallback onAdd, required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xfff3f3f3), borderRadius: BorderRadius.circular(20)), child: Image.asset(image, height: 90, width: 90)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(company, style: TextStyle(color: Colors.grey.shade700)),
                Text("\$${price.toStringAsFixed(0)}", style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(onTap: onAdd, child: Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.add, color: Colors.white))),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(quantity.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              GestureDetector(onTap: onRemove, child: Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.remove, color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }

  Widget priceRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: isBold ? 22 : 18, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: isBold ? 22 : 18, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? Colors.green : Colors.black)),
      ],
    );
  }
}
