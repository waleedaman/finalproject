import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterWindow extends StatelessWidget {
  var borderColor = Color(0xff805306);
  // final ValueChanged navigateTo;

  // RegisterWindow({Key key, this.navigateTo});
  
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

  // LoginScreen({Key key, this.navigateTo});
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

  // Menu({Key key, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _logo(title: 'Document Manager', logoSrc: 'assets/images/logo.png'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _loginButton(context),
          _menuItem(title: 'Register', isActive: true),
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
      padding: EdgeInsets.only(left: 75),
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

  Widget _loginButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/login");
        },
        child: new Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey[200], spreadRadius: 10, blurRadius: 12)
          ]),
        child: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      )
    );
  }
}

class Body extends StatelessWidget {
  // final ValueChanged navigateTo;

  // Body({Key key, this.navigateTo});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          width: 350,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Register for \nDocument Manager',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),
            Text(
              'If you already have an account',
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
                  Navigator.of(context).pushNamed("/login");
                },
                child: new Container(child:Text(
                    'Sign In Here',
                    style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  )
                )
              )
            ]),
            Image.asset('assets/images/startpage_bg.png', width: 320),
          ])),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width / 12),
        child: Container(width: 350, child: _formLogin()),
      ),
    ]);
  }

  Widget _formLogin() {
    return Column(children: [
      Container(
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:TextField(
                decoration: InputDecoration(
                hintText: "First Name",
                fillColor: Colors.blueGrey[50],
                suffixIcon: Icon(FontAwesomeIcons.userAlt, color: Colors.grey),
                filled: true,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]),
                    borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]),
                    borderRadius: BorderRadius.circular(15)
                ),
                )
              ),
            ),
            SizedBox(width:10),
            Expanded(
              child:TextField(
                decoration: InputDecoration(
                hintText: "Last Name",
                fillColor: Colors.blueGrey[50],
                suffixIcon: Icon(FontAwesomeIcons.userAlt, color: Colors.grey),
                filled: true,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]),
                    borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]),
                    borderRadius: BorderRadius.circular(15)
                ),
                )
              ),
            ),
          ]
        ),
      ),
      SizedBox(
        height: 30,
      ),
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
                borderRadius: BorderRadius.circular(15)
              ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]),
                borderRadius: BorderRadius.circular(15)
              ),
          )
        ),
      SizedBox(
        height: 30,
      ),
      TextField(
          decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.blueGrey[50],
        counterText: "Include capital letters,numbers and special characters",
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
      SizedBox(
        height: 10
        ),
      TextField(
          decoration: InputDecoration(
        hintText: "Organization",
        fillColor: Colors.blueGrey[50],
        suffixIcon: Icon(FontAwesomeIcons.building, color: Colors.grey),
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
              child: Center(child: Text("Create Account")),
            ),
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
      ),
    ]);
  }


}





