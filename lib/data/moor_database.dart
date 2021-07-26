import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';


part 'moor_database.g.dart';

class Organizations extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get organizationName => text().withLength(min:1,max:50)();
}

class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min:1,max:50)();
  TextColumn get lastName => text().withLength(min:1,max:50)();
  TextColumn get email => text().withLength(min:1,max:50)();
  TextColumn get password => text().withLength(min:1,max:50)();
  IntColumn get organizationId => integer().customConstraint('REFERENCES Organizations(_id)')();

  @override
  Set<Column> get primaryKey => {id,email};
}

class Projects extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectName => text().withLength(min:1,max:50)();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get createdBy => integer().customConstraint('REFERENCES Users(_id)')();
  // @override
  // Set<Column> get primaryKey => {id, projectName};
}

@UseMoor(tables:[Organizations,Users,Projects])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite',logStatements: true));
  @override
  int get schemaVersion => 1;

  Future insertUser(User user) => into(users).insert(user);
  Future updateUser(User user) => update(users).replace(user);
  Future<List<Organization>> findOrganizationByName(String name){
    return (select(organizations)..where((a)=>a.organizationName.equals(name))).get();
  }
}