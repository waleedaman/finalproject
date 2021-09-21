// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Organization extends DataClass implements Insertable<Organization> {
  final int id;
  final String organizationName;
  Organization({@required this.id, @required this.organizationName});
  factory Organization.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Organization(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      organizationName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}organization_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || organizationName != null) {
      map['organization_name'] = Variable<String>(organizationName);
    }
    return map;
  }

  OrganizationsCompanion toCompanion(bool nullToAbsent) {
    return OrganizationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      organizationName: organizationName == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationName),
    );
  }

  factory Organization.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Organization(
      id: serializer.fromJson<int>(json['id']),
      organizationName: serializer.fromJson<String>(json['organizationName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'organizationName': serializer.toJson<String>(organizationName),
    };
  }

  Organization copyWith({int id, String organizationName}) => Organization(
        id: id ?? this.id,
        organizationName: organizationName ?? this.organizationName,
      );
  @override
  String toString() {
    return (StringBuffer('Organization(')
          ..write('id: $id, ')
          ..write('organizationName: $organizationName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, organizationName.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Organization &&
          other.id == this.id &&
          other.organizationName == this.organizationName);
}

class OrganizationsCompanion extends UpdateCompanion<Organization> {
  final Value<int> id;
  final Value<String> organizationName;
  const OrganizationsCompanion({
    this.id = const Value.absent(),
    this.organizationName = const Value.absent(),
  });
  OrganizationsCompanion.insert({
    this.id = const Value.absent(),
    @required String organizationName,
  }) : organizationName = Value(organizationName);
  static Insertable<Organization> custom({
    Expression<int> id,
    Expression<String> organizationName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationName != null) 'organization_name': organizationName,
    });
  }

  OrganizationsCompanion copyWith(
      {Value<int> id, Value<String> organizationName}) {
    return OrganizationsCompanion(
      id: id ?? this.id,
      organizationName: organizationName ?? this.organizationName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (organizationName.present) {
      map['organization_name'] = Variable<String>(organizationName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationsCompanion(')
          ..write('id: $id, ')
          ..write('organizationName: $organizationName')
          ..write(')'))
        .toString();
  }
}

class $OrganizationsTable extends Organizations
    with TableInfo<$OrganizationsTable, Organization> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrganizationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _organizationNameMeta =
      const VerificationMeta('organizationName');
  GeneratedColumn<String> _organizationName;
  @override
  GeneratedColumn<String> get organizationName => _organizationName ??=
      GeneratedColumn<String>('organization_name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, organizationName];
  @override
  String get aliasedName => _alias ?? 'organizations';
  @override
  String get actualTableName => 'organizations';
  @override
  VerificationContext validateIntegrity(Insertable<Organization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('organization_name')) {
      context.handle(
          _organizationNameMeta,
          organizationName.isAcceptableOrUnknown(
              data['organization_name'], _organizationNameMeta));
    } else if (isInserting) {
      context.missing(_organizationNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Organization map(Map<String, dynamic> data, {String tablePrefix}) {
    return Organization.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrganizationsTable createAlias(String alias) {
    return $OrganizationsTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int organizationId;
  User(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.password,
      @required this.organizationId});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      organizationId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}organization_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || organizationId != null) {
      map['organization_id'] = Variable<int>(organizationId);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      organizationId: organizationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationId),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      organizationId: serializer.fromJson<int>(json['organizationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'organizationId': serializer.toJson<int>(organizationId),
    };
  }

  User copyWith(
          {int id,
          String firstName,
          String lastName,
          String email,
          String password,
          int organizationId}) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        organizationId: organizationId ?? this.organizationId,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('organizationId: $organizationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          firstName.hashCode,
          $mrjc(
              lastName.hashCode,
              $mrjc(email.hashCode,
                  $mrjc(password.hashCode, organizationId.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.password == this.password &&
          other.organizationId == this.organizationId);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> password;
  final Value<int> organizationId;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.organizationId = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required int organizationId,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        password = Value(password),
        organizationId = Value(organizationId);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> firstName,
    Expression<String> lastName,
    Expression<String> email,
    Expression<String> password,
    Expression<int> organizationId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (organizationId != null) 'organization_id': organizationId,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<String> password,
      Value<int> organizationId}) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<int>(organizationId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('organizationId: $organizationId')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedColumn<String> _firstName;
  @override
  GeneratedColumn<String> get firstName =>
      _firstName ??= GeneratedColumn<String>('first_name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedColumn<String> _lastName;
  @override
  GeneratedColumn<String> get lastName => _lastName ??= GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedColumn<String> _email;
  @override
  GeneratedColumn<String> get email => _email ??= GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedColumn<String> _password;
  @override
  GeneratedColumn<String> get password => _password ??= GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _organizationIdMeta =
      const VerificationMeta('organizationId');
  GeneratedColumn<int> _organizationId;
  @override
  GeneratedColumn<int> get organizationId => _organizationId ??=
      GeneratedColumn<int>('organization_id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: true,
          $customConstraints: 'REFERENCES Organizations(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, email, password, organizationId];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name'], _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name'], _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta,
          organizationId.isAcceptableOrUnknown(
              data['organization_id'], _organizationIdMeta));
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    return User.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final String projectName;
  final DateTime dateCreated;
  final String projectPath;
  final int createdBy;
  Project(
      {@required this.id,
      @required this.projectName,
      @required this.dateCreated,
      @required this.projectPath,
      @required this.createdBy});
  factory Project.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Project(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      projectName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}project_name']),
      dateCreated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
      projectPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}project_path']),
      createdBy: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || projectName != null) {
      map['project_name'] = Variable<String>(projectName);
    }
    if (!nullToAbsent || dateCreated != null) {
      map['date_created'] = Variable<DateTime>(dateCreated);
    }
    if (!nullToAbsent || projectPath != null) {
      map['project_path'] = Variable<String>(projectPath);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<int>(createdBy);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
      projectPath: projectPath == null && nullToAbsent
          ? const Value.absent()
          : Value(projectPath),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      projectName: serializer.fromJson<String>(json['projectName']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      projectPath: serializer.fromJson<String>(json['projectPath']),
      createdBy: serializer.fromJson<int>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectName': serializer.toJson<String>(projectName),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'projectPath': serializer.toJson<String>(projectPath),
      'createdBy': serializer.toJson<int>(createdBy),
    };
  }

  Project copyWith(
          {int id,
          String projectName,
          DateTime dateCreated,
          String projectPath,
          int createdBy}) =>
      Project(
        id: id ?? this.id,
        projectName: projectName ?? this.projectName,
        dateCreated: dateCreated ?? this.dateCreated,
        projectPath: projectPath ?? this.projectPath,
        createdBy: createdBy ?? this.createdBy,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('projectName: $projectName, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('projectPath: $projectPath, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          projectName.hashCode,
          $mrjc(dateCreated.hashCode,
              $mrjc(projectPath.hashCode, createdBy.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.projectName == this.projectName &&
          other.dateCreated == this.dateCreated &&
          other.projectPath == this.projectPath &&
          other.createdBy == this.createdBy);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<String> projectName;
  final Value<DateTime> dateCreated;
  final Value<String> projectPath;
  final Value<int> createdBy;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.projectName = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.projectPath = const Value.absent(),
    this.createdBy = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    @required String projectName,
    @required DateTime dateCreated,
    @required String projectPath,
    @required int createdBy,
  })  : projectName = Value(projectName),
        dateCreated = Value(dateCreated),
        projectPath = Value(projectPath),
        createdBy = Value(createdBy);
  static Insertable<Project> custom({
    Expression<int> id,
    Expression<String> projectName,
    Expression<DateTime> dateCreated,
    Expression<String> projectPath,
    Expression<int> createdBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectName != null) 'project_name': projectName,
      if (dateCreated != null) 'date_created': dateCreated,
      if (projectPath != null) 'project_path': projectPath,
      if (createdBy != null) 'created_by': createdBy,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int> id,
      Value<String> projectName,
      Value<DateTime> dateCreated,
      Value<String> projectPath,
      Value<int> createdBy}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      projectName: projectName ?? this.projectName,
      dateCreated: dateCreated ?? this.dateCreated,
      projectPath: projectPath ?? this.projectPath,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (projectPath.present) {
      map['project_path'] = Variable<String>(projectPath.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('projectName: $projectName, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('projectPath: $projectPath, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProjectsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  GeneratedColumn<String> _projectName;
  @override
  GeneratedColumn<String> get projectName => _projectName ??=
      GeneratedColumn<String>('project_name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  GeneratedColumn<DateTime> _dateCreated;
  @override
  GeneratedColumn<DateTime> get dateCreated => _dateCreated ??=
      GeneratedColumn<DateTime>('date_created', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _projectPathMeta =
      const VerificationMeta('projectPath');
  GeneratedColumn<String> _projectPath;
  @override
  GeneratedColumn<String> get projectPath => _projectPath ??=
      GeneratedColumn<String>('project_path', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedColumn<int> _createdBy;
  @override
  GeneratedColumn<int> get createdBy =>
      _createdBy ??= GeneratedColumn<int>('created_by', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: true,
          $customConstraints: 'REFERENCES Users(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectName, dateCreated, projectPath, createdBy];
  @override
  String get aliasedName => _alias ?? 'projects';
  @override
  String get actualTableName => 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('project_name')) {
      context.handle(
          _projectNameMeta,
          projectName.isAcceptableOrUnknown(
              data['project_name'], _projectNameMeta));
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created'], _dateCreatedMeta));
    } else if (isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (data.containsKey('project_path')) {
      context.handle(
          _projectPathMeta,
          projectPath.isAcceptableOrUnknown(
              data['project_path'], _projectPathMeta));
    } else if (isInserting) {
      context.missing(_projectPathMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String tablePrefix}) {
    return Project.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(_db, alias);
  }
}

class FileCategory extends DataClass implements Insertable<FileCategory> {
  final int id;
  final String categoryName;
  final String categoryIconPath;
  final int categoryColor;
  FileCategory(
      {@required this.id,
      @required this.categoryName,
      this.categoryIconPath,
      @required this.categoryColor});
  factory FileCategory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return FileCategory(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      categoryName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_name']),
      categoryIconPath: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}category_icon_path']),
      categoryColor: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    if (!nullToAbsent || categoryIconPath != null) {
      map['category_icon_path'] = Variable<String>(categoryIconPath);
    }
    if (!nullToAbsent || categoryColor != null) {
      map['category_color'] = Variable<int>(categoryColor);
    }
    return map;
  }

  FileCategoriesCompanion toCompanion(bool nullToAbsent) {
    return FileCategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      categoryIconPath: categoryIconPath == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryIconPath),
      categoryColor: categoryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryColor),
    );
  }

  factory FileCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FileCategory(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      categoryIconPath: serializer.fromJson<String>(json['categoryIconPath']),
      categoryColor: serializer.fromJson<int>(json['categoryColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
      'categoryIconPath': serializer.toJson<String>(categoryIconPath),
      'categoryColor': serializer.toJson<int>(categoryColor),
    };
  }

  FileCategory copyWith(
          {int id,
          String categoryName,
          String categoryIconPath,
          int categoryColor}) =>
      FileCategory(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        categoryIconPath: categoryIconPath ?? this.categoryIconPath,
        categoryColor: categoryColor ?? this.categoryColor,
      );
  @override
  String toString() {
    return (StringBuffer('FileCategory(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryIconPath: $categoryIconPath, ')
          ..write('categoryColor: $categoryColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(categoryName.hashCode,
          $mrjc(categoryIconPath.hashCode, categoryColor.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileCategory &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.categoryIconPath == this.categoryIconPath &&
          other.categoryColor == this.categoryColor);
}

class FileCategoriesCompanion extends UpdateCompanion<FileCategory> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<String> categoryIconPath;
  final Value<int> categoryColor;
  const FileCategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryIconPath = const Value.absent(),
    this.categoryColor = const Value.absent(),
  });
  FileCategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String categoryName,
    this.categoryIconPath = const Value.absent(),
    @required int categoryColor,
  })  : categoryName = Value(categoryName),
        categoryColor = Value(categoryColor);
  static Insertable<FileCategory> custom({
    Expression<int> id,
    Expression<String> categoryName,
    Expression<String> categoryIconPath,
    Expression<int> categoryColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryIconPath != null) 'category_icon_path': categoryIconPath,
      if (categoryColor != null) 'category_color': categoryColor,
    });
  }

  FileCategoriesCompanion copyWith(
      {Value<int> id,
      Value<String> categoryName,
      Value<String> categoryIconPath,
      Value<int> categoryColor}) {
    return FileCategoriesCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categoryIconPath: categoryIconPath ?? this.categoryIconPath,
      categoryColor: categoryColor ?? this.categoryColor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryIconPath.present) {
      map['category_icon_path'] = Variable<String>(categoryIconPath.value);
    }
    if (categoryColor.present) {
      map['category_color'] = Variable<int>(categoryColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryIconPath: $categoryIconPath, ')
          ..write('categoryColor: $categoryColor')
          ..write(')'))
        .toString();
  }
}

class $FileCategoriesTable extends FileCategories
    with TableInfo<$FileCategoriesTable, FileCategory> {
  final GeneratedDatabase _db;
  final String _alias;
  $FileCategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  GeneratedColumn<String> _categoryName;
  @override
  GeneratedColumn<String> get categoryName => _categoryName ??=
      GeneratedColumn<String>('category_name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _categoryIconPathMeta =
      const VerificationMeta('categoryIconPath');
  GeneratedColumn<String> _categoryIconPath;
  @override
  GeneratedColumn<String> get categoryIconPath => _categoryIconPath ??=
      GeneratedColumn<String>('category_icon_path', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: false);
  final VerificationMeta _categoryColorMeta =
      const VerificationMeta('categoryColor');
  GeneratedColumn<int> _categoryColor;
  @override
  GeneratedColumn<int> get categoryColor => _categoryColor ??=
      GeneratedColumn<int>('category_color', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryName, categoryIconPath, categoryColor];
  @override
  String get aliasedName => _alias ?? 'file_categories';
  @override
  String get actualTableName => 'file_categories';
  @override
  VerificationContext validateIntegrity(Insertable<FileCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name'], _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_icon_path')) {
      context.handle(
          _categoryIconPathMeta,
          categoryIconPath.isAcceptableOrUnknown(
              data['category_icon_path'], _categoryIconPathMeta));
    }
    if (data.containsKey('category_color')) {
      context.handle(
          _categoryColorMeta,
          categoryColor.isAcceptableOrUnknown(
              data['category_color'], _categoryColorMeta));
    } else if (isInserting) {
      context.missing(_categoryColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileCategory map(Map<String, dynamic> data, {String tablePrefix}) {
    return FileCategory.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FileCategoriesTable createAlias(String alias) {
    return $FileCategoriesTable(_db, alias);
  }
}

class ProjectFile extends DataClass implements Insertable<ProjectFile> {
  final int id;
  final String fileName;
  final String filePath;
  final DateTime dateAdded;
  final int latestVersion;
  final int fileCategory;
  final int projectId;
  ProjectFile(
      {@required this.id,
      @required this.fileName,
      @required this.filePath,
      @required this.dateAdded,
      @required this.latestVersion,
      @required this.fileCategory,
      @required this.projectId});
  factory ProjectFile.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProjectFile(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fileName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}file_name']),
      filePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}file_path']),
      dateAdded: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_added']),
      latestVersion: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latest_version']),
      fileCategory: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}file_category']),
      projectId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}project_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || dateAdded != null) {
      map['date_added'] = Variable<DateTime>(dateAdded);
    }
    if (!nullToAbsent || latestVersion != null) {
      map['latest_version'] = Variable<int>(latestVersion);
    }
    if (!nullToAbsent || fileCategory != null) {
      map['file_category'] = Variable<int>(fileCategory);
    }
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    return map;
  }

  ProjectFilesCompanion toCompanion(bool nullToAbsent) {
    return ProjectFilesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      dateAdded: dateAdded == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAdded),
      latestVersion: latestVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(latestVersion),
      fileCategory: fileCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(fileCategory),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
    );
  }

  factory ProjectFile.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProjectFile(
      id: serializer.fromJson<int>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
      latestVersion: serializer.fromJson<int>(json['latestVersion']),
      fileCategory: serializer.fromJson<int>(json['fileCategory']),
      projectId: serializer.fromJson<int>(json['projectId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
      'latestVersion': serializer.toJson<int>(latestVersion),
      'fileCategory': serializer.toJson<int>(fileCategory),
      'projectId': serializer.toJson<int>(projectId),
    };
  }

  ProjectFile copyWith(
          {int id,
          String fileName,
          String filePath,
          DateTime dateAdded,
          int latestVersion,
          int fileCategory,
          int projectId}) =>
      ProjectFile(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        dateAdded: dateAdded ?? this.dateAdded,
        latestVersion: latestVersion ?? this.latestVersion,
        fileCategory: fileCategory ?? this.fileCategory,
        projectId: projectId ?? this.projectId,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectFile(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('latestVersion: $latestVersion, ')
          ..write('fileCategory: $fileCategory, ')
          ..write('projectId: $projectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fileName.hashCode,
          $mrjc(
              filePath.hashCode,
              $mrjc(
                  dateAdded.hashCode,
                  $mrjc(latestVersion.hashCode,
                      $mrjc(fileCategory.hashCode, projectId.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectFile &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.dateAdded == this.dateAdded &&
          other.latestVersion == this.latestVersion &&
          other.fileCategory == this.fileCategory &&
          other.projectId == this.projectId);
}

class ProjectFilesCompanion extends UpdateCompanion<ProjectFile> {
  final Value<int> id;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<DateTime> dateAdded;
  final Value<int> latestVersion;
  final Value<int> fileCategory;
  final Value<int> projectId;
  const ProjectFilesCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.latestVersion = const Value.absent(),
    this.fileCategory = const Value.absent(),
    this.projectId = const Value.absent(),
  });
  ProjectFilesCompanion.insert({
    this.id = const Value.absent(),
    @required String fileName,
    @required String filePath,
    @required DateTime dateAdded,
    @required int latestVersion,
    @required int fileCategory,
    @required int projectId,
  })  : fileName = Value(fileName),
        filePath = Value(filePath),
        dateAdded = Value(dateAdded),
        latestVersion = Value(latestVersion),
        fileCategory = Value(fileCategory),
        projectId = Value(projectId);
  static Insertable<ProjectFile> custom({
    Expression<int> id,
    Expression<String> fileName,
    Expression<String> filePath,
    Expression<DateTime> dateAdded,
    Expression<int> latestVersion,
    Expression<int> fileCategory,
    Expression<int> projectId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (dateAdded != null) 'date_added': dateAdded,
      if (latestVersion != null) 'latest_version': latestVersion,
      if (fileCategory != null) 'file_category': fileCategory,
      if (projectId != null) 'project_id': projectId,
    });
  }

  ProjectFilesCompanion copyWith(
      {Value<int> id,
      Value<String> fileName,
      Value<String> filePath,
      Value<DateTime> dateAdded,
      Value<int> latestVersion,
      Value<int> fileCategory,
      Value<int> projectId}) {
    return ProjectFilesCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      dateAdded: dateAdded ?? this.dateAdded,
      latestVersion: latestVersion ?? this.latestVersion,
      fileCategory: fileCategory ?? this.fileCategory,
      projectId: projectId ?? this.projectId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (latestVersion.present) {
      map['latest_version'] = Variable<int>(latestVersion.value);
    }
    if (fileCategory.present) {
      map['file_category'] = Variable<int>(fileCategory.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectFilesCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('latestVersion: $latestVersion, ')
          ..write('fileCategory: $fileCategory, ')
          ..write('projectId: $projectId')
          ..write(')'))
        .toString();
  }
}

class $ProjectFilesTable extends ProjectFiles
    with TableInfo<$ProjectFilesTable, ProjectFile> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProjectFilesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _fileNameMeta = const VerificationMeta('fileName');
  GeneratedColumn<String> _fileName;
  @override
  GeneratedColumn<String> get fileName => _fileName ??= GeneratedColumn<String>(
      'file_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _filePathMeta = const VerificationMeta('filePath');
  GeneratedColumn<String> _filePath;
  @override
  GeneratedColumn<String> get filePath => _filePath ??= GeneratedColumn<String>(
      'file_path', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _dateAddedMeta = const VerificationMeta('dateAdded');
  GeneratedColumn<DateTime> _dateAdded;
  @override
  GeneratedColumn<DateTime> get dateAdded =>
      _dateAdded ??= GeneratedColumn<DateTime>('date_added', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _latestVersionMeta =
      const VerificationMeta('latestVersion');
  GeneratedColumn<int> _latestVersion;
  @override
  GeneratedColumn<int> get latestVersion => _latestVersion ??=
      GeneratedColumn<int>('latest_version', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _fileCategoryMeta =
      const VerificationMeta('fileCategory');
  GeneratedColumn<int> _fileCategory;
  @override
  GeneratedColumn<int> get fileCategory => _fileCategory ??=
      GeneratedColumn<int>('file_category', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: true,
          $customConstraints: 'REFERENCES FileCategories(id)');
  final VerificationMeta _projectIdMeta = const VerificationMeta('projectId');
  GeneratedColumn<int> _projectId;
  @override
  GeneratedColumn<int> get projectId =>
      _projectId ??= GeneratedColumn<int>('project_id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: true,
          $customConstraints: 'REFERENCES Projects(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fileName,
        filePath,
        dateAdded,
        latestVersion,
        fileCategory,
        projectId
      ];
  @override
  String get aliasedName => _alias ?? 'project_files';
  @override
  String get actualTableName => 'project_files';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectFile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name'], _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path'], _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('date_added')) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableOrUnknown(data['date_added'], _dateAddedMeta));
    } else if (isInserting) {
      context.missing(_dateAddedMeta);
    }
    if (data.containsKey('latest_version')) {
      context.handle(
          _latestVersionMeta,
          latestVersion.isAcceptableOrUnknown(
              data['latest_version'], _latestVersionMeta));
    } else if (isInserting) {
      context.missing(_latestVersionMeta);
    }
    if (data.containsKey('file_category')) {
      context.handle(
          _fileCategoryMeta,
          fileCategory.isAcceptableOrUnknown(
              data['file_category'], _fileCategoryMeta));
    } else if (isInserting) {
      context.missing(_fileCategoryMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id'], _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectFile map(Map<String, dynamic> data, {String tablePrefix}) {
    return ProjectFile.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProjectFilesTable createAlias(String alias) {
    return $ProjectFilesTable(_db, alias);
  }
}

class FileVersion extends DataClass implements Insertable<FileVersion> {
  final int id;
  final int fileId;
  final int fileVersion;
  FileVersion(
      {@required this.id, @required this.fileId, @required this.fileVersion});
  factory FileVersion.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return FileVersion(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fileId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}file_id']),
      fileVersion: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}file_version']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fileId != null) {
      map['file_id'] = Variable<int>(fileId);
    }
    if (!nullToAbsent || fileVersion != null) {
      map['file_version'] = Variable<int>(fileVersion);
    }
    return map;
  }

  FileVersionsCompanion toCompanion(bool nullToAbsent) {
    return FileVersionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
      fileVersion: fileVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(fileVersion),
    );
  }

  factory FileVersion.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FileVersion(
      id: serializer.fromJson<int>(json['id']),
      fileId: serializer.fromJson<int>(json['fileId']),
      fileVersion: serializer.fromJson<int>(json['fileVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'fileVersion': serializer.toJson<int>(fileVersion),
    };
  }

  FileVersion copyWith({int id, int fileId, int fileVersion}) => FileVersion(
        id: id ?? this.id,
        fileId: fileId ?? this.fileId,
        fileVersion: fileVersion ?? this.fileVersion,
      );
  @override
  String toString() {
    return (StringBuffer('FileVersion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('fileVersion: $fileVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(fileId.hashCode, fileVersion.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileVersion &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.fileVersion == this.fileVersion);
}

class FileVersionsCompanion extends UpdateCompanion<FileVersion> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<int> fileVersion;
  const FileVersionsCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.fileVersion = const Value.absent(),
  });
  FileVersionsCompanion.insert({
    this.id = const Value.absent(),
    @required int fileId,
    @required int fileVersion,
  })  : fileId = Value(fileId),
        fileVersion = Value(fileVersion);
  static Insertable<FileVersion> custom({
    Expression<int> id,
    Expression<int> fileId,
    Expression<int> fileVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (fileVersion != null) 'file_version': fileVersion,
    });
  }

  FileVersionsCompanion copyWith(
      {Value<int> id, Value<int> fileId, Value<int> fileVersion}) {
    return FileVersionsCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      fileVersion: fileVersion ?? this.fileVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (fileVersion.present) {
      map['file_version'] = Variable<int>(fileVersion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileVersionsCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('fileVersion: $fileVersion')
          ..write(')'))
        .toString();
  }
}

class $FileVersionsTable extends FileVersions
    with TableInfo<$FileVersionsTable, FileVersion> {
  final GeneratedDatabase _db;
  final String _alias;
  $FileVersionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  GeneratedColumn<int> _fileId;
  @override
  GeneratedColumn<int> get fileId =>
      _fileId ??= GeneratedColumn<int>('file_id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: true,
          $customConstraints: 'REFERENCES ProjectFiles(id)');
  final VerificationMeta _fileVersionMeta =
      const VerificationMeta('fileVersion');
  GeneratedColumn<int> _fileVersion;
  @override
  GeneratedColumn<int> get fileVersion =>
      _fileVersion ??= GeneratedColumn<int>('file_version', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, fileId, fileVersion];
  @override
  String get aliasedName => _alias ?? 'file_versions';
  @override
  String get actualTableName => 'file_versions';
  @override
  VerificationContext validateIntegrity(Insertable<FileVersion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id'], _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('file_version')) {
      context.handle(
          _fileVersionMeta,
          fileVersion.isAcceptableOrUnknown(
              data['file_version'], _fileVersionMeta));
    } else if (isInserting) {
      context.missing(_fileVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileVersion map(Map<String, dynamic> data, {String tablePrefix}) {
    return FileVersion.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FileVersionsTable createAlias(String alias) {
    return $FileVersionsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $OrganizationsTable _organizations;
  $OrganizationsTable get organizations =>
      _organizations ??= $OrganizationsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $ProjectsTable _projects;
  $ProjectsTable get projects => _projects ??= $ProjectsTable(this);
  $FileCategoriesTable _fileCategories;
  $FileCategoriesTable get fileCategories =>
      _fileCategories ??= $FileCategoriesTable(this);
  $ProjectFilesTable _projectFiles;
  $ProjectFilesTable get projectFiles =>
      _projectFiles ??= $ProjectFilesTable(this);
  $FileVersionsTable _fileVersions;
  $FileVersionsTable get fileVersions =>
      _fileVersions ??= $FileVersionsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        organizations,
        users,
        projects,
        fileCategories,
        projectFiles,
        fileVersions
      ];
}
