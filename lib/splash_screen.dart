import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/modules/home/views/home_view.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    _homeController.getReminder();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.off(() => HomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayAnimation<double>(
        tween: Tween(begin: 100, end: 150),
        duration: const Duration(milliseconds: 1500),
        builder: (context, child, value) {
          return Center(
            child: SizedBox(
                height: value,
                width: value,
                child: Image.asset(
                  'assets/logo.png',
                )),
          );
        },
      ),
    );
  }
}
