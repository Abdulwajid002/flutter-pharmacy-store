import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pharmacyapp/screens/home_screen.dart';
import 'package:pharmacyapp/screens/my_orders_screen.dart';
import 'package:pharmacyapp/screens/wallet_screen.dart';
import 'package:pharmacyapp/screens/profile_screen.dart';
import 'package:pharmacyapp/widgets/app_widgets.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;

  final _pages = const [
    HomeScreen(),
    MyOrdersScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 62,
        backgroundColor: AppColors.bg,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.accent,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOut,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          Icon(Icons.home_rounded,          color: Colors.white, size: 28),
          Icon(Icons.receipt_long_rounded,  color: Colors.white, size: 26),
          Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 26),
          Icon(Icons.person_rounded,        color: Colors.white, size: 28),
        ],
      ),
    );
  }
}
