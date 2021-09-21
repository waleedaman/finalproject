import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_category_dialog.dart';
import 'add_file_dialog.dart';
import 'add_file_version_dialog.dart';
import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';

class OpenProjectWindow extends StatelessWidget {
  final borderColor = Color(0xff805306);

  String data;

  OpenProjectWindow({
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
              Expanded(child: OpenProject())
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

class OpenProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Sidebar()),
          Expanded(flex: 8, child: Body())
        ]);
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int ref = 0;

  refresh(){
    setState((){ref = ref + 1;});
  }

  @override
  Widget build(BuildContext context) {
    List<ProjectFile> files;
    return SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Container(
                        width: 150,
                        height: 50,
                        child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/addfile.png'),
                              Text("Add File")
                            ])),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        var database = Provider.of<AppDatabase>(
                            context, listen: false);
                        database.getCategories().then((value) {
                          if (value.length == 0) {
                            // database.addFileCategory(
                            //     FileCategory(
                            //     categoryName: "Uncategorized",
                            //     categoryIconPath: null,
                            //     categoryColor: primaryColor.value
                            // ));
                            List<FileCategory> cat = [];
                            print("Color: "+primaryColor.value.toString());
                            cat.add(FileCategory(
                                categoryName: "Uncategorized",
                                categoryIconPath: null,
                                categoryColor: primaryColor.value
                            ));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddFileDialog(
                                    title: "Add File",
                                    descriptions: "",
                                    categories: cat,
                                  );
                                }).then((value) => setState(()=>{
                              ref=ref+1
                            }));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddFileDialog(
                                    title: "Add File",
                                    descriptions: "",
                                    categories: value,
                                  );
                                }).then((value) => setState(()=>{
                              ref=ref+1
                            }));
                          }
                        });
                      },
                    ),
                  ]),
              SizedBox(height: defaultPadding),
              FutureBuilder<List<FileWithCategory>>(
                future: Provider.of<AppDatabase>(context, listen: false)
                    .getProjectFiles(StoreProvider
                    .of<AppState>(context)
                    .state
                    .openProjectId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<FileWithCategory>> snapshot) {
                  print("Files: " + snapshot.data.toString());
                  if (snapshot.data != null && snapshot.data.length == 0) {
                    return Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  height: 600,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(child: Text(
                                            "Project is Empty", style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6))
                                      ]
                                  )
                              )
                          ),
                          SizedBox(width: defaultPadding),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  height: 600,
                                  color: secondaryColor,
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Column(
                                      children: [
                                        Text("Project Information", style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        SizedBox(height: defaultPadding),
                                        FutureBuilder<Project>(
                                            future: Provider.of<AppDatabase>(
                                                context, listen: false)
                                                .getProjectInfo(StoreProvider
                                                .of<AppState>(context)
                                                .state
                                                .openProjectId),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                    Project> snapshot) {
                                              print("Project: " +
                                                  snapshot.data.toString());
                                              return Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Row(children: [
                                                      Text("Project Name: ",
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1),
                                                      Text(snapshot.data
                                                          .projectName,
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1)
                                                    ]),
                                                    SizedBox(
                                                        width: defaultPadding),
                                                    Row(children: [
                                                      Text("Created By: ",
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1),
                                                      Text(StoreProvider
                                                          .of<AppState>(context)
                                                          .state
                                                          .userName,
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle2)
                                                    ]),
                                                    SizedBox(
                                                        width: defaultPadding),
                                                    Row(children: [
                                                      Text(
                                                          "Path: ", style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .subtitle1),
                                                      Text(snapshot.data
                                                          .projectPath,
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1)
                                                    ]),
                                                    SizedBox(
                                                        width: defaultPadding),
                                                    Row(children: [
                                                      Text("Created On: ",
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1),
                                                      Text(snapshot.data
                                                          .dateCreated
                                                          .toString(),
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1)
                                                    ]),
                                                    SizedBox(
                                                        width: defaultPadding),
                                                  ]);
                                            })
                                      ]
                                  )
                              )
                          )
                        ]
                    );
                  } else
                  if (snapshot.data != null && snapshot.data.length > 0) {
                    return Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  height:600,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Expanded(child: Column(children: [
                                          CategoryCards(snapshot.data,context),
                                          SizedBox(width: defaultPadding),
                                          FilesTable(snapshot.data,context,refresh)
                                        ]))
                                      ]
                                  )
                              )
                          ),
                          SizedBox(width: defaultPadding),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  height: 600,
                                  color: secondaryColor,
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Column(
                                      children: [
                                        Text("Project Information", style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        SizedBox(height: defaultPadding),
                                        FutureBuilder<Project>(
                                            future: Provider.of<AppDatabase>(
                                                context, listen: false)
                                                .getProjectInfo(StoreProvider
                                                .of<AppState>(context)
                                                .state
                                                .openProjectId),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                    Project> snapshot) {
                                              print("Project: " +
                                                  snapshot.data.toString());
                                              return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width: double.infinity,
                                                        child: DataTable2(
                                                            columnSpacing: defaultPadding,
                                                            minWidth: 200,
                                                            columns: [
                                                              DataColumn(
                                                                label: Text(""),
                                                              ),
                                                              DataColumn(
                                                                label: Text(""),
                                                              ),
                                                            ], rows: [
                                                          DataRow(
                                                            cells: [
                                                              DataCell(Text("Name:",style:TextStyle(color:primaryColor,fontWeight:FontWeight.bold))),
                                                              DataCell(Text(snapshot.data.projectName)),
                                                            ],
                                                          ),
                                                          DataRow(
                                                            cells: [
                                                              DataCell(Text("Path",style:TextStyle(color:primaryColor,fontWeight:FontWeight.bold))),
                                                              DataCell(Text(snapshot.data.projectPath)),
                                                            ],
                                                          ),
                                                          DataRow(
                                                            cells: [
                                                              DataCell(Text("Created On",style:TextStyle(color:primaryColor,fontWeight:FontWeight.bold))),
                                                              DataCell(Text(snapshot.data.dateCreated.year.toString()+
                                                                  "-"+(snapshot.data.dateCreated.month < 10 ? "0"+snapshot.data.dateCreated.month.toString():snapshot.data.dateCreated.month.toString())+
                                                                  "-"+(snapshot.data.dateCreated.day < 10 ? "0"+snapshot.data.dateCreated.day.toString():snapshot.data.dateCreated.day.toString())+
                                                                  " "+(snapshot.data.dateCreated.hour < 10 ? "0"+snapshot.data.dateCreated.hour.toString():snapshot.data.dateCreated.hour.toString())+
                                                                  ":"+(snapshot.data.dateCreated.minute < 10 ? "0"+snapshot.data.dateCreated.minute.toString():snapshot.data.dateCreated.minute.toString()))),
                                                            ],
                                                          ),
                                                        ])
                                                    )]);
                                            })
                                      ])
                              )
                          )
                        ] ); } else {
                    return Text("Something is not right");
                  }
                },
              ),
            ])));
  }
}


