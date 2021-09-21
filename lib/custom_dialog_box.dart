import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'actions.dart';
import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    final _form = GlobalKey<FormState>();
    var nameController = new TextEditingController();
    var pathController = new TextEditingController();

    return Stack(
      children: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: bgColor,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Form(
                  key:_form,
                  child:Column(children: [
                    TextFormField(
                        controller:nameController,
                        validator: (text) {
                          if (!text.isNotEmpty) {
                            return "Enter a Project Name!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Project Name",
                          fillColor: secondaryColor,
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
                        )
                    ),
                    SizedBox(height: 22,),
                    TextFormField(
                        controller:pathController,
                        validator: (text) {
                          if (!text.isNotEmpty) {
                            return "Select a Project Folder!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Project Folder",
                          fillColor: secondaryColor,
                          suffixIcon:  Container(
                            decoration:BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child:IconButton(
                            icon: Icon(
                              Icons.folder,
                                color:Colors.white,
                            ),
                            onPressed: () async {
                              Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
                              String result = await FilePicker.platform.getDirectoryPath();
                              pathController.text = result.replaceAll("\\", "/");
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
                        )
                    )
                  ])
              ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      ),
                  child: ElevatedButton(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Center(child: Text("Create Project")),
                      ),
                      onPressed: () async {
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        final database = Provider.of<AppDatabase>(context, listen: false);
                        int userId = StoreProvider.of<AppState>(context).state.userId;
                        DateTime createdOn = DateTime.now();
                        Project proj = new Project(
                            projectName:nameController.text.toString(),
                            projectPath:pathController.text.toString(),
                            createdBy:userId,
                            dateCreated:createdOn);
                        database.insertProject(proj).then((value)=>{
                          StoreProvider.of<AppState>(context).dispatch(UpdateOpenProjectIdAction(value)),
                          Navigator.pushNamed(context, "/OpenProject")
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/logo.png")
            ),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}