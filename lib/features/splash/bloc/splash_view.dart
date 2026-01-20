import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../login/bloc/login_view.dart';
import 'splash_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController walkingAnimationController;

  @override
  void initState() {
    walkingAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    //start
    walkingAnimationController.forward();
    // Navigate after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (_) => LoginPage()),
        PageRouteBuilder(
          pageBuilder: (_, _, _) => LoginPage(),
          transitionsBuilder: (_, animation, _, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(curved),
                child: child,
              ),
            );
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🚶 WALKING LOTTIE
            SizedBox(
              height: 220,
              child: Lottie.asset(
                'assets/lottie/Walking.json',
                controller: walkingAnimationController,
                repeat: true,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Loading...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
