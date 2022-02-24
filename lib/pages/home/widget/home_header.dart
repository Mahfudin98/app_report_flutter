import 'dart:convert';

import 'package:app_report/theme/colors/light_colors.dart';
import 'package:app_report/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({Key? key, required this.width}) : super(key: key);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final double width;

  @override
  Future AuthUser() async {
    var token;
    final SharedPreferences localStorage = await _prefs;
    token = localStorage.getString('data')?.replaceAll("\"", "");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://app-r.lsskincare.id/api/user-authenticated'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var jsonData = jsonDecode(await response.stream.bytesToString());
    return jsonData['data'];
  }

  Widget build(BuildContext context) {
    return TopContainer(
      height: 220,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.report,
                  color: LightColors.kDarkBlue, size: 30.0),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: LightColors.kRed,
                ),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused)) {
                          return Colors.red;
                        }
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  radius: 65.0,
                  lineWidth: 5.0,
                  animation: true,
                  percent: 0.75,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: LightColors.kRed,
                  backgroundColor: LightColors.kDarkYellow,
                  center: FutureBuilder(
                      future: AuthUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['image'] != null) {
                            return CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                "https://app-r.lsskincare.id/storage/teams/" +
                                    snapshot.data['image'],
                              ),
                            );
                          } else {
                            return const CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: FutureBuilder(
                          future: AuthUser(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data['name'],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: LightColors.kDarkBlue,
                                  fontWeight: FontWeight.w800,
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    Container(
                      child: FutureBuilder(
                        future: AuthUser(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data['position'] != null) {
                              return Text(
                                snapshot.data['position'],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            } else {
                              return const Text(
                                "Superadmin",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
    );
  }
}
