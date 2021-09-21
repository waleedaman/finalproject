import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';

class AddCategoryDialog extends StatefulWidget {

  const AddCategoryDialog();

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {

  final _form = GlobalKey<FormState>();
  var nameController = new TextEditingController();
  var iconPathController = new TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = null;

  String iconName;
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  _AddCategoryDialogState();

  initState(){
    super.initState();
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
              Text("Add Category",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: defaultPadding,),
              Form(
                  key:_form,
                  child:Column(children: [
                    TextFormField(
                        controller:nameController,
                        validator: (text) {
                          if (!text.isNotEmpty) {
                            return "Enter Category Name!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Category Name",
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
                    TextFormField(
                        controller:iconPathController,
                        validator: (text) {
                          if (!text.isNotEmpty) {
                            return "Select Category Icon!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Category Icon",
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
                                  FilePickerResult result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['svg'],
                                  );
                                  if(result != null){
                                    iconPathController.text = result.files.first.path;
                                    iconName = result.files.first.name+"."+result.files.first.extension;
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
                    Row(children:[
                      Container(
                        height:30,
                        width: 30,
                        decoration:BoxDecoration(
                          color:currentColor == null ? primaryColor : currentColor,
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      SizedBox(width:defaultPadding),
                      ElevatedButton(
                        child: Text("Pick Color"),
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: pickerColor,
                                      onColorChanged: changeColor,
                                      showLabel: true,
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                    // Use Material color picker:
                                    //
                                    // child: MaterialPicker(
                                    //   pickerColor: pickerColor,
                                    //   onColorChanged: changeColor,
                                    //   showLabel: true, // only on portrait mode
                                    // ),
                                    //
                                    // Use Block color picker:
                                    //
                                    // child: BlockPicker(
                                    //   pickerColor: currentColor,
                                    //   onColorChanged: changeColor,
                                    // ),
                                    //
                                    // child: MultipleChoiceBlockPicker(
                                    //   pickerColors: currentColors,
                                    //   onColorsChanged: changeColors,
                                    // ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(() => currentColor = pickerColor);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                    )],)
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
                        child: Center(child: Text("Add Category")),
                      ),
                      onPressed: () async {
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        final database = Provider.of<AppDatabase>(context, listen: false);
                        File fi;
                        fi = File(iconPathController.text);
                          Directory("./assets/images/").exists().then((val)=>{
                            if(!val){
                              Directory("./assets/images/").create(recursive:true).then((val)=>{
                                fi.copy("./assets/images/"+iconName).then((value) => {
                                  database.addFileCategory(FileCategory(
                                    categoryColor:currentColor == null ? primaryColor.value : currentColor.value,
                                    categoryName:nameController.text,
                                    categoryIconPath: "./assets/images/"+iconName
                                  ))
                                }),
                              })
                            }else{
                              fi.copy("./assets/images/"+iconName),
                              database.addFileCategory(FileCategory(
                                  categoryColor:currentColor == null ? primaryColor.value : currentColor.value,
                                  categoryName:nameController.text,
                                  categoryIconPath: "./assets/images/"+iconName
                              ))
                            }
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