class CategoryFileCount{
  CategoryFileCount(this.categoryName,this.fileCount,this.color,this.icon);
  String categoryName;
  int fileCount;
  Color color;
  String icon;
}
Widget CategoryCards(files,context){
  List<CategoryFileCount> categoryNames = [];
  int totalFiles = files.length;
  for(var file in files){
    if(categoryNames.isEmpty){
      categoryNames.add(CategoryFileCount(file.category.categoryName,1,Color(file.category.categoryColor),file.category.categoryIconPath));
    }else{
      if(categoryNames.indexWhere((element) => element.categoryName == file.category.categoryName) != -1 && categoryNames[categoryNames.indexWhere((element) => element.categoryName == file.category.categoryName)] != null ){
        categoryNames[categoryNames.indexWhere((element) => element.categoryName == file.category.categoryName)].fileCount++;
      }else{
        categoryNames.add(CategoryFileCount(file.category.categoryName,1,Color(file.category.categoryColor),file.category.categoryIconPath));
      }
    }
  }

  return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
          children: [
            GridView.builder(shrinkWrap: true,
              itemCount: categoryNames.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => FileInfoCard(info:categoryNames[index],total:totalFiles),)
          ]
      )
  );

}

Widget FilesTable(files,context,  final Function() notifyParent){
  return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
                width: double.infinity,
                height: 350,
                child: DataTable2(
                  columnSpacing: defaultPadding,
                  minWidth: 600,
                  bottomMargin: 10,
                  columns: [
                    DataColumn(
                      label: Text("File Name"),
                    ),
                    DataColumn(
                      label: Text("Category"),
                    ),
                    DataColumn(
                      label: Text("Version"),
                    ),
                    DataColumn(
                      label: Text("Path"),
                    ),
                    DataColumn(
                      label: Text("Actions"),
                    ),
                  ], rows: List.generate(
                  files.length,
                      (index) => recentFileDataRow(files[index],context,notifyParent),
                ),)
            )
          ])
  );
}

DataRow recentFileDataRow(FileWithCategory fileInfo,BuildContext context, final Function() notifyParent) {
  return DataRow(
    color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected))
        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
      return Colors.transparent;
    }),
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color(fileInfo.category.categoryColor).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                fileInfo.category.categoryIconPath == null ? "./assets/images/file.svg":fileInfo.category.categoryIconPath,
                color: Color(fileInfo.category.categoryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.file.fileName,style:TextStyle(
                  color: Color(fileInfo.category.categoryColor)
              )),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.category.categoryName)),
      DataCell(Text(fileInfo.file.latestVersion.toString())),
      DataCell(Text(fileInfo.file.filePath)),
      DataCell(Container(
          child:Row(children:[
            TextButton(
            onPressed:(){
              _launchURL(Uri(path:"/"+fileInfo.file.fileName+"/"+fileInfo.file.latestVersion.toString()+"/"),context);
            },
              child: Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(fileInfo.category.categoryColor).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "./assets/images/openin.svg",
                  color: Color(fileInfo.category.categoryColor),
                ),
              )
          ),
            TextButton(
                onPressed:(){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddFileVersionDialog(
                            id:fileInfo.file.id,
                            version:fileInfo.file.latestVersion
                        );
                      }).then((value) => notifyParent());
                },
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(fileInfo.category.categoryColor).withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    "./assets/images/addversion.svg",
                    color: Color(fileInfo.category.categoryColor),
                  ),
                )
            )
          ])
      )),

    ],
  );
}
void _launchURL(_url,context) async =>{
Provider.of<AppDatabase>(
context, listen: false)
    .getProjectInfo(StoreProvider
    .of<AppState>(context)
    .state
    .openProjectId).then((value){
     canLaunch("file://"+value.projectPath+_url.toString()).then((v) =>{
          print(v),
         launch("file://"+value.projectPath+_url.toString())
     }
     );
  })
};

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    this.info,
    this.total,
  }) : super(key: key);

  final CategoryFileCount info;
  final int total;

  @override
  Widget build(BuildContext context) {
    if(info.icon == null || info.icon == ""){
      info.icon = "./assets/images/file.svg";
    }
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  info.icon,
                  color: info.color,
                ),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Text(
            info.categoryName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          ProgressLine(
              color: info.color,
              percentage: info.fileCount,
              totalFiles:total
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.fileCount} Files",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
              Text(
                total.toString(),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = primaryColor,
    this.percentage,
    this.totalFiles
  }) : super(key: key);

  final Color color;
  final int percentage;
  final int totalFiles;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / totalFiles),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("Project Dashboard", style: Theme.of(context).textTheme.headline6),
      Spacer(),
      Row(children: [
        Text("Welcome "),
        Text(StoreProvider.of<AppState>(context).state.userName),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context,"/login");
            },
            child: Text("Logout")),
      ])
    ]);
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
          DrawerHeader(
              child: Column(children: [
                Image.asset('assets/images/logo.png', width: 55),
                Text("Document Manager",
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 24, color: Colors.grey))
              ])),
          DrawerListTile(
            title: "Add Category",
            svgSrc: 'assets/icons/category.png',
            press: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddCategoryDialog();
                  });
            },
          ),
          DrawerListTile(
            title: "Open Project Folder",
            svgSrc: 'assets/icons/openfolder.png',
            press: () {},
          ),
          DrawerListTile(
            title: "Close Project",
            svgSrc: 'assets/icons/close.png',
            press: () {Navigator.pop(context);},
          ),
          DrawerListTile(
            title: "Edit Project",
            svgSrc: 'assets/icons/edit.png',
            press: () {},
          ),
          DrawerListTile(
              title: "Delete Project",
              svgSrc: 'assets/icons/delete.png',
              press: () {},
              c: Colors.red[400]),
        ]));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.press,
    this.c,
  }) : super(key: key);

  final String title, svgSrc;
  final Color c;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading:
      Image.asset(svgSrc, width: 25, color: c == null ? Colors.white54 : c),
      title: Text(
        title,
        style: TextStyle(color: c == null ? Colors.white54 : c),
      ),
    );
  }
}
