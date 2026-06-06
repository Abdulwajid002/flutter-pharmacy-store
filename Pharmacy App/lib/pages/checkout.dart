//
// // ========================== CHECKOUT.DART ==========================
// //
// // import 'package:flutter/material.dart';
// // import 'package:pharmacyapp/pages/bottom_nev.dart';
// //
// // class Checkout extends StatelessWidget {
// // const Checkout({super.key});
// //
// // @override
// // Widget build(BuildContext context) {
// // return Scaffold(
// // backgroundColor: const Color(0xfff5f5f5),
// //
// // appBar: AppBar(
// // backgroundColor: Colors.white,
// // elevation: 0,
// // iconTheme: const IconThemeData(color: Colors.black),
// //
// // title: const Text(
// // "Checkout",
// // style: TextStyle(color: Colors.black),
// // ),
// // ),
// //
// // body: Padding(
// // padding: const EdgeInsets.all(20),
// //
// // child: Column(
// // children: [
// //
// // Container(
// // padding: const EdgeInsets.all(20),
// //
// // decoration: BoxDecoration(
// // color: Colors.white,
// // borderRadius: BorderRadius.circular(20),
// // ),
// //
// // child: Column(
// // children: [
// //
// // rowData("Medicine", "Panadol"),
// // rowData("Quantity", "2"),
// // rowData("Delivery", "\$20"),
// //
// // const Divider(),
// //
// // rowData("Total", "\$220"),
// // ],
// // ),
// // ),
// //
// // const SizedBox(height: 25),
// //
// // Container(
// // padding: const EdgeInsets.all(20),
// //
// // decoration: BoxDecoration(
// // color: Colors.white,
// // borderRadius: BorderRadius.circular(20),
// // ),
// //
// // child: Column(
// // children: [
// //
// // TextField(
// // decoration: InputDecoration(
// // hintText: "Enter Address",
// //
// // border: OutlineInputBorder(
// // borderRadius: BorderRadius.circular(20),
// // ),
// // ),
// // ),
// //
// // const SizedBox(height: 20),
// //
// // TextField(
// // decoration: InputDecoration(
// // hintText: "Phone Number",
// //
// // border: OutlineInputBorder(
// // borderRadius: BorderRadius.circular(20),
// // ),
// // ),
// // ),
// // ],
// // ),
// // ),
// //
// // const Spacer(),
// //
// // GestureDetector(
// // onTap: () {
// //
// // ScaffoldMessenger.of(context).showSnackBar(
// // const SnackBar(
// // backgroundColor: Colors.green,
// //
// // content: Text(
// // "Order Placed Successfully!",
// // style: TextStyle(color: Colors.white),
// // ),
// // ),
// // );
// //
// // Future.delayed(const Duration(seconds: 2), () {
// //
// // Navigator.pushAndRemoveUntil(
// // context,
// //
// // MaterialPageRoute(
// // builder: (context) => const BottomNev(),
// // ),
// //
// // (route) => false,
// // );
// // });
// // },
// //
// // child: Container(
// // height: 55,
// // width: double.infinity,
// //
// // decoration: BoxDecoration(
// // color: Colors.black,
// // borderRadius: BorderRadius.circular(30),
// // ),
// //
// // child: const Center(
// // child: Text(
// // "Place Order",
// //
// // style: TextStyle(
// // color: Colors.white,
// // fontSize: 18,
// // ),
// // ),
// // ),
// // ),
// // )
// // ],
// // ),
// // ),
// // );
// // }
// //
// // Widget rowData(String title, String value) {
// //
// // return Padding(
// // padding: const EdgeInsets.only(bottom: 15),
// //
// // child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //
// // children: [
// //
// // Text(
// // title,
// // style: const TextStyle(fontSize: 18),
// // ),
// //
// // Text(
// // value,
// //
// // style: const TextStyle(
// // fontSize: 18,
// // fontWeight: FontWeight.bold,
// // ),
// // )
// // ],
// // ),
// // );
// // }
// // }
//
//
// // 4 new
// import 'package:flutter/material.dart';
// import '../services/api.dart';
// import 'bottom_nev.dart';
//
// class Checkout extends StatelessWidget {
//   final dynamic medicine;
//   final int quantity;
//   final double total;
//
//   const Checkout({
//     super.key,
//     required this.medicine,
//     required this.quantity,
//     required this.total,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Checkout")),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//
//             // SHOW SELECTED DATA
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Medicine: ${medicine["name"]}"),
//                   Text("Quantity: $quantity"),
//                   Text("Total: \$${total.toStringAsFixed(0)}"),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             const TextField(
//               decoration: InputDecoration(
//                 hintText: "Enter Address",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             const TextField(
//               decoration: InputDecoration(
//                 hintText: "Phone Number",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const Spacer(),
//
//             // PLACE ORDER
//             ElevatedButton(
//               onPressed: () async {
//                 await ApiService.placeOrder({
//                   "user_id": 1,
//                   "medicine_name": medicine["name"],
//                   "quantity": quantity,
//                   "total": total,
//                 });
//
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Order Placed Successfully")),
//                 );
//
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const BottomNev()),
//                       (route) => false,
//                 );
//               },
//               child: const Text("Place Order"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//


// Grock
import 'package:flutter/material.dart';
import 'package:pharmacyapp/services/api.dart';
import 'package:pharmacyapp/pages/bottom_nev.dart';

class Checkout extends StatelessWidget {
  final dynamic medicine;
  final int quantity;
  final double total;

  const Checkout({super.key, required this.medicine, required this.quantity, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  rowData("Medicine", medicine['name']),
                  rowData("Quantity", quantity.toString()),
                  rowData("Delivery", "\$20"),
                  const Divider(),
                  rowData("Total", "\$${total.toStringAsFixed(0)}"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                try {
                  await ApiService.placeOrder({
                    "user_id": 1,
                    "medicine_name": medicine['name'],
                    "quantity": quantity,
                    "total": total,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green, content: Text("Order Placed Successfully!")));
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const BottomNev()), (route) => false);
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
                child: const Center(child: Text("Place Order", style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 18)), Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
    );
  }
}