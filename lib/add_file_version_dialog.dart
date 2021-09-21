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

class AddFileVersionDialog extends StatefulWidget {
  final int id;
  final int version;
  const AddFileVersionDialog({Key key, this.id,this.version}) : super(key: key);

  @override
  _AddFileVersionDialogState createState() => _AddFileVersionDialogState(id,version);
}

class _AddFileVersionDialogState extends State<AddFileVersionDialog> {

  final _form = GlobalKey<FormState>();
  var pathController = new TextEditingController();
  final int id;
  final int version;
  _AddFileVersionDialogState(this.id,this.version);
  var versionController;
  initState(){
    super.initState();
    versionController = new TextEditingController(text: (version+1).toString());
  }

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
  contentBox(context) {
    PlatformFile pickedFile = null;
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
              Text("Add File Version",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: defaultPadding,),
              Form(
                  key:_form,
                  child:Column(children: [
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
                                    pickedFile = result.files.first;
                                    pathController.text = pickedFile.path;
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
                    SizedBox(height: defaultPadding,),
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
                    SizedBox(height: defaultPadding,),
                  ])
              ),
              SizedBox(height: defaultPadding),
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
                        child: Center(child: Text("Add File Version")),
                      ),
                      onPressed: () async {
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        final database = Provider.of<AppDatabase>(context, listen: false);

                        File fi;
                        database.getProjectFile(id).then((ProjectFile file)=>{
                          fi = File(pathController.text),
                          database.getProject(file.projectId).then((project)=>{
                            Directory(project[0].projectPath+"/"+file.fileName+"/"+versionController.text+"/").exists().then((val)=>{
                              if(!val){
                                Directory(project[0].projectPath+"/"+file.fileName+"/"+versionController.text+"/").create(recursive:true).then((val)=>{
                                  fi.copy(project[0].projectPath+"/"+file.fileName+"/"+versionController.text+"/"+file.fileName+"."+pickedFile.extension).then((value) => {
                                        database.updateFile(file.copyWith(
                                          latestVersion: int.parse(
                                              versionController.text),
                                          filePath: project[0].projectPath +
                                              "/" + file.fileName + "/" +
                                              versionController.text + "/" +
                                              file.fileName + "." +
                                              pickedFile.extension,
                                          dateAdded: DateTime.now(),)).then((val) =>database.insertFileVersion(FileVersion(
                                            fileId: file.id,
                                            fileVersion: int.parse(
                                                versionController.text))).then((
                                            value) => Navigator.pop(context,"Bar"))),
                                  }),
                                })
                              }
                            }),
                          })
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