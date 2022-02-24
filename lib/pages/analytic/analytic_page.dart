import 'package:app_report/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class AnalyticPage extends StatelessWidget {
  const AnalyticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kGreen,
        title: Text("Analytic"),
      ),
    );
  }
}
