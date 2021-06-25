import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class LoginWindow extends StatelessWidget {
  var borderColor = Color(0xff805306);

  // final ValueChanged navigateTo;
  // final BuildContext ctx;

  // LoginWindow({Key key, this.ctx, this.navigateTo});

  @override
  Widget build(BuildContext context) {
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
}

class Window extends StatelessWidget {
  // final ValueChanged navigateTo;
  // final BuildContext ctx;

  // Window({Key key, this.ctx, this.navigateTo});
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
      LoginScreen()
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

class LoginScreen extends StatelessWidget {
  // final ValueChanged navigateTo;
  // final BuildContext ctx;
  // LoginScreen({Key key, this.ctx, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: [Menu(), Body()]));
  }
}

class Menu extends StatelessWidget {
  // final ValueChanged navigateTo;
  // final BuildContext ctx;

  // Menu({Key key, this.ctx, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _logo(title: 'Document Manager', logoSrc: 'assets/images/logo.png'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _menuItem(title: 'Login', isActive: true),
          _registerButton(context),
        ]),
      ]),
    );
  }

  Widget _logo({String title, String logoSrc}) {
    return Padding(
        padding: EdgeInsets.only(right: 75),
        child: Row(children: [
          Image(
            image: AssetImage('$logoSrc'),
            height: 55,
            width: 55,
          ),
          Text('$title',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.grey))
        ]));
  }

  Widget _menuItem({String title, bool isActive = false}) {
    return Padding(
      padding: EdgeInsets.only(right: 75),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('$title',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.deepPurple : Colors.grey,
                  fontSize: 18)),
        ]),
        SizedBox(
          height: 6,
        ),
        isActive
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30)),
              )
            : SizedBox()
      ]),
    );
  }

  Widget _registerButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/register");
        },
        child: new Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], spreadRadius: 10, blurRadius: 12)
              ]),
          child: Text(
            'Register',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ));
  }
}

class Body extends StatelessWidget {
  // final ValueChanged navigateTo;
  // final BuildContext ctx;
  // Body({Key key, this.ctx, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          width: 350,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Sign In to \nDocument Manager',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),
            Text(
              'If you don\'t have an account',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Text('You can',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/register");
                  },
                  child: new Container(
                      child: Text(
                    'Register Here',
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  )))
            ]),
            Image.asset('assets/images/startpage_bg.png', width: 320),
          ])),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width / 20),
        child: Container(width: 350, child: _formLogin()),
      ),
    ]);
  }

  Widget _formLogin() {
    return Column(children: [
      TextField(
          decoration: InputDecoration(
        hintText: "Enter Email",
        fillColor: Colors.blueGrey[50],
        suffixIcon: Icon(FontAwesomeIcons.envelope, color: Colors.grey),
        filled: true,
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]),
            borderRadius: BorderRadius.circular(15)),
      )),
      SizedBox(
        height: 30,
      ),
      TextField(
          decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.blueGrey[50],
        counterText: "Forgot Password?",
        suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey),
        filled: true,
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[50]),
            borderRadius: BorderRadius.circular(15)),
      )),
      SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple[100],
                spreadRadius: 10,
                blurRadius: 20,
              )
            ]),
        child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("Sign In")),
            ),
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
      ),
      SizedBox(
        height: 40,
      ),
      Row(children: [
        Expanded(child: Divider(height: 50, color: Colors.grey[300])),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Or continue with")),
        Expanded(child: Divider(height: 50, color: Colors.grey[300])),
      ]),
      SizedBox(height: 40),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _loginWithButton(image: 'assets/images/google.png'),
        _loginWithButton(image: 'assets/images/github.png', isActive: true),
        _loginWithButton(image: 'assets/images/facebook.png'),
      ])
    ]);
  }

  Widget _loginWithButton({String image, bool isActive = false}) {
    return Container(
        width: 90,
        height: 70,
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 2, blurRadius: 15)
                  ])
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[400])),
        child: Center(
            child: Container(
          decoration: isActive
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        spreadRadius: 2,
                        blurRadius: 15,
                      )
                    ])
              : BoxDecoration(),
          child: Image.asset('$image', width: 35),
        )));
  }
}
