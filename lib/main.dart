import 'package:finalproject/app_state.dart';
import 'package:finalproject/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:finalproject/reducer.dart';

void main() {
  final Store<AppState> _store = Store<AppState>(
      updateModeReducer,
      initialState: AppState(mode: "")
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

    return StoreConnector<AppState,String>(
        converter:(store)=>store.state.mode,
        builder:(context,mode)=>MaterialApp(
          theme: ThemeData(
            // primaryColor: Colors.purple,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )
          ),
          debugShowCheckedModeBanner: false,
          // home: LoginWindow(),
          initialRoute: '/splash',
          onGenerateRoute: RouteGenerator.generateRoute,
        )
    );
  }
}

