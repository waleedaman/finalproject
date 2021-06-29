import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class SplashScreen extends StatelessWidget {
  String _navPath = "";
  var borderColor = Color(0xff805306);
  @override
  Widget build(BuildContext context) {
    _getInitialRoute(context).then((val){
      _navPath = val;
      Navigator.of(context).pushNamed(_navPath);
    });
    return Scaffold(
      // backgroundColor:Color(0x00050505),
      body: WindowBorder(
          width: 1,
          color: borderColor,
          child: Row(
            children: [
              Window(),
            ],
          )),
    );
  }



  Future<String> _getInitialRoute(BuildContext ctx) async {
    final prefs = await SharedPreferences.getInstance();
    final initialRun = prefs.getInt('initialRun') ?? 0;
    if (initialRun == 0) {
      Future.delayed(const Duration(milliseconds: 1000), () => showAlert(ctx));
      return "/register";
    } else {
      return "/login";
    }
  }

  showAlert(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Alert(
      context: context,
      title: "Online/Offline",
      desc: "Select if you want to use the tool online or offline. If you choose online you can use the tool on any computer and access all your data.",
      buttons: [
        DialogButton(
          child: Text(
            "Online",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            if(_navPath != ""){
              prefs.setInt('initialRun', 1);
              prefs.setString('mode', "online");
              Navigator.of(context).pushNamed(_navPath);
            }else{
              final initialRun = prefs.getInt('initialRun') ?? 0;
              prefs.setInt('initialRun', 1);
              prefs.setString('mode', "online");
              if (initialRun == 0) {
                Navigator.of(context).pushNamed("/register");
              }else{
                Navigator.of(context).pushNamed("/login");
              }
            }
          },
          gradient: LinearGradient(colors: [
            Colors.deepPurple[500],
            Colors.deepPurple[900],
            Colors.deepPurple[500],
          ]),
        ),
        DialogButton(
          child: Text(
            "Offline",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            if(_navPath != ""){
              prefs.setInt('initialRun', 1);
              prefs.setString('mode', "offline");
              Navigator.of(context).pushNamed(_navPath);
            }else{
              final initialRun = prefs.getInt('initialRun') ?? 0;
              prefs.setInt('initialRun', 1);
              prefs.setString('mode', "offline");
              if (initialRun == 0) {
                Navigator.of(context).pushNamed("/register");
              }else{
                Navigator.of(context).pushNamed("/login");
              }
            }
          },
          gradient: LinearGradient(colors: [
            Colors.deepPurple[500],
            Colors.deepPurple[900],
            Colors.deepPurple[500],
          ]),
        )
      ],
    ).show();
  }
}

class Window extends StatelessWidget {
  // final ValueChanged navigateTo;

  // Window({Key key, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            child: Column(children: [
              WindowTitleBarBox(
                  child: Row(children: [
                    Expanded(
                      child: MoveWindow(),
                    ),
                    WindowButtons(),
                  ])),
            ])));
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MinimizeWindowButton(),
      MaximizeWindowButton(),
      CloseWindowButton()
    ]);
  }
}
