import 'package:app_report/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class ReportOrderPage extends StatelessWidget {
  const ReportOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kRed,
        title: Text("Report Order"),
      ),
    );
  }
}
