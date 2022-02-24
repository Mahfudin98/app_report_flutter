import 'package:app_report/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class ListProductPage extends StatelessWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: Text("List Product"),
      ),
    );
  }
}
