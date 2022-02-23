import 'package:app_report/pages/home/widget/home_header.dart';
import 'package:app_report/pages/home/widget/home_menu.dart';
import 'package:app_report/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(width: width),
            const HomeMenu(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Created By Mahfudin_Nawawi",
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
