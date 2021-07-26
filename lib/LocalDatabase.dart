import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // static final _dbName = 'local.db';
  // static final _dbVersion = 1;
  // LocalDatabase._privateConstructor();
  // static final LocalDatabase instance = new LocalDatabase._privateConstructor();
  // static Database _database;
  //
  //
  // Future<Database> get database async{
  //   if(_database != null) return _database;
  //   _database = await _initDatabase();
  //   return _database;
  // }
  //
  // _initDatabase() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path,_dbName);
  //   return await openDatabase(path,version: _dbVersion,onCreate:_onCreate);
  // }
  //
  // Future _onCreate(Database db,int version){
  //   db.execute(
  //       '''
  //       CREATE TABLE IF NOT EXISTS Users (
  //       _id INTEGER PRIMARY KEY,
  //       firstName TEXT NOT NULL,
  //       lastName TEXT NOT NULL,
  //       email TEXT NOT NULL,
  //       password TEXT NOT NULL,
  //       organizationId TEXT,
  //       )
  //       '''
  //   );
  //   db.execute(
  //       '''
  //       CREATE TABLE IF NOT EXISTS Projects (
  //       _id INTEGER PRIMARY KEY,
  //       projectName TEXT NOT NULL,
  //       dateCreated TEXT NOT NULL,
  //       createdBy INTEGER NOT NULL,
  //       FOREIGN KEY(createdBy) REFERENCES Users(_id)
  //       )
  //       '''
  //   );
  // }
  //
  // Future<int> insert(String _tableName,Map<String,dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(_tableName,row);
  // }
  //
  // Future<int> update(String _tableName,Map<String,dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.update(_tableName,row,where:'_id = ?',whereArgs:[row['_id']]);
  // }
  //
  // Future<List<Map<String,dynamic>>> queryAll(String _tableName) async {
  //   Database db = await instance.database;
  //   return db.query(_tableName);
  // }
  //
  // Future <List<Map<String,dynamic>>> getById(String _tableName,int id) async {
  //   Database db = await instance.database;
  //   return await db.query(_tableName,where:'_id = ?',whereArgs:[id]);
  // }
  //
  // Future <List<Map<String,dynamic>>> getByColumn(String _tableName,String columnName,dynamic value) async {
  //   Database db = await instance.database;
  //   return await db.query(_tableName,where:'$columnName = ?',whereArgs:[value]);
  // }
  //
  // Future<int> delete(String _tableName,int id) async {
  //   Database db = await instance.database;
  //   return db.delete(_tableName,where:'_id = ?',whereArgs:[id]);
  // }

}
//
// class User{
//   String firstName;
//   String lastName;
//   String email;
//   String password;
//   String organizationId;
//
//   User({this.firstName,this.lastName,this.email,this.password,this.organizationId});
//
//   Future<String> createAccount(String database) async{
//     if(firstName != null && lastName != null && email != null && password != null){
//       if(database == 'sqlite'){
//         // int id = await LocalDatabase.instance.insert('Users', {
//         //   'firstName':firstName,
//         //   'lastName':lastName,
//         //   'email':email,
//         //   'password':password,
//         //   'organizationId':organizationId
//         // });
//         // if(id != -1)return "User added";
//         return "Database error";
//       }
//       return "Invalid database type";
//     }
//     return "User data not complete";
//   }
//
//
//
// }