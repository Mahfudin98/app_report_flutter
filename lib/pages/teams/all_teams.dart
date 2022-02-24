import 'package:app_report/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class AllTeamsPage extends StatelessWidget {
  const AllTeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kBlue,
        title: Text("All Teams"),
      ),
    );
  }
}
