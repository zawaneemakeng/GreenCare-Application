import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:greencare/widgets/header_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    HeaderWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
