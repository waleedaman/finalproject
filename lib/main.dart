import 'package:DocumentManager/reducer.dart';
import 'package:DocumentManager/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'constants.dart';
import 'data/moor_database.dart';

void main() {
  final Store<AppState> _store = Store<AppState>(
      appStateReducer,
      initialState: AppState(mode: "",authMode:false,userName: "")
  );

  print('Initial state: ${_store.state}');
  runApp(
      StoreProvider(
          store: _store,
          child:MyApp()
      )
  );
}

class MyApp extends StatelessWidget {

  String _navPath = 'login';
  @override
  Widget build(BuildContext context) {

    return Provider(
        create: (BuildContext context) {
          return AppDatabase();
        },
        child:StoreConnector<AppState,String>(
            distinct: true,
            converter:(store)=>store.state.mode,
            builder:(context,mode)=>
                  MaterialApp(
                    theme: ThemeData.dark().copyWith(
                      scaffoldBackgroundColor: bgColor,
                      // primaryColor: Colors.purple,
                        textTheme: GoogleFonts.poppinsTextTheme(
                          Theme.of(context).textTheme,
                        ).apply(bodyColor: Colors.white,),
                        canvasColor: secondaryColor,
                    ),
                    debugShowCheckedModeBanner: false,
                    // home: LoginWindow(),
                    initialRoute: '/splash',
                    onGenerateRoute: RouteGenerator.generateRoute,
                  )
        )
    );
  }
}

