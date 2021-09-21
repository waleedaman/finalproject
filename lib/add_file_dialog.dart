import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';

class AddFileDialog extends StatefulWidget {
  final String title, descriptions;
  final Image img;
  final List<FileCategory> categories;
  const AddFileDialog({Key key, this.title, this.descriptions, this.categories, this.img}) : super(key: key);

  @override
  _AddFileDialogState createState() => _AddFileDialogState(categories:categories);
}

class _AddFileDialogState extends State<AddFileDialog> {

  final _form = GlobalKey<FormState>();
  var nameController = new TextEditingController();
  var pathController = new TextEditingController();
  var versionController = new TextEditingController();
  var categoryController = new TextEditingController();
  var _chosenValue = "";
  List<FileCategory> categories;

  _AddFileDialogState({this.categories});
  PlatformFile file;
  initState(){
    _chosenValue = categories.first.id.toString();
    file = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Categories: "+categories.toString());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
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
                            return "Enter File Name!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "File Name",
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
                            return "Select a File!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "File Path",
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
                                  FilePickerResult result = await FilePicker.platform.pickFiles();
                                  if(result != null){
                                    file = result.files.first;
                                    pathController.text = file.path;
                                  }
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
                    ),
                    SizedBox(height: 22,),
                    TextFormField(
                        controller:versionController,
                        validator: (text) {
                          if (!text.isNotEmpty) {
                            return "Enter file version!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: "File Version",
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
                    Container(
                        padding: EdgeInsets.symmetric(horizontal:defaultPadding),
                        decoration: BoxDecoration(
                          color:secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:DropdownButtonHideUnderline(
                            child:DropdownButton<String>(
                              focusColor:Colors.white,
                              value: _chosenValue,
                              //elevation: 5,
                              isExpanded: true,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor:Colors.black,
                              items: categories.map<DropdownMenuItem<String>>((FileCategory value) {
                                return DropdownMenuItem<String>(
                                  value: value.id.toString(),
                                  child: Text(value.categoryName,style:TextStyle(color:Colors.black),),
                                );
                              }).toList(),
                              hint:Text(
                                "Choose Category",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String value) {
                                print(value);
                                setState(() {
                                  _chosenValue = value;
                                });
                              },
                            )
                        )
                    ),
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
                        child: Center(child: Text("Add File")),
                      ),
                      onPressed: () async {
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        final database = Provider.of<AppDatabase>(context, listen: false);

                        File fi;
                        database.getProject(StoreProvider.of<AppState>(context).state.openProjectId).then((project)=>{
                          fi = File(pathController.text),
                          Directory(project[0].projectPath+"/"+nameController.text+"/"+versionController.text+"/").exists().then((val)=>{
                            if(!val){
                              Directory(project[0].projectPath+"/"+nameController.text+"/"+versionController.text+"/").create(recursive:true).then((val)=>{
                                fi.copy(project[0].projectPath+"/"+nameController.text+"/"+versionController.text+"/"+nameController.text+"."+file.extension).then((value) => {
                                  database.getProjectFilesByName(project[0].id, nameController.text).then((value) => {
                                    print(value.toString()),
                                    if(value.length == 0){
                                      database.insertFile(ProjectFile(
                                          fileName:nameController.text.toString(),
                                          filePath: project[0].projectPath+"/"+nameController.text+"/"+versionController.text+"/"+nameController.text+"."+file.extension,
                                          dateAdded: DateTime.now(),
                                          latestVersion:int.parse(versionController.text),
                                          projectId: StoreProvider.of<AppState>(context).state.openProjectId,
                                          fileCategory: int.parse(_chosenValue)
                                      )).then((value) =>
                                      {
                                        print("Val: "+value.toString()),
                                        database.insertFileVersion(FileVersion(
                                        fileId: value,
                                        fileVersion: int.parse(
                                        versionController.text))).then((
                                        value) => Navigator.pop(context,"Bar")),
                                      }),
                                    }else{
                                      database.updateFile(value[0].copyWith(
                                        latestVersion: int.parse(
                                            versionController.text),
                                        filePath: project[0].projectPath +
                                            "/" + nameController.text + "/" +
                                            versionController.text + "/" +
                                            nameController.text + "." +
                                            file.extension,
                                        dateAdded: DateTime.now(),)).then((val) =>database.insertFileVersion(FileVersion(
                                          fileId: value[0].id,
                                          fileVersion: int.parse(
                                              versionController.text))).then((
                                          value) => Navigator.pop(context,"Bar"))),
                                    }
                                  })
                                }),
                              })
                            }
                          }),
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