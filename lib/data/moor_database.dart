
import 'dart:async';
import 'dart:core';

import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;
import 'package:path/path.dart' as p;
import 'dart:io';
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
  IntColumn get organizationId => integer().customConstraint('REFERENCES Organizations(id)')();
}

class Projects extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectName => text().withLength(min:1,max:50)();
  DateTimeColumn get dateCreated => dateTime()();
  TextColumn get projectPath => text().withLength(min:1,max:50)();
  IntColumn get createdBy => integer().customConstraint('REFERENCES Users(id)')();
}

@DataClassName("FileCategory")
class FileCategories extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryName => text().withLength(min:1,max:50)();
  TextColumn get categoryIconPath => text().nullable().withLength(min:1,max:50)();
  IntColumn get categoryColor =>integer()();
}

class FileVersions extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer().customConstraint('REFERENCES ProjectFiles(id)')();
  IntColumn get fileVersion => integer()();
}

class ProjectFiles extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text().withLength(min:1,max:50)();
  TextColumn get filePath => text().withLength(min:1,max:50)();
  DateTimeColumn get dateAdded => dateTime()();
  IntColumn get latestVersion => integer()();
  IntColumn get fileCategory => integer().customConstraint('REFERENCES FileCategories(id)')();
  IntColumn get projectId => integer().customConstraint('REFERENCES Projects(id)')();
}
class FileWithCategory{
  FileWithCategory(this.file,this.category);
  final ProjectFile file;
  final FileCategory category;
}
@UseMoor(tables:[Organizations,Users,Projects,FileCategories,ProjectFiles,FileVersions])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(
      LazyDatabase(()async{
        final file = File('db.sqlite');
        return VmDatabase(file,logStatements: true);
      } )
  );
  @override
  int get schemaVersion => 1;

  Future insertUser(User user) => into(users).insert(user);
  Future updateUser(User user) => update(users).replace(user);
  Future insertOrganization(Organization organization) =>into(organizations).insert(organization);
  Future<List<Organization>> findOrganizationByName(String name){
    return (select(organizations)..where((a)=>a.organizationName.equals(name))).get();
  }

  Future insertProject(Project project) => into(projects).insert(project);
  Future<List<Project>> getProject(int id) {
    return (select(projects)..where((a)=>a.id.equals(id))).get();
  }

  Future<List<User>> loginUser(String email,String password) {
    return (select(users)..where((a)=>a.email.equals(email))..where((a)=>a.password.equals(password))).get();
  }

  Future<Project> getProjectInfo(int id){
    return (select(projects)..where((a)=>a.id.equals(id))).getSingle();
  }

  Future<List<Project>> getProjects() => (select(projects)..orderBy([(t) => OrderingTerm(expression: t.dateCreated,mode:OrderingMode.desc)])).get();

  Future<ProjectFile> getProjectFile(int id) => (select(projectFiles)..where((a) => a.id.equals(id))).getSingle();

  Future insertFile(ProjectFile file) => into(projectFiles).insert(file);

  Future updateFile(ProjectFile file) => update(projectFiles).replace(file);

  Future<List<FileWithCategory>> getProjectFiles(int id) async {
    final q = select(projectFiles).join([leftOuterJoin(fileCategories,fileCategories.id.equalsExp(projectFiles.fileCategory))]);
    q.where(projectFiles.projectId.equals(id));
    return q.map((row){
      return FileWithCategory(row.readTable(projectFiles),row.readTable(fileCategories));
    }).get();
  }

  Future<List<ProjectFile>> getProjectFilesByName(int projectId,String name){
    return (select(projectFiles)..where((a)=>a.projectId.equals(projectId))..where((a)=>a.fileName.equals(name))).get();
  }

  Future insertFileVersion(FileVersion version) => into(fileVersions).insert(version);

  Future addFileCategory(FileCategory category) => into(fileCategories).insert(category);

  Future<List<FileCategory>> getCategories(){
    return (select(fileCategories)).get();
  }
}