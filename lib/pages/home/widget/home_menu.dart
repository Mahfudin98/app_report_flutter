import 'package:app_report/pages/analytic/analytic_page.dart';
import 'package:app_report/pages/product/list_product.dart';
import 'package:app_report/pages/report/report_order.dart';
import 'package:app_report/pages/teams/all_teams.dart';
import 'package:app_report/theme/colors/light_colors.dart';
import 'package:app_report/pages/home/widget/card_menu.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);
  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: LightColors.kDarkBlue,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subheading('Menu'),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      CardMenu(
                        cardColor: LightColors.kGreen,
                        icon: const Icon(
                          Icons.analytics_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        title: 'Analytic',
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnalyticPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      CardMenu(
                        cardColor: LightColors.kRed,
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 100,
                        ),
                        title: 'Report Order',
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportOrderPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CardMenu(
                        cardColor: LightColors.kDarkYellow,
                        icon: const Icon(
                          Icons.all_inbox,
                          color: Colors.white,
                          size: 100,
                        ),
                        title: 'List Product',
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListProductPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      CardMenu(
                        cardColor: LightColors.kBlue,
                        icon: const Icon(
                          Icons.supervised_user_circle,
                          color: Colors.white,
                          size: 100,
                        ),
                        title: 'All Team',
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllTeamsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
