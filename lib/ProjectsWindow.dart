import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import 'actions.dart';
import 'app_state.dart';
import 'constants.dart';
import 'custom_dialog_box.dart';
import 'data/moor_database.dart';

class ProjectsScreen extends StatelessWidget {
  final borderColor = Color(0xff805306);

  String data;

  ProjectsScreen({
    this.data,
  }) : super();

  @override
  Widget build(BuildContext context) {
    print("Username: " + StoreProvider.of<AppState>(context).state.userName);
    return ProgressHUD(
        child: Scaffold(
      // backgroundColor:Color(0x00050505),
      body: WindowBorder(
          width: 1,
          color: borderColor,
          child: Row(
            children: [
              Window(data: data),
            ],
          )),
    ));
  }
}

class Window extends StatefulWidget {
  String data;
  Window({this.data});
  @override
  _WindowState createState() => _WindowState(data: data);
}

class _WindowState extends State<Window> {
  String data;
  List<Project> projectList = [];
  _WindowState({this.data});
  initState() {
    super.initState();
    final database = Provider.of<AppDatabase>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // StoreProvider.of<AppState>(context).dispatch(UpdateUserNameAction(value[0].firstName+" "+value[0].lastName)),
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
      ProjectsWindow(projectList: projectList)
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

class ProjectsWindow extends StatelessWidget {
  List<Project> projectList;
  ProjectsWindow({this.projectList});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: [Menu(), Body(projectList: projectList)]));
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _logo(title: 'Document Manager', logoSrc: 'assets/images/logo.png'),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text("Welcome "),
          Text(StoreProvider.of<AppState>(context).state.userName),
          TextButton(
              onPressed: () {
                print("clicked");
              },
              child: Text("Logout")),
        ])
      ]),
    );
  }
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
                fontWeight: FontWeight.w900, fontSize: 24, color: Colors.grey))
      ]));
}

class Body extends StatelessWidget {
  List<Project> projectList;
  Body({this.projectList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Expanded(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sidebar(),
                  ])),
          Container(
              width: 450,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                ProjectList(projectList: projectList),
              ]))
        ]),
      ),
    );
  }
}

class ProjectList extends StatelessWidget {
  List<Project> projectList;
  ProjectList({this.projectList});
  @override
  Widget build(BuildContext context) {
    // List<Widget> c = projectList.map((e){
    //   return Expanded(child: Container(child: Text(e.toString()),));
    // }).toList();
    return FutureBuilder<List<Project>>(
        future: Provider.of<AppDatabase>(context, listen: false).getProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
          List<Widget> c=[];
          if (snapshot.data==null) {
          } else {
            c = snapshot.data.map((e) {
              return ListTile(
                  title: Row(children: <Widget>[
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    print(e.id.toString());
                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateOpenProjectIdAction(e.id));
                    Navigator.pushNamed(context, "/OpenProject");
                  },
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(e.projectName.toString(),
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left)),
                )),
                Expanded(child: Text(e.dateCreated.toLocal().toString())),
              ]));
            }).toList();
          }
          return Column(children: [
            Container(
              child: Text("Recent Projects"),
            ),
            ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ListTile(
                      title: Row(children: <Widget>[
                    Expanded(child: Text("Project")),
                    Expanded(child: Text("Created On")),
                  ])),
                  ...c
                ])
          ]);
        });
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("New Project")),
            ),
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "Create Project",
                      descriptions: "",
                      text: "Yes",
                    );
                  });
            },
          )),
      SizedBox(
        height: 50,
      ),
      Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("Open Project")),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
          )),
    ]);
  }
}
