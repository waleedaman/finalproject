import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatelessWidget {
  String _navPath = "";
  @override
  Widget build(BuildContext context) {
    _getInitialRoute(context).then((val){
      _navPath = val;
    });
    Future.delayed(const Duration(milliseconds: 1000), () => showAlert(context));
    return Container(
    );
  }
  Future<String> _getInitialRoute(BuildContext ctx) async {
    final prefs = await SharedPreferences.getInstance();
    final initialRun = prefs.getInt('initialRun') ?? 0;
    if (initialRun == 0) {
      // prefs.setInt('initialRun', 1);
      return "/register";
    } else {
      return "/login";
    }
  }

  showAlert(BuildContext context) {Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();}
}
