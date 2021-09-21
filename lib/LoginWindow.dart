import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'actions.dart';
import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';


class LoginWindow extends StatelessWidget {
  var borderColor = Color(0xff805306);
  String data;

  LoginWindow({
    this.data,
  }):super();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child:Scaffold(
          // backgroundColor:Color(0x00050505),
          body: WindowBorder(
              width: 1,
              color: borderColor,
              child: Row(
                children: [
                  Window(data:data),
                ],
              )),
        ));
  }
}

class Window extends StatelessWidget {
  // final ValueChanged navigateTo;
  // final BuildContext ctx;
  String data;
  Window({this.data}):super();
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

              LoginScreen(data:data),
            ])
        )
    );
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
  String data;
  LoginScreen({this.data});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
          children:[
            ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 8),
                children: [
                  Menu(),
                  Body(data:data)
                ]
            ),
            DropdownAlert(delayDismiss:6000),
          ]
      ),
    );
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
                  color: isActive ? primaryColor : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ]),
        SizedBox(
          height: 6,
        ),
        isActive
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
              color: primaryColor,
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
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
              ),
          child: Text(
            'Register',
            style:
            TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
class Body extends StatefulWidget{
  String data;
  Body({this.data});
  @override
  _BodyState createState() => _BodyState(data:data);
}
class _BodyState extends State<Body> {
  String data;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _passwordObscured = true;
  _BodyState({this.data});

  get store =>  StoreProvider.of<AppState>(context);
  void initState() {
    super.initState();
    _passwordObscured = true;
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>
        showAlert(data)
    );
  }


  @override
  Widget build(BuildContext context,) {
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
              TextStyle( fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Text('You can',
                  style: TextStyle(
                       fontWeight: FontWeight.bold)),
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
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )))
            ]),
            Image.asset('assets/images/startpage_bg.png', width: 320),
          ])),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width / 20),
        child: Container(width: 350, child: _formLogin(context:context,emailController:emailController, passwordController:passwordController)),
      ),
    ]);
  }

  Widget _formLogin({
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController
  }) {
    final _form = GlobalKey<FormState>();
    final progress = ProgressHUD.of(context);
    return Form(
        key:_form,
        child:Column(children: [
          TextFormField(
              controller:emailController,
              validator: (text) {
                if (!(text.contains('@')) && text.isNotEmpty) {
                  return "Enter a valid email address!";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Email",
                fillColor: secondaryColor,
                suffixIcon: Icon(FontAwesomeIcons.envelope),
                filled: true,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedErrorBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)
                ),
              )),
          SizedBox(
            height: 30,
          ),
          TextFormField(
              controller:passwordController,
              obscureText: _passwordObscured,
              validator: (text) {
                if(text.isEmpty){
                  return "Please enter a password";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Password",
                fillColor: secondaryColor,
                counterText: "Forgot Password?",
                suffixIcon: Container(
                  decoration:BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
                  color:Colors.white,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordObscured = !_passwordObscured;
                    });
                  },)),
                filled: true,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedErrorBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)
                ),
              )),
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: secondaryColor,
                    spreadRadius: 10,
                    blurRadius: 20,
                  )
                ]),
            child: ElevatedButton(
                onPressed: () async {
                  progress.show();
                  final database = Provider.of<AppDatabase>(context, listen: false);
                  database.loginUser(emailController.text, passwordController.text).then((value) => {
                    if(value.length ==0){
                      progress.dismiss(),
                      showAlert('invalid')
                    }else{
                      StoreProvider.of<AppState>(context).dispatch(UpdateUserNameAction(value[0].firstName+" "+value[0].lastName)),
                      StoreProvider.of<AppState>(context).dispatch(UpdateUserIdAction(value[0].id)),

                      progress.dismiss(),
                      Navigator.pushNamed(context,"/projects",arguments:value[0].firstName+" "+value[0].lastName)
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Sign In")),
                ),
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
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
        ])
    );
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

  showAlert(String data) {
    if(data == 'new') {
      AlertController.show("Account Created", "You can now login with your email and password.", TypeAlert.success);
    }
    if(data == 'invalid') {
      AlertController.show("Error","Invalid email or password.Try again.", TypeAlert.error);
    }
  }

}
