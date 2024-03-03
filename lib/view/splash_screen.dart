import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/view/introScreen/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // Start the animation
    _controller.forward();

    // Use Future.delayed with a callback or then function
    Future.delayed(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(const IntroScreen(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500));
      } else {
        NavigationUtils.popUntilNav();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF57AFEF),
            Color.fromRGBO(70, 66, 253, 0.93),
            Color(0xFF4983F3),
            Color(0xFF1271FF),
          ],
          stops: [-0.0674, 0.1948, 0.5634, 0.9512],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          transform: GradientRotation(2.22), // Adjust the angle as needed
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              print(_controller.value);
              return Transform.scale(
                scale: _controller.value,
                child: child,
              );
            },
            child: const Image(
              image: AssetImage(ImagePathUtils.logo),
              height: 400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
