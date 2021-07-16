import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  void openDatabase() async {
    var db = await openDatabase('my_db.db');
  }
}

class User{



  void createUser(String firstName,String lastName,String email,String password,String organizationId){

  }
}