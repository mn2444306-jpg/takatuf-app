// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VillagesTable extends Villages with TableInfo<$VillagesTable, Village> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VillagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'villages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Village> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Village map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Village(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VillagesTable createAlias(String alias) {
    return $VillagesTable(attachedDatabase, alias);
  }
}

class Village extends DataClass implements Insertable<Village> {
  final int id;
  final String name;
  final String? notes;
  final DateTime createdAt;
  const Village({
    required this.id,
    required this.name,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VillagesCompanion toCompanion(bool nullToAbsent) {
    return VillagesCompanion(
      id: Value(id),
      name: Value(name),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Village.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Village(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Village copyWith({
    int? id,
    String? name,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Village(
    id: id ?? this.id,
    name: name ?? this.name,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Village copyWithCompanion(VillagesCompanion data) {
    return Village(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Village(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Village &&
          other.id == this.id &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class VillagesCompanion extends UpdateCompanion<Village> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const VillagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VillagesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Village> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VillagesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return VillagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ResidencePlacesTable extends ResidencePlaces
    with TableInfo<$ResidencePlacesTable, ResidencePlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResidencePlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'residence_places';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResidencePlace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResidencePlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResidencePlace(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ResidencePlacesTable createAlias(String alias) {
    return $ResidencePlacesTable(attachedDatabase, alias);
  }
}

class ResidencePlace extends DataClass implements Insertable<ResidencePlace> {
  final int id;
  final String name;
  final DateTime createdAt;
  const ResidencePlace({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ResidencePlacesCompanion toCompanion(bool nullToAbsent) {
    return ResidencePlacesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory ResidencePlace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResidencePlace(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ResidencePlace copyWith({int? id, String? name, DateTime? createdAt}) =>
      ResidencePlace(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  ResidencePlace copyWithCompanion(ResidencePlacesCompanion data) {
    return ResidencePlace(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResidencePlace(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResidencePlace &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class ResidencePlacesCompanion extends UpdateCompanion<ResidencePlace> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const ResidencePlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ResidencePlacesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ResidencePlace> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ResidencePlacesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return ResidencePlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResidencePlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AidTypesTable extends AidTypes with TableInfo<$AidTypesTable, AidType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AidTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _requiresAmountMeta = const VerificationMeta(
    'requiresAmount',
  );
  @override
  late final GeneratedColumn<bool> requiresAmount = GeneratedColumn<bool>(
    'requires_amount',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_amount" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, requiresAmount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aid_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<AidType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('requires_amount')) {
      context.handle(
        _requiresAmountMeta,
        requiresAmount.isAcceptableOrUnknown(
          data['requires_amount']!,
          _requiresAmountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AidType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AidType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      requiresAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AidTypesTable createAlias(String alias) {
    return $AidTypesTable(attachedDatabase, alias);
  }
}

class AidType extends DataClass implements Insertable<AidType> {
  final int id;
  final String name;
  final bool requiresAmount;
  final DateTime createdAt;
  const AidType({
    required this.id,
    required this.name,
    required this.requiresAmount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['requires_amount'] = Variable<bool>(requiresAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AidTypesCompanion toCompanion(bool nullToAbsent) {
    return AidTypesCompanion(
      id: Value(id),
      name: Value(name),
      requiresAmount: Value(requiresAmount),
      createdAt: Value(createdAt),
    );
  }

  factory AidType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AidType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      requiresAmount: serializer.fromJson<bool>(json['requiresAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'requiresAmount': serializer.toJson<bool>(requiresAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AidType copyWith({
    int? id,
    String? name,
    bool? requiresAmount,
    DateTime? createdAt,
  }) => AidType(
    id: id ?? this.id,
    name: name ?? this.name,
    requiresAmount: requiresAmount ?? this.requiresAmount,
    createdAt: createdAt ?? this.createdAt,
  );
  AidType copyWithCompanion(AidTypesCompanion data) {
    return AidType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      requiresAmount: data.requiresAmount.present
          ? data.requiresAmount.value
          : this.requiresAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AidType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('requiresAmount: $requiresAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, requiresAmount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AidType &&
          other.id == this.id &&
          other.name == this.name &&
          other.requiresAmount == this.requiresAmount &&
          other.createdAt == this.createdAt);
}

class AidTypesCompanion extends UpdateCompanion<AidType> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> requiresAmount;
  final Value<DateTime> createdAt;
  const AidTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.requiresAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AidTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.requiresAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AidType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? requiresAmount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (requiresAmount != null) 'requires_amount': requiresAmount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AidTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? requiresAmount,
    Value<DateTime>? createdAt,
  }) {
    return AidTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      requiresAmount: requiresAmount ?? this.requiresAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (requiresAmount.present) {
      map['requires_amount'] = Variable<bool>(requiresAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AidTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('requiresAmount: $requiresAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BeneficiariesTable extends Beneficiaries
    with TableInfo<$BeneficiariesTable, Beneficiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeneficiariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _beneficiaryTypeMeta = const VerificationMeta(
    'beneficiaryType',
  );
  @override
  late final GeneratedColumn<String> beneficiaryType = GeneratedColumn<String>(
    'beneficiary_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryNameMeta = const VerificationMeta(
    'primaryName',
  );
  @override
  late final GeneratedColumn<String> primaryName = GeneratedColumn<String>(
    'primary_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villageIdMeta = const VerificationMeta(
    'villageId',
  );
  @override
  late final GeneratedColumn<int> villageId = GeneratedColumn<int>(
    'village_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES villages (id)',
    ),
  );
  static const VerificationMeta _residencePlaceIdMeta = const VerificationMeta(
    'residencePlaceId',
  );
  @override
  late final GeneratedColumn<int> residencePlaceId = GeneratedColumn<int>(
    'residence_place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES residence_places (id)',
    ),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    beneficiaryType,
    primaryName,
    villageId,
    residencePlaceId,
    phone,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'beneficiaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Beneficiary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('beneficiary_type')) {
      context.handle(
        _beneficiaryTypeMeta,
        beneficiaryType.isAcceptableOrUnknown(
          data['beneficiary_type']!,
          _beneficiaryTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_beneficiaryTypeMeta);
    }
    if (data.containsKey('primary_name')) {
      context.handle(
        _primaryNameMeta,
        primaryName.isAcceptableOrUnknown(
          data['primary_name']!,
          _primaryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryNameMeta);
    }
    if (data.containsKey('village_id')) {
      context.handle(
        _villageIdMeta,
        villageId.isAcceptableOrUnknown(data['village_id']!, _villageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_villageIdMeta);
    }
    if (data.containsKey('residence_place_id')) {
      context.handle(
        _residencePlaceIdMeta,
        residencePlaceId.isAcceptableOrUnknown(
          data['residence_place_id']!,
          _residencePlaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_residencePlaceIdMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Beneficiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Beneficiary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      beneficiaryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiary_type'],
      )!,
      primaryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_name'],
      )!,
      villageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}village_id'],
      )!,
      residencePlaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}residence_place_id'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BeneficiariesTable createAlias(String alias) {
    return $BeneficiariesTable(attachedDatabase, alias);
  }
}

class Beneficiary extends DataClass implements Insertable<Beneficiary> {
  final int id;
  final String beneficiaryType;
  final String primaryName;
  final int villageId;
  final int residencePlaceId;
  final String? phone;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Beneficiary({
    required this.id,
    required this.beneficiaryType,
    required this.primaryName,
    required this.villageId,
    required this.residencePlaceId,
    this.phone,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['beneficiary_type'] = Variable<String>(beneficiaryType);
    map['primary_name'] = Variable<String>(primaryName);
    map['village_id'] = Variable<int>(villageId);
    map['residence_place_id'] = Variable<int>(residencePlaceId);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BeneficiariesCompanion toCompanion(bool nullToAbsent) {
    return BeneficiariesCompanion(
      id: Value(id),
      beneficiaryType: Value(beneficiaryType),
      primaryName: Value(primaryName),
      villageId: Value(villageId),
      residencePlaceId: Value(residencePlaceId),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Beneficiary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Beneficiary(
      id: serializer.fromJson<int>(json['id']),
      beneficiaryType: serializer.fromJson<String>(json['beneficiaryType']),
      primaryName: serializer.fromJson<String>(json['primaryName']),
      villageId: serializer.fromJson<int>(json['villageId']),
      residencePlaceId: serializer.fromJson<int>(json['residencePlaceId']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'beneficiaryType': serializer.toJson<String>(beneficiaryType),
      'primaryName': serializer.toJson<String>(primaryName),
      'villageId': serializer.toJson<int>(villageId),
      'residencePlaceId': serializer.toJson<int>(residencePlaceId),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Beneficiary copyWith({
    int? id,
    String? beneficiaryType,
    String? primaryName,
    int? villageId,
    int? residencePlaceId,
    Value<String?> phone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Beneficiary(
    id: id ?? this.id,
    beneficiaryType: beneficiaryType ?? this.beneficiaryType,
    primaryName: primaryName ?? this.primaryName,
    villageId: villageId ?? this.villageId,
    residencePlaceId: residencePlaceId ?? this.residencePlaceId,
    phone: phone.present ? phone.value : this.phone,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Beneficiary copyWithCompanion(BeneficiariesCompanion data) {
    return Beneficiary(
      id: data.id.present ? data.id.value : this.id,
      beneficiaryType: data.beneficiaryType.present
          ? data.beneficiaryType.value
          : this.beneficiaryType,
      primaryName: data.primaryName.present
          ? data.primaryName.value
          : this.primaryName,
      villageId: data.villageId.present ? data.villageId.value : this.villageId,
      residencePlaceId: data.residencePlaceId.present
          ? data.residencePlaceId.value
          : this.residencePlaceId,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Beneficiary(')
          ..write('id: $id, ')
          ..write('beneficiaryType: $beneficiaryType, ')
          ..write('primaryName: $primaryName, ')
          ..write('villageId: $villageId, ')
          ..write('residencePlaceId: $residencePlaceId, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    beneficiaryType,
    primaryName,
    villageId,
    residencePlaceId,
    phone,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Beneficiary &&
          other.id == this.id &&
          other.beneficiaryType == this.beneficiaryType &&
          other.primaryName == this.primaryName &&
          other.villageId == this.villageId &&
          other.residencePlaceId == this.residencePlaceId &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BeneficiariesCompanion extends UpdateCompanion<Beneficiary> {
  final Value<int> id;
  final Value<String> beneficiaryType;
  final Value<String> primaryName;
  final Value<int> villageId;
  final Value<int> residencePlaceId;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BeneficiariesCompanion({
    this.id = const Value.absent(),
    this.beneficiaryType = const Value.absent(),
    this.primaryName = const Value.absent(),
    this.villageId = const Value.absent(),
    this.residencePlaceId = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BeneficiariesCompanion.insert({
    this.id = const Value.absent(),
    required String beneficiaryType,
    required String primaryName,
    required int villageId,
    required int residencePlaceId,
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : beneficiaryType = Value(beneficiaryType),
       primaryName = Value(primaryName),
       villageId = Value(villageId),
       residencePlaceId = Value(residencePlaceId);
  static Insertable<Beneficiary> custom({
    Expression<int>? id,
    Expression<String>? beneficiaryType,
    Expression<String>? primaryName,
    Expression<int>? villageId,
    Expression<int>? residencePlaceId,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (beneficiaryType != null) 'beneficiary_type': beneficiaryType,
      if (primaryName != null) 'primary_name': primaryName,
      if (villageId != null) 'village_id': villageId,
      if (residencePlaceId != null) 'residence_place_id': residencePlaceId,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BeneficiariesCompanion copyWith({
    Value<int>? id,
    Value<String>? beneficiaryType,
    Value<String>? primaryName,
    Value<int>? villageId,
    Value<int>? residencePlaceId,
    Value<String?>? phone,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BeneficiariesCompanion(
      id: id ?? this.id,
      beneficiaryType: beneficiaryType ?? this.beneficiaryType,
      primaryName: primaryName ?? this.primaryName,
      villageId: villageId ?? this.villageId,
      residencePlaceId: residencePlaceId ?? this.residencePlaceId,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (beneficiaryType.present) {
      map['beneficiary_type'] = Variable<String>(beneficiaryType.value);
    }
    if (primaryName.present) {
      map['primary_name'] = Variable<String>(primaryName.value);
    }
    if (villageId.present) {
      map['village_id'] = Variable<int>(villageId.value);
    }
    if (residencePlaceId.present) {
      map['residence_place_id'] = Variable<int>(residencePlaceId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeneficiariesCompanion(')
          ..write('id: $id, ')
          ..write('beneficiaryType: $beneficiaryType, ')
          ..write('primaryName: $primaryName, ')
          ..write('villageId: $villageId, ')
          ..write('residencePlaceId: $residencePlaceId, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HouseholdsTable extends Households
    with TableInfo<$HouseholdsTable, Household> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beneficiaryIdMeta = const VerificationMeta(
    'beneficiaryId',
  );
  @override
  late final GeneratedColumn<int> beneficiaryId = GeneratedColumn<int>(
    'beneficiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beneficiaries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _wifeNameMeta = const VerificationMeta(
    'wifeName',
  );
  @override
  late final GeneratedColumn<String> wifeName = GeneratedColumn<String>(
    'wife_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _familyMembersCountMeta =
      const VerificationMeta('familyMembersCount');
  @override
  late final GeneratedColumn<int> familyMembersCount = GeneratedColumn<int>(
    'family_members_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    beneficiaryId,
    wifeName,
    familyMembersCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'households';
  @override
  VerificationContext validateIntegrity(
    Insertable<Household> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('beneficiary_id')) {
      context.handle(
        _beneficiaryIdMeta,
        beneficiaryId.isAcceptableOrUnknown(
          data['beneficiary_id']!,
          _beneficiaryIdMeta,
        ),
      );
    }
    if (data.containsKey('wife_name')) {
      context.handle(
        _wifeNameMeta,
        wifeName.isAcceptableOrUnknown(data['wife_name']!, _wifeNameMeta),
      );
    }
    if (data.containsKey('family_members_count')) {
      context.handle(
        _familyMembersCountMeta,
        familyMembersCount.isAcceptableOrUnknown(
          data['family_members_count']!,
          _familyMembersCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beneficiaryId};
  @override
  Household map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Household(
      beneficiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beneficiary_id'],
      )!,
      wifeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wife_name'],
      ),
      familyMembersCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}family_members_count'],
      )!,
    );
  }

  @override
  $HouseholdsTable createAlias(String alias) {
    return $HouseholdsTable(attachedDatabase, alias);
  }
}

class Household extends DataClass implements Insertable<Household> {
  final int beneficiaryId;
  final String? wifeName;
  final int familyMembersCount;
  const Household({
    required this.beneficiaryId,
    this.wifeName,
    required this.familyMembersCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['beneficiary_id'] = Variable<int>(beneficiaryId);
    if (!nullToAbsent || wifeName != null) {
      map['wife_name'] = Variable<String>(wifeName);
    }
    map['family_members_count'] = Variable<int>(familyMembersCount);
    return map;
  }

  HouseholdsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdsCompanion(
      beneficiaryId: Value(beneficiaryId),
      wifeName: wifeName == null && nullToAbsent
          ? const Value.absent()
          : Value(wifeName),
      familyMembersCount: Value(familyMembersCount),
    );
  }

  factory Household.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Household(
      beneficiaryId: serializer.fromJson<int>(json['beneficiaryId']),
      wifeName: serializer.fromJson<String?>(json['wifeName']),
      familyMembersCount: serializer.fromJson<int>(json['familyMembersCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beneficiaryId': serializer.toJson<int>(beneficiaryId),
      'wifeName': serializer.toJson<String?>(wifeName),
      'familyMembersCount': serializer.toJson<int>(familyMembersCount),
    };
  }

  Household copyWith({
    int? beneficiaryId,
    Value<String?> wifeName = const Value.absent(),
    int? familyMembersCount,
  }) => Household(
    beneficiaryId: beneficiaryId ?? this.beneficiaryId,
    wifeName: wifeName.present ? wifeName.value : this.wifeName,
    familyMembersCount: familyMembersCount ?? this.familyMembersCount,
  );
  Household copyWithCompanion(HouseholdsCompanion data) {
    return Household(
      beneficiaryId: data.beneficiaryId.present
          ? data.beneficiaryId.value
          : this.beneficiaryId,
      wifeName: data.wifeName.present ? data.wifeName.value : this.wifeName,
      familyMembersCount: data.familyMembersCount.present
          ? data.familyMembersCount.value
          : this.familyMembersCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Household(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('wifeName: $wifeName, ')
          ..write('familyMembersCount: $familyMembersCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(beneficiaryId, wifeName, familyMembersCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Household &&
          other.beneficiaryId == this.beneficiaryId &&
          other.wifeName == this.wifeName &&
          other.familyMembersCount == this.familyMembersCount);
}

class HouseholdsCompanion extends UpdateCompanion<Household> {
  final Value<int> beneficiaryId;
  final Value<String?> wifeName;
  final Value<int> familyMembersCount;
  const HouseholdsCompanion({
    this.beneficiaryId = const Value.absent(),
    this.wifeName = const Value.absent(),
    this.familyMembersCount = const Value.absent(),
  });
  HouseholdsCompanion.insert({
    this.beneficiaryId = const Value.absent(),
    this.wifeName = const Value.absent(),
    this.familyMembersCount = const Value.absent(),
  });
  static Insertable<Household> custom({
    Expression<int>? beneficiaryId,
    Expression<String>? wifeName,
    Expression<int>? familyMembersCount,
  }) {
    return RawValuesInsertable({
      if (beneficiaryId != null) 'beneficiary_id': beneficiaryId,
      if (wifeName != null) 'wife_name': wifeName,
      if (familyMembersCount != null)
        'family_members_count': familyMembersCount,
    });
  }

  HouseholdsCompanion copyWith({
    Value<int>? beneficiaryId,
    Value<String?>? wifeName,
    Value<int>? familyMembersCount,
  }) {
    return HouseholdsCompanion(
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      wifeName: wifeName ?? this.wifeName,
      familyMembersCount: familyMembersCount ?? this.familyMembersCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beneficiaryId.present) {
      map['beneficiary_id'] = Variable<int>(beneficiaryId.value);
    }
    if (wifeName.present) {
      map['wife_name'] = Variable<String>(wifeName.value);
    }
    if (familyMembersCount.present) {
      map['family_members_count'] = Variable<int>(familyMembersCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdsCompanion(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('wifeName: $wifeName, ')
          ..write('familyMembersCount: $familyMembersCount')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beneficiaryIdMeta = const VerificationMeta(
    'beneficiaryId',
  );
  @override
  late final GeneratedColumn<int> beneficiaryId = GeneratedColumn<int>(
    'beneficiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beneficiaries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _schoolNameMeta = const VerificationMeta(
    'schoolName',
  );
  @override
  late final GeneratedColumn<String> schoolName = GeneratedColumn<String>(
    'school_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _educationStageMeta = const VerificationMeta(
    'educationStage',
  );
  @override
  late final GeneratedColumn<String> educationStage = GeneratedColumn<String>(
    'education_stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classGradeMeta = const VerificationMeta(
    'classGrade',
  );
  @override
  late final GeneratedColumn<String> classGrade = GeneratedColumn<String>(
    'class_grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    beneficiaryId,
    schoolName,
    educationStage,
    classGrade,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('beneficiary_id')) {
      context.handle(
        _beneficiaryIdMeta,
        beneficiaryId.isAcceptableOrUnknown(
          data['beneficiary_id']!,
          _beneficiaryIdMeta,
        ),
      );
    }
    if (data.containsKey('school_name')) {
      context.handle(
        _schoolNameMeta,
        schoolName.isAcceptableOrUnknown(data['school_name']!, _schoolNameMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolNameMeta);
    }
    if (data.containsKey('education_stage')) {
      context.handle(
        _educationStageMeta,
        educationStage.isAcceptableOrUnknown(
          data['education_stage']!,
          _educationStageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_educationStageMeta);
    }
    if (data.containsKey('class_grade')) {
      context.handle(
        _classGradeMeta,
        classGrade.isAcceptableOrUnknown(data['class_grade']!, _classGradeMeta),
      );
    } else if (isInserting) {
      context.missing(_classGradeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beneficiaryId};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      beneficiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beneficiary_id'],
      )!,
      schoolName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_name'],
      )!,
      educationStage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}education_stage'],
      )!,
      classGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_grade'],
      )!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int beneficiaryId;
  final String schoolName;
  final String educationStage;
  final String classGrade;
  const Student({
    required this.beneficiaryId,
    required this.schoolName,
    required this.educationStage,
    required this.classGrade,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['beneficiary_id'] = Variable<int>(beneficiaryId);
    map['school_name'] = Variable<String>(schoolName);
    map['education_stage'] = Variable<String>(educationStage);
    map['class_grade'] = Variable<String>(classGrade);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      beneficiaryId: Value(beneficiaryId),
      schoolName: Value(schoolName),
      educationStage: Value(educationStage),
      classGrade: Value(classGrade),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      beneficiaryId: serializer.fromJson<int>(json['beneficiaryId']),
      schoolName: serializer.fromJson<String>(json['schoolName']),
      educationStage: serializer.fromJson<String>(json['educationStage']),
      classGrade: serializer.fromJson<String>(json['classGrade']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beneficiaryId': serializer.toJson<int>(beneficiaryId),
      'schoolName': serializer.toJson<String>(schoolName),
      'educationStage': serializer.toJson<String>(educationStage),
      'classGrade': serializer.toJson<String>(classGrade),
    };
  }

  Student copyWith({
    int? beneficiaryId,
    String? schoolName,
    String? educationStage,
    String? classGrade,
  }) => Student(
    beneficiaryId: beneficiaryId ?? this.beneficiaryId,
    schoolName: schoolName ?? this.schoolName,
    educationStage: educationStage ?? this.educationStage,
    classGrade: classGrade ?? this.classGrade,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      beneficiaryId: data.beneficiaryId.present
          ? data.beneficiaryId.value
          : this.beneficiaryId,
      schoolName: data.schoolName.present
          ? data.schoolName.value
          : this.schoolName,
      educationStage: data.educationStage.present
          ? data.educationStage.value
          : this.educationStage,
      classGrade: data.classGrade.present
          ? data.classGrade.value
          : this.classGrade,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('schoolName: $schoolName, ')
          ..write('educationStage: $educationStage, ')
          ..write('classGrade: $classGrade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(beneficiaryId, schoolName, educationStage, classGrade);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.beneficiaryId == this.beneficiaryId &&
          other.schoolName == this.schoolName &&
          other.educationStage == this.educationStage &&
          other.classGrade == this.classGrade);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> beneficiaryId;
  final Value<String> schoolName;
  final Value<String> educationStage;
  final Value<String> classGrade;
  const StudentsCompanion({
    this.beneficiaryId = const Value.absent(),
    this.schoolName = const Value.absent(),
    this.educationStage = const Value.absent(),
    this.classGrade = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.beneficiaryId = const Value.absent(),
    required String schoolName,
    required String educationStage,
    required String classGrade,
  }) : schoolName = Value(schoolName),
       educationStage = Value(educationStage),
       classGrade = Value(classGrade);
  static Insertable<Student> custom({
    Expression<int>? beneficiaryId,
    Expression<String>? schoolName,
    Expression<String>? educationStage,
    Expression<String>? classGrade,
  }) {
    return RawValuesInsertable({
      if (beneficiaryId != null) 'beneficiary_id': beneficiaryId,
      if (schoolName != null) 'school_name': schoolName,
      if (educationStage != null) 'education_stage': educationStage,
      if (classGrade != null) 'class_grade': classGrade,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? beneficiaryId,
    Value<String>? schoolName,
    Value<String>? educationStage,
    Value<String>? classGrade,
  }) {
    return StudentsCompanion(
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      schoolName: schoolName ?? this.schoolName,
      educationStage: educationStage ?? this.educationStage,
      classGrade: classGrade ?? this.classGrade,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beneficiaryId.present) {
      map['beneficiary_id'] = Variable<int>(beneficiaryId.value);
    }
    if (schoolName.present) {
      map['school_name'] = Variable<String>(schoolName.value);
    }
    if (educationStage.present) {
      map['education_stage'] = Variable<String>(educationStage.value);
    }
    if (classGrade.present) {
      map['class_grade'] = Variable<String>(classGrade.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('schoolName: $schoolName, ')
          ..write('educationStage: $educationStage, ')
          ..write('classGrade: $classGrade')
          ..write(')'))
        .toString();
  }
}

class $ElderlyTable extends Elderly
    with TableInfo<$ElderlyTable, ElderlyBeneficiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElderlyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beneficiaryIdMeta = const VerificationMeta(
    'beneficiaryId',
  );
  @override
  late final GeneratedColumn<int> beneficiaryId = GeneratedColumn<int>(
    'beneficiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beneficiaries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [beneficiaryId, age];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'elderly';
  @override
  VerificationContext validateIntegrity(
    Insertable<ElderlyBeneficiary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('beneficiary_id')) {
      context.handle(
        _beneficiaryIdMeta,
        beneficiaryId.isAcceptableOrUnknown(
          data['beneficiary_id']!,
          _beneficiaryIdMeta,
        ),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beneficiaryId};
  @override
  ElderlyBeneficiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElderlyBeneficiary(
      beneficiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beneficiary_id'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
    );
  }

  @override
  $ElderlyTable createAlias(String alias) {
    return $ElderlyTable(attachedDatabase, alias);
  }
}

class ElderlyBeneficiary extends DataClass
    implements Insertable<ElderlyBeneficiary> {
  final int beneficiaryId;
  final int age;
  const ElderlyBeneficiary({required this.beneficiaryId, required this.age});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['beneficiary_id'] = Variable<int>(beneficiaryId);
    map['age'] = Variable<int>(age);
    return map;
  }

  ElderlyCompanion toCompanion(bool nullToAbsent) {
    return ElderlyCompanion(
      beneficiaryId: Value(beneficiaryId),
      age: Value(age),
    );
  }

  factory ElderlyBeneficiary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElderlyBeneficiary(
      beneficiaryId: serializer.fromJson<int>(json['beneficiaryId']),
      age: serializer.fromJson<int>(json['age']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beneficiaryId': serializer.toJson<int>(beneficiaryId),
      'age': serializer.toJson<int>(age),
    };
  }

  ElderlyBeneficiary copyWith({int? beneficiaryId, int? age}) =>
      ElderlyBeneficiary(
        beneficiaryId: beneficiaryId ?? this.beneficiaryId,
        age: age ?? this.age,
      );
  ElderlyBeneficiary copyWithCompanion(ElderlyCompanion data) {
    return ElderlyBeneficiary(
      beneficiaryId: data.beneficiaryId.present
          ? data.beneficiaryId.value
          : this.beneficiaryId,
      age: data.age.present ? data.age.value : this.age,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElderlyBeneficiary(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(beneficiaryId, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElderlyBeneficiary &&
          other.beneficiaryId == this.beneficiaryId &&
          other.age == this.age);
}

class ElderlyCompanion extends UpdateCompanion<ElderlyBeneficiary> {
  final Value<int> beneficiaryId;
  final Value<int> age;
  const ElderlyCompanion({
    this.beneficiaryId = const Value.absent(),
    this.age = const Value.absent(),
  });
  ElderlyCompanion.insert({
    this.beneficiaryId = const Value.absent(),
    required int age,
  }) : age = Value(age);
  static Insertable<ElderlyBeneficiary> custom({
    Expression<int>? beneficiaryId,
    Expression<int>? age,
  }) {
    return RawValuesInsertable({
      if (beneficiaryId != null) 'beneficiary_id': beneficiaryId,
      if (age != null) 'age': age,
    });
  }

  ElderlyCompanion copyWith({Value<int>? beneficiaryId, Value<int>? age}) {
    return ElderlyCompanion(
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      age: age ?? this.age,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beneficiaryId.present) {
      map['beneficiary_id'] = Variable<int>(beneficiaryId.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElderlyCompanion(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }
}

class $MarriedTable extends Married
    with TableInfo<$MarriedTable, MarriedBeneficiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarriedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beneficiaryIdMeta = const VerificationMeta(
    'beneficiaryId',
  );
  @override
  late final GeneratedColumn<int> beneficiaryId = GeneratedColumn<int>(
    'beneficiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beneficiaries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _marriageDateMeta = const VerificationMeta(
    'marriageDate',
  );
  @override
  late final GeneratedColumn<DateTime> marriageDate = GeneratedColumn<DateTime>(
    'marriage_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [beneficiaryId, marriageDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'married';
  @override
  VerificationContext validateIntegrity(
    Insertable<MarriedBeneficiary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('beneficiary_id')) {
      context.handle(
        _beneficiaryIdMeta,
        beneficiaryId.isAcceptableOrUnknown(
          data['beneficiary_id']!,
          _beneficiaryIdMeta,
        ),
      );
    }
    if (data.containsKey('marriage_date')) {
      context.handle(
        _marriageDateMeta,
        marriageDate.isAcceptableOrUnknown(
          data['marriage_date']!,
          _marriageDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_marriageDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beneficiaryId};
  @override
  MarriedBeneficiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MarriedBeneficiary(
      beneficiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beneficiary_id'],
      )!,
      marriageDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}marriage_date'],
      )!,
    );
  }

  @override
  $MarriedTable createAlias(String alias) {
    return $MarriedTable(attachedDatabase, alias);
  }
}

class MarriedBeneficiary extends DataClass
    implements Insertable<MarriedBeneficiary> {
  final int beneficiaryId;
  final DateTime marriageDate;
  const MarriedBeneficiary({
    required this.beneficiaryId,
    required this.marriageDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['beneficiary_id'] = Variable<int>(beneficiaryId);
    map['marriage_date'] = Variable<DateTime>(marriageDate);
    return map;
  }

  MarriedCompanion toCompanion(bool nullToAbsent) {
    return MarriedCompanion(
      beneficiaryId: Value(beneficiaryId),
      marriageDate: Value(marriageDate),
    );
  }

  factory MarriedBeneficiary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MarriedBeneficiary(
      beneficiaryId: serializer.fromJson<int>(json['beneficiaryId']),
      marriageDate: serializer.fromJson<DateTime>(json['marriageDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beneficiaryId': serializer.toJson<int>(beneficiaryId),
      'marriageDate': serializer.toJson<DateTime>(marriageDate),
    };
  }

  MarriedBeneficiary copyWith({int? beneficiaryId, DateTime? marriageDate}) =>
      MarriedBeneficiary(
        beneficiaryId: beneficiaryId ?? this.beneficiaryId,
        marriageDate: marriageDate ?? this.marriageDate,
      );
  MarriedBeneficiary copyWithCompanion(MarriedCompanion data) {
    return MarriedBeneficiary(
      beneficiaryId: data.beneficiaryId.present
          ? data.beneficiaryId.value
          : this.beneficiaryId,
      marriageDate: data.marriageDate.present
          ? data.marriageDate.value
          : this.marriageDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MarriedBeneficiary(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('marriageDate: $marriageDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(beneficiaryId, marriageDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarriedBeneficiary &&
          other.beneficiaryId == this.beneficiaryId &&
          other.marriageDate == this.marriageDate);
}

class MarriedCompanion extends UpdateCompanion<MarriedBeneficiary> {
  final Value<int> beneficiaryId;
  final Value<DateTime> marriageDate;
  const MarriedCompanion({
    this.beneficiaryId = const Value.absent(),
    this.marriageDate = const Value.absent(),
  });
  MarriedCompanion.insert({
    this.beneficiaryId = const Value.absent(),
    required DateTime marriageDate,
  }) : marriageDate = Value(marriageDate);
  static Insertable<MarriedBeneficiary> custom({
    Expression<int>? beneficiaryId,
    Expression<DateTime>? marriageDate,
  }) {
    return RawValuesInsertable({
      if (beneficiaryId != null) 'beneficiary_id': beneficiaryId,
      if (marriageDate != null) 'marriage_date': marriageDate,
    });
  }

  MarriedCompanion copyWith({
    Value<int>? beneficiaryId,
    Value<DateTime>? marriageDate,
  }) {
    return MarriedCompanion(
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      marriageDate: marriageDate ?? this.marriageDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beneficiaryId.present) {
      map['beneficiary_id'] = Variable<int>(beneficiaryId.value);
    }
    if (marriageDate.present) {
      map['marriage_date'] = Variable<DateTime>(marriageDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarriedCompanion(')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('marriageDate: $marriageDate')
          ..write(')'))
        .toString();
  }
}

class $CampaignsTable extends Campaigns
    with TableInfo<$CampaignsTable, Campaign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beneficiaryTypeMeta = const VerificationMeta(
    'beneficiaryType',
  );
  @override
  late final GeneratedColumn<String> beneficiaryType = GeneratedColumn<String>(
    'beneficiary_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aidTypeIdMeta = const VerificationMeta(
    'aidTypeId',
  );
  @override
  late final GeneratedColumn<int> aidTypeId = GeneratedColumn<int>(
    'aid_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES aid_types (id)',
    ),
  );
  static const VerificationMeta _amountPerBeneficiaryMeta =
      const VerificationMeta('amountPerBeneficiary');
  @override
  late final GeneratedColumn<double> amountPerBeneficiary =
      GeneratedColumn<double>(
        'amount_per_beneficiary',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    beneficiaryType,
    aidTypeId,
    amountPerBeneficiary,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaigns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Campaign> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('beneficiary_type')) {
      context.handle(
        _beneficiaryTypeMeta,
        beneficiaryType.isAcceptableOrUnknown(
          data['beneficiary_type']!,
          _beneficiaryTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_beneficiaryTypeMeta);
    }
    if (data.containsKey('aid_type_id')) {
      context.handle(
        _aidTypeIdMeta,
        aidTypeId.isAcceptableOrUnknown(data['aid_type_id']!, _aidTypeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_aidTypeIdMeta);
    }
    if (data.containsKey('amount_per_beneficiary')) {
      context.handle(
        _amountPerBeneficiaryMeta,
        amountPerBeneficiary.isAcceptableOrUnknown(
          data['amount_per_beneficiary']!,
          _amountPerBeneficiaryMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Campaign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Campaign(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      beneficiaryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiary_type'],
      )!,
      aidTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aid_type_id'],
      )!,
      amountPerBeneficiary: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_per_beneficiary'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CampaignsTable createAlias(String alias) {
    return $CampaignsTable(attachedDatabase, alias);
  }
}

class Campaign extends DataClass implements Insertable<Campaign> {
  final int id;
  final String name;
  final String beneficiaryType;
  final int aidTypeId;
  final double? amountPerBeneficiary;
  final String? notes;
  final DateTime createdAt;
  const Campaign({
    required this.id,
    required this.name,
    required this.beneficiaryType,
    required this.aidTypeId,
    this.amountPerBeneficiary,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['beneficiary_type'] = Variable<String>(beneficiaryType);
    map['aid_type_id'] = Variable<int>(aidTypeId);
    if (!nullToAbsent || amountPerBeneficiary != null) {
      map['amount_per_beneficiary'] = Variable<double>(amountPerBeneficiary);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CampaignsCompanion toCompanion(bool nullToAbsent) {
    return CampaignsCompanion(
      id: Value(id),
      name: Value(name),
      beneficiaryType: Value(beneficiaryType),
      aidTypeId: Value(aidTypeId),
      amountPerBeneficiary: amountPerBeneficiary == null && nullToAbsent
          ? const Value.absent()
          : Value(amountPerBeneficiary),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Campaign.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Campaign(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      beneficiaryType: serializer.fromJson<String>(json['beneficiaryType']),
      aidTypeId: serializer.fromJson<int>(json['aidTypeId']),
      amountPerBeneficiary: serializer.fromJson<double?>(
        json['amountPerBeneficiary'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'beneficiaryType': serializer.toJson<String>(beneficiaryType),
      'aidTypeId': serializer.toJson<int>(aidTypeId),
      'amountPerBeneficiary': serializer.toJson<double?>(amountPerBeneficiary),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Campaign copyWith({
    int? id,
    String? name,
    String? beneficiaryType,
    int? aidTypeId,
    Value<double?> amountPerBeneficiary = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Campaign(
    id: id ?? this.id,
    name: name ?? this.name,
    beneficiaryType: beneficiaryType ?? this.beneficiaryType,
    aidTypeId: aidTypeId ?? this.aidTypeId,
    amountPerBeneficiary: amountPerBeneficiary.present
        ? amountPerBeneficiary.value
        : this.amountPerBeneficiary,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Campaign copyWithCompanion(CampaignsCompanion data) {
    return Campaign(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      beneficiaryType: data.beneficiaryType.present
          ? data.beneficiaryType.value
          : this.beneficiaryType,
      aidTypeId: data.aidTypeId.present ? data.aidTypeId.value : this.aidTypeId,
      amountPerBeneficiary: data.amountPerBeneficiary.present
          ? data.amountPerBeneficiary.value
          : this.amountPerBeneficiary,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Campaign(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('beneficiaryType: $beneficiaryType, ')
          ..write('aidTypeId: $aidTypeId, ')
          ..write('amountPerBeneficiary: $amountPerBeneficiary, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    beneficiaryType,
    aidTypeId,
    amountPerBeneficiary,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Campaign &&
          other.id == this.id &&
          other.name == this.name &&
          other.beneficiaryType == this.beneficiaryType &&
          other.aidTypeId == this.aidTypeId &&
          other.amountPerBeneficiary == this.amountPerBeneficiary &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CampaignsCompanion extends UpdateCompanion<Campaign> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> beneficiaryType;
  final Value<int> aidTypeId;
  final Value<double?> amountPerBeneficiary;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const CampaignsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.beneficiaryType = const Value.absent(),
    this.aidTypeId = const Value.absent(),
    this.amountPerBeneficiary = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CampaignsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String beneficiaryType,
    required int aidTypeId,
    this.amountPerBeneficiary = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       beneficiaryType = Value(beneficiaryType),
       aidTypeId = Value(aidTypeId);
  static Insertable<Campaign> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? beneficiaryType,
    Expression<int>? aidTypeId,
    Expression<double>? amountPerBeneficiary,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (beneficiaryType != null) 'beneficiary_type': beneficiaryType,
      if (aidTypeId != null) 'aid_type_id': aidTypeId,
      if (amountPerBeneficiary != null)
        'amount_per_beneficiary': amountPerBeneficiary,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CampaignsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? beneficiaryType,
    Value<int>? aidTypeId,
    Value<double?>? amountPerBeneficiary,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return CampaignsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      beneficiaryType: beneficiaryType ?? this.beneficiaryType,
      aidTypeId: aidTypeId ?? this.aidTypeId,
      amountPerBeneficiary: amountPerBeneficiary ?? this.amountPerBeneficiary,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (beneficiaryType.present) {
      map['beneficiary_type'] = Variable<String>(beneficiaryType.value);
    }
    if (aidTypeId.present) {
      map['aid_type_id'] = Variable<int>(aidTypeId.value);
    }
    if (amountPerBeneficiary.present) {
      map['amount_per_beneficiary'] = Variable<double>(
        amountPerBeneficiary.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('beneficiaryType: $beneficiaryType, ')
          ..write('aidTypeId: $aidTypeId, ')
          ..write('amountPerBeneficiary: $amountPerBeneficiary, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CampaignVillagesTable extends CampaignVillages
    with TableInfo<$CampaignVillagesTable, CampaignVillage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignVillagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _campaignIdMeta = const VerificationMeta(
    'campaignId',
  );
  @override
  late final GeneratedColumn<int> campaignId = GeneratedColumn<int>(
    'campaign_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campaigns (id)',
    ),
  );
  static const VerificationMeta _villageIdMeta = const VerificationMeta(
    'villageId',
  );
  @override
  late final GeneratedColumn<int> villageId = GeneratedColumn<int>(
    'village_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES villages (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [campaignId, villageId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaign_villages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CampaignVillage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('campaign_id')) {
      context.handle(
        _campaignIdMeta,
        campaignId.isAcceptableOrUnknown(data['campaign_id']!, _campaignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('village_id')) {
      context.handle(
        _villageIdMeta,
        villageId.isAcceptableOrUnknown(data['village_id']!, _villageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_villageIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {campaignId, villageId};
  @override
  CampaignVillage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampaignVillage(
      campaignId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campaign_id'],
      )!,
      villageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}village_id'],
      )!,
    );
  }

  @override
  $CampaignVillagesTable createAlias(String alias) {
    return $CampaignVillagesTable(attachedDatabase, alias);
  }
}

class CampaignVillage extends DataClass implements Insertable<CampaignVillage> {
  final int campaignId;
  final int villageId;
  const CampaignVillage({required this.campaignId, required this.villageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['campaign_id'] = Variable<int>(campaignId);
    map['village_id'] = Variable<int>(villageId);
    return map;
  }

  CampaignVillagesCompanion toCompanion(bool nullToAbsent) {
    return CampaignVillagesCompanion(
      campaignId: Value(campaignId),
      villageId: Value(villageId),
    );
  }

  factory CampaignVillage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampaignVillage(
      campaignId: serializer.fromJson<int>(json['campaignId']),
      villageId: serializer.fromJson<int>(json['villageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'campaignId': serializer.toJson<int>(campaignId),
      'villageId': serializer.toJson<int>(villageId),
    };
  }

  CampaignVillage copyWith({int? campaignId, int? villageId}) =>
      CampaignVillage(
        campaignId: campaignId ?? this.campaignId,
        villageId: villageId ?? this.villageId,
      );
  CampaignVillage copyWithCompanion(CampaignVillagesCompanion data) {
    return CampaignVillage(
      campaignId: data.campaignId.present
          ? data.campaignId.value
          : this.campaignId,
      villageId: data.villageId.present ? data.villageId.value : this.villageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CampaignVillage(')
          ..write('campaignId: $campaignId, ')
          ..write('villageId: $villageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(campaignId, villageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignVillage &&
          other.campaignId == this.campaignId &&
          other.villageId == this.villageId);
}

class CampaignVillagesCompanion extends UpdateCompanion<CampaignVillage> {
  final Value<int> campaignId;
  final Value<int> villageId;
  final Value<int> rowid;
  const CampaignVillagesCompanion({
    this.campaignId = const Value.absent(),
    this.villageId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CampaignVillagesCompanion.insert({
    required int campaignId,
    required int villageId,
    this.rowid = const Value.absent(),
  }) : campaignId = Value(campaignId),
       villageId = Value(villageId);
  static Insertable<CampaignVillage> custom({
    Expression<int>? campaignId,
    Expression<int>? villageId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (campaignId != null) 'campaign_id': campaignId,
      if (villageId != null) 'village_id': villageId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CampaignVillagesCompanion copyWith({
    Value<int>? campaignId,
    Value<int>? villageId,
    Value<int>? rowid,
  }) {
    return CampaignVillagesCompanion(
      campaignId: campaignId ?? this.campaignId,
      villageId: villageId ?? this.villageId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (campaignId.present) {
      map['campaign_id'] = Variable<int>(campaignId.value);
    }
    if (villageId.present) {
      map['village_id'] = Variable<int>(villageId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignVillagesCompanion(')
          ..write('campaignId: $campaignId, ')
          ..write('villageId: $villageId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CampaignResidencePlacesTable extends CampaignResidencePlaces
    with TableInfo<$CampaignResidencePlacesTable, CampaignResidencePlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignResidencePlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _campaignIdMeta = const VerificationMeta(
    'campaignId',
  );
  @override
  late final GeneratedColumn<int> campaignId = GeneratedColumn<int>(
    'campaign_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campaigns (id)',
    ),
  );
  static const VerificationMeta _residencePlaceIdMeta = const VerificationMeta(
    'residencePlaceId',
  );
  @override
  late final GeneratedColumn<int> residencePlaceId = GeneratedColumn<int>(
    'residence_place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES residence_places (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [campaignId, residencePlaceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaign_residence_places';
  @override
  VerificationContext validateIntegrity(
    Insertable<CampaignResidencePlace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('campaign_id')) {
      context.handle(
        _campaignIdMeta,
        campaignId.isAcceptableOrUnknown(data['campaign_id']!, _campaignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('residence_place_id')) {
      context.handle(
        _residencePlaceIdMeta,
        residencePlaceId.isAcceptableOrUnknown(
          data['residence_place_id']!,
          _residencePlaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_residencePlaceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {campaignId, residencePlaceId};
  @override
  CampaignResidencePlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampaignResidencePlace(
      campaignId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campaign_id'],
      )!,
      residencePlaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}residence_place_id'],
      )!,
    );
  }

  @override
  $CampaignResidencePlacesTable createAlias(String alias) {
    return $CampaignResidencePlacesTable(attachedDatabase, alias);
  }
}

class CampaignResidencePlace extends DataClass
    implements Insertable<CampaignResidencePlace> {
  final int campaignId;
  final int residencePlaceId;
  const CampaignResidencePlace({
    required this.campaignId,
    required this.residencePlaceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['campaign_id'] = Variable<int>(campaignId);
    map['residence_place_id'] = Variable<int>(residencePlaceId);
    return map;
  }

  CampaignResidencePlacesCompanion toCompanion(bool nullToAbsent) {
    return CampaignResidencePlacesCompanion(
      campaignId: Value(campaignId),
      residencePlaceId: Value(residencePlaceId),
    );
  }

  factory CampaignResidencePlace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampaignResidencePlace(
      campaignId: serializer.fromJson<int>(json['campaignId']),
      residencePlaceId: serializer.fromJson<int>(json['residencePlaceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'campaignId': serializer.toJson<int>(campaignId),
      'residencePlaceId': serializer.toJson<int>(residencePlaceId),
    };
  }

  CampaignResidencePlace copyWith({int? campaignId, int? residencePlaceId}) =>
      CampaignResidencePlace(
        campaignId: campaignId ?? this.campaignId,
        residencePlaceId: residencePlaceId ?? this.residencePlaceId,
      );
  CampaignResidencePlace copyWithCompanion(
    CampaignResidencePlacesCompanion data,
  ) {
    return CampaignResidencePlace(
      campaignId: data.campaignId.present
          ? data.campaignId.value
          : this.campaignId,
      residencePlaceId: data.residencePlaceId.present
          ? data.residencePlaceId.value
          : this.residencePlaceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CampaignResidencePlace(')
          ..write('campaignId: $campaignId, ')
          ..write('residencePlaceId: $residencePlaceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(campaignId, residencePlaceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignResidencePlace &&
          other.campaignId == this.campaignId &&
          other.residencePlaceId == this.residencePlaceId);
}

class CampaignResidencePlacesCompanion
    extends UpdateCompanion<CampaignResidencePlace> {
  final Value<int> campaignId;
  final Value<int> residencePlaceId;
  final Value<int> rowid;
  const CampaignResidencePlacesCompanion({
    this.campaignId = const Value.absent(),
    this.residencePlaceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CampaignResidencePlacesCompanion.insert({
    required int campaignId,
    required int residencePlaceId,
    this.rowid = const Value.absent(),
  }) : campaignId = Value(campaignId),
       residencePlaceId = Value(residencePlaceId);
  static Insertable<CampaignResidencePlace> custom({
    Expression<int>? campaignId,
    Expression<int>? residencePlaceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (campaignId != null) 'campaign_id': campaignId,
      if (residencePlaceId != null) 'residence_place_id': residencePlaceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CampaignResidencePlacesCompanion copyWith({
    Value<int>? campaignId,
    Value<int>? residencePlaceId,
    Value<int>? rowid,
  }) {
    return CampaignResidencePlacesCompanion(
      campaignId: campaignId ?? this.campaignId,
      residencePlaceId: residencePlaceId ?? this.residencePlaceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (campaignId.present) {
      map['campaign_id'] = Variable<int>(campaignId.value);
    }
    if (residencePlaceId.present) {
      map['residence_place_id'] = Variable<int>(residencePlaceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignResidencePlacesCompanion(')
          ..write('campaignId: $campaignId, ')
          ..write('residencePlaceId: $residencePlaceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CampaignBeneficiariesTable extends CampaignBeneficiaries
    with TableInfo<$CampaignBeneficiariesTable, CampaignBeneficiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignBeneficiariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _campaignIdMeta = const VerificationMeta(
    'campaignId',
  );
  @override
  late final GeneratedColumn<int> campaignId = GeneratedColumn<int>(
    'campaign_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES campaigns (id)',
    ),
  );
  static const VerificationMeta _beneficiaryIdMeta = const VerificationMeta(
    'beneficiaryId',
  );
  @override
  late final GeneratedColumn<int> beneficiaryId = GeneratedColumn<int>(
    'beneficiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beneficiaries (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    campaignId,
    beneficiaryId,
    status,
    amount,
    receivedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaign_beneficiaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CampaignBeneficiary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
        _campaignIdMeta,
        campaignId.isAcceptableOrUnknown(data['campaign_id']!, _campaignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('beneficiary_id')) {
      context.handle(
        _beneficiaryIdMeta,
        beneficiaryId.isAcceptableOrUnknown(
          data['beneficiary_id']!,
          _beneficiaryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_beneficiaryIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {campaignId, beneficiaryId},
  ];
  @override
  CampaignBeneficiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampaignBeneficiary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      campaignId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campaign_id'],
      )!,
      beneficiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beneficiary_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CampaignBeneficiariesTable createAlias(String alias) {
    return $CampaignBeneficiariesTable(attachedDatabase, alias);
  }
}

class CampaignBeneficiary extends DataClass
    implements Insertable<CampaignBeneficiary> {
  final int id;
  final int campaignId;
  final int beneficiaryId;
  final String status;
  final double? amount;
  final DateTime? receivedAt;
  final DateTime createdAt;
  const CampaignBeneficiary({
    required this.id,
    required this.campaignId,
    required this.beneficiaryId,
    required this.status,
    this.amount,
    this.receivedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['campaign_id'] = Variable<int>(campaignId);
    map['beneficiary_id'] = Variable<int>(beneficiaryId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || receivedAt != null) {
      map['received_at'] = Variable<DateTime>(receivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CampaignBeneficiariesCompanion toCompanion(bool nullToAbsent) {
    return CampaignBeneficiariesCompanion(
      id: Value(id),
      campaignId: Value(campaignId),
      beneficiaryId: Value(beneficiaryId),
      status: Value(status),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      receivedAt: receivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAt),
      createdAt: Value(createdAt),
    );
  }

  factory CampaignBeneficiary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampaignBeneficiary(
      id: serializer.fromJson<int>(json['id']),
      campaignId: serializer.fromJson<int>(json['campaignId']),
      beneficiaryId: serializer.fromJson<int>(json['beneficiaryId']),
      status: serializer.fromJson<String>(json['status']),
      amount: serializer.fromJson<double?>(json['amount']),
      receivedAt: serializer.fromJson<DateTime?>(json['receivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'campaignId': serializer.toJson<int>(campaignId),
      'beneficiaryId': serializer.toJson<int>(beneficiaryId),
      'status': serializer.toJson<String>(status),
      'amount': serializer.toJson<double?>(amount),
      'receivedAt': serializer.toJson<DateTime?>(receivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CampaignBeneficiary copyWith({
    int? id,
    int? campaignId,
    int? beneficiaryId,
    String? status,
    Value<double?> amount = const Value.absent(),
    Value<DateTime?> receivedAt = const Value.absent(),
    DateTime? createdAt,
  }) => CampaignBeneficiary(
    id: id ?? this.id,
    campaignId: campaignId ?? this.campaignId,
    beneficiaryId: beneficiaryId ?? this.beneficiaryId,
    status: status ?? this.status,
    amount: amount.present ? amount.value : this.amount,
    receivedAt: receivedAt.present ? receivedAt.value : this.receivedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  CampaignBeneficiary copyWithCompanion(CampaignBeneficiariesCompanion data) {
    return CampaignBeneficiary(
      id: data.id.present ? data.id.value : this.id,
      campaignId: data.campaignId.present
          ? data.campaignId.value
          : this.campaignId,
      beneficiaryId: data.beneficiaryId.present
          ? data.beneficiaryId.value
          : this.beneficiaryId,
      status: data.status.present ? data.status.value : this.status,
      amount: data.amount.present ? data.amount.value : this.amount,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CampaignBeneficiary(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    campaignId,
    beneficiaryId,
    status,
    amount,
    receivedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignBeneficiary &&
          other.id == this.id &&
          other.campaignId == this.campaignId &&
          other.beneficiaryId == this.beneficiaryId &&
          other.status == this.status &&
          other.amount == this.amount &&
          other.receivedAt == this.receivedAt &&
          other.createdAt == this.createdAt);
}

class CampaignBeneficiariesCompanion
    extends UpdateCompanion<CampaignBeneficiary> {
  final Value<int> id;
  final Value<int> campaignId;
  final Value<int> beneficiaryId;
  final Value<String> status;
  final Value<double?> amount;
  final Value<DateTime?> receivedAt;
  final Value<DateTime> createdAt;
  const CampaignBeneficiariesCompanion({
    this.id = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.beneficiaryId = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CampaignBeneficiariesCompanion.insert({
    this.id = const Value.absent(),
    required int campaignId,
    required int beneficiaryId,
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : campaignId = Value(campaignId),
       beneficiaryId = Value(beneficiaryId);
  static Insertable<CampaignBeneficiary> custom({
    Expression<int>? id,
    Expression<int>? campaignId,
    Expression<int>? beneficiaryId,
    Expression<String>? status,
    Expression<double>? amount,
    Expression<DateTime>? receivedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campaignId != null) 'campaign_id': campaignId,
      if (beneficiaryId != null) 'beneficiary_id': beneficiaryId,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (receivedAt != null) 'received_at': receivedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CampaignBeneficiariesCompanion copyWith({
    Value<int>? id,
    Value<int>? campaignId,
    Value<int>? beneficiaryId,
    Value<String>? status,
    Value<double?>? amount,
    Value<DateTime?>? receivedAt,
    Value<DateTime>? createdAt,
  }) {
    return CampaignBeneficiariesCompanion(
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      receivedAt: receivedAt ?? this.receivedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<int>(campaignId.value);
    }
    if (beneficiaryId.present) {
      map['beneficiary_id'] = Variable<int>(beneficiaryId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignBeneficiariesCompanion(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('beneficiaryId: $beneficiaryId, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VillagesTable villages = $VillagesTable(this);
  late final $ResidencePlacesTable residencePlaces = $ResidencePlacesTable(
    this,
  );
  late final $AidTypesTable aidTypes = $AidTypesTable(this);
  late final $BeneficiariesTable beneficiaries = $BeneficiariesTable(this);
  late final $HouseholdsTable households = $HouseholdsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $ElderlyTable elderly = $ElderlyTable(this);
  late final $MarriedTable married = $MarriedTable(this);
  late final $CampaignsTable campaigns = $CampaignsTable(this);
  late final $CampaignVillagesTable campaignVillages = $CampaignVillagesTable(
    this,
  );
  late final $CampaignResidencePlacesTable campaignResidencePlaces =
      $CampaignResidencePlacesTable(this);
  late final $CampaignBeneficiariesTable campaignBeneficiaries =
      $CampaignBeneficiariesTable(this);
  late final VillagesDao villagesDao = VillagesDao(this as AppDatabase);
  late final ResidencePlacesDao residencePlacesDao = ResidencePlacesDao(
    this as AppDatabase,
  );
  late final AidTypesDao aidTypesDao = AidTypesDao(this as AppDatabase);
  late final BeneficiariesDao beneficiariesDao = BeneficiariesDao(
    this as AppDatabase,
  );
  late final CampaignsDao campaignsDao = CampaignsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    villages,
    residencePlaces,
    aidTypes,
    beneficiaries,
    households,
    students,
    elderly,
    married,
    campaigns,
    campaignVillages,
    campaignResidencePlaces,
    campaignBeneficiaries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beneficiaries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('households', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beneficiaries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('students', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beneficiaries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('elderly', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beneficiaries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('married', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$VillagesTableCreateCompanionBuilder =
    VillagesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$VillagesTableUpdateCompanionBuilder =
    VillagesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$VillagesTableReferences
    extends BaseReferences<_$AppDatabase, $VillagesTable, Village> {
  $$VillagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BeneficiariesTable, List<Beneficiary>>
  _beneficiariesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.beneficiaries,
    aliasName: 'villages__id__beneficiaries__village_id',
  );

  $$BeneficiariesTableProcessedTableManager get beneficiariesRefs {
    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.villageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_beneficiariesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CampaignVillagesTable, List<CampaignVillage>>
  _campaignVillagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.campaignVillages,
    aliasName: 'villages__id__campaign_villages__village_id',
  );

  $$CampaignVillagesTableProcessedTableManager get campaignVillagesRefs {
    final manager = $$CampaignVillagesTableTableManager(
      $_db,
      $_db.campaignVillages,
    ).filter((f) => f.villageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignVillagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VillagesTableFilterComposer
    extends Composer<_$AppDatabase, $VillagesTable> {
  $$VillagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> beneficiariesRefs(
    Expression<bool> Function($$BeneficiariesTableFilterComposer f) f,
  ) {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.villageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> campaignVillagesRefs(
    Expression<bool> Function($$CampaignVillagesTableFilterComposer f) f,
  ) {
    final $$CampaignVillagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaignVillages,
      getReferencedColumn: (t) => t.villageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignVillagesTableFilterComposer(
            $db: $db,
            $table: $db.campaignVillages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VillagesTableOrderingComposer
    extends Composer<_$AppDatabase, $VillagesTable> {
  $$VillagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VillagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VillagesTable> {
  $$VillagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> beneficiariesRefs<T extends Object>(
    Expression<T> Function($$BeneficiariesTableAnnotationComposer a) f,
  ) {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.villageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> campaignVillagesRefs<T extends Object>(
    Expression<T> Function($$CampaignVillagesTableAnnotationComposer a) f,
  ) {
    final $$CampaignVillagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaignVillages,
      getReferencedColumn: (t) => t.villageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignVillagesTableAnnotationComposer(
            $db: $db,
            $table: $db.campaignVillages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VillagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VillagesTable,
          Village,
          $$VillagesTableFilterComposer,
          $$VillagesTableOrderingComposer,
          $$VillagesTableAnnotationComposer,
          $$VillagesTableCreateCompanionBuilder,
          $$VillagesTableUpdateCompanionBuilder,
          (Village, $$VillagesTableReferences),
          Village,
          PrefetchHooks Function({
            bool beneficiariesRefs,
            bool campaignVillagesRefs,
          })
        > {
  $$VillagesTableTableManager(_$AppDatabase db, $VillagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VillagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VillagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VillagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VillagesCompanion(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VillagesCompanion.insert(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VillagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({beneficiariesRefs = false, campaignVillagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (beneficiariesRefs) db.beneficiaries,
                    if (campaignVillagesRefs) db.campaignVillages,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (beneficiariesRefs)
                        await $_getPrefetchedData<
                          Village,
                          $VillagesTable,
                          Beneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$VillagesTableReferences
                              ._beneficiariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VillagesTableReferences(
                                db,
                                table,
                                p0,
                              ).beneficiariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.villageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignVillagesRefs)
                        await $_getPrefetchedData<
                          Village,
                          $VillagesTable,
                          CampaignVillage
                        >(
                          currentTable: table,
                          referencedTable: $$VillagesTableReferences
                              ._campaignVillagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VillagesTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignVillagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.villageId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VillagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VillagesTable,
      Village,
      $$VillagesTableFilterComposer,
      $$VillagesTableOrderingComposer,
      $$VillagesTableAnnotationComposer,
      $$VillagesTableCreateCompanionBuilder,
      $$VillagesTableUpdateCompanionBuilder,
      (Village, $$VillagesTableReferences),
      Village,
      PrefetchHooks Function({
        bool beneficiariesRefs,
        bool campaignVillagesRefs,
      })
    >;
typedef $$ResidencePlacesTableCreateCompanionBuilder =
    ResidencePlacesCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
    });
typedef $$ResidencePlacesTableUpdateCompanionBuilder =
    ResidencePlacesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

final class $$ResidencePlacesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ResidencePlacesTable, ResidencePlace> {
  $$ResidencePlacesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BeneficiariesTable, List<Beneficiary>>
  _beneficiariesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.beneficiaries,
    aliasName: 'residence_places__id__beneficiaries__residence_place_id',
  );

  $$BeneficiariesTableProcessedTableManager get beneficiariesRefs {
    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.residencePlaceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_beneficiariesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CampaignResidencePlacesTable,
    List<CampaignResidencePlace>
  >
  _campaignResidencePlacesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.campaignResidencePlaces,
    aliasName:
        'residence_places__id__campaign_residence_places__residence_place_id',
  );

  $$CampaignResidencePlacesTableProcessedTableManager
  get campaignResidencePlacesRefs {
    final manager = $$CampaignResidencePlacesTableTableManager(
      $_db,
      $_db.campaignResidencePlaces,
    ).filter((f) => f.residencePlaceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignResidencePlacesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ResidencePlacesTableFilterComposer
    extends Composer<_$AppDatabase, $ResidencePlacesTable> {
  $$ResidencePlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> beneficiariesRefs(
    Expression<bool> Function($$BeneficiariesTableFilterComposer f) f,
  ) {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.residencePlaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> campaignResidencePlacesRefs(
    Expression<bool> Function($$CampaignResidencePlacesTableFilterComposer f) f,
  ) {
    final $$CampaignResidencePlacesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignResidencePlaces,
          getReferencedColumn: (t) => t.residencePlaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignResidencePlacesTableFilterComposer(
                $db: $db,
                $table: $db.campaignResidencePlaces,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ResidencePlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $ResidencePlacesTable> {
  $$ResidencePlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResidencePlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResidencePlacesTable> {
  $$ResidencePlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> beneficiariesRefs<T extends Object>(
    Expression<T> Function($$BeneficiariesTableAnnotationComposer a) f,
  ) {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.residencePlaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> campaignResidencePlacesRefs<T extends Object>(
    Expression<T> Function($$CampaignResidencePlacesTableAnnotationComposer a)
    f,
  ) {
    final $$CampaignResidencePlacesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignResidencePlaces,
          getReferencedColumn: (t) => t.residencePlaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignResidencePlacesTableAnnotationComposer(
                $db: $db,
                $table: $db.campaignResidencePlaces,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ResidencePlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResidencePlacesTable,
          ResidencePlace,
          $$ResidencePlacesTableFilterComposer,
          $$ResidencePlacesTableOrderingComposer,
          $$ResidencePlacesTableAnnotationComposer,
          $$ResidencePlacesTableCreateCompanionBuilder,
          $$ResidencePlacesTableUpdateCompanionBuilder,
          (ResidencePlace, $$ResidencePlacesTableReferences),
          ResidencePlace,
          PrefetchHooks Function({
            bool beneficiariesRefs,
            bool campaignResidencePlacesRefs,
          })
        > {
  $$ResidencePlacesTableTableManager(
    _$AppDatabase db,
    $ResidencePlacesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResidencePlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResidencePlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResidencePlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ResidencePlacesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ResidencePlacesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResidencePlacesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                beneficiariesRefs = false,
                campaignResidencePlacesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (beneficiariesRefs) db.beneficiaries,
                    if (campaignResidencePlacesRefs) db.campaignResidencePlaces,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (beneficiariesRefs)
                        await $_getPrefetchedData<
                          ResidencePlace,
                          $ResidencePlacesTable,
                          Beneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$ResidencePlacesTableReferences
                              ._beneficiariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ResidencePlacesTableReferences(
                                db,
                                table,
                                p0,
                              ).beneficiariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.residencePlaceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignResidencePlacesRefs)
                        await $_getPrefetchedData<
                          ResidencePlace,
                          $ResidencePlacesTable,
                          CampaignResidencePlace
                        >(
                          currentTable: table,
                          referencedTable: $$ResidencePlacesTableReferences
                              ._campaignResidencePlacesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ResidencePlacesTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignResidencePlacesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.residencePlaceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ResidencePlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResidencePlacesTable,
      ResidencePlace,
      $$ResidencePlacesTableFilterComposer,
      $$ResidencePlacesTableOrderingComposer,
      $$ResidencePlacesTableAnnotationComposer,
      $$ResidencePlacesTableCreateCompanionBuilder,
      $$ResidencePlacesTableUpdateCompanionBuilder,
      (ResidencePlace, $$ResidencePlacesTableReferences),
      ResidencePlace,
      PrefetchHooks Function({
        bool beneficiariesRefs,
        bool campaignResidencePlacesRefs,
      })
    >;
typedef $$AidTypesTableCreateCompanionBuilder =
    AidTypesCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> requiresAmount,
      Value<DateTime> createdAt,
    });
typedef $$AidTypesTableUpdateCompanionBuilder =
    AidTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> requiresAmount,
      Value<DateTime> createdAt,
    });

final class $$AidTypesTableReferences
    extends BaseReferences<_$AppDatabase, $AidTypesTable, AidType> {
  $$AidTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CampaignsTable, List<Campaign>>
  _campaignsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.campaigns,
    aliasName: 'aid_types__id__campaigns__aid_type_id',
  );

  $$CampaignsTableProcessedTableManager get campaignsRefs {
    final manager = $$CampaignsTableTableManager(
      $_db,
      $_db.campaigns,
    ).filter((f) => f.aidTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_campaignsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AidTypesTableFilterComposer
    extends Composer<_$AppDatabase, $AidTypesTable> {
  $$AidTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresAmount => $composableBuilder(
    column: $table.requiresAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> campaignsRefs(
    Expression<bool> Function($$CampaignsTableFilterComposer f) f,
  ) {
    final $$CampaignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.aidTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableFilterComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AidTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $AidTypesTable> {
  $$AidTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresAmount => $composableBuilder(
    column: $table.requiresAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AidTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AidTypesTable> {
  $$AidTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get requiresAmount => $composableBuilder(
    column: $table.requiresAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> campaignsRefs<T extends Object>(
    Expression<T> Function($$CampaignsTableAnnotationComposer a) f,
  ) {
    final $$CampaignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.aidTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableAnnotationComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AidTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AidTypesTable,
          AidType,
          $$AidTypesTableFilterComposer,
          $$AidTypesTableOrderingComposer,
          $$AidTypesTableAnnotationComposer,
          $$AidTypesTableCreateCompanionBuilder,
          $$AidTypesTableUpdateCompanionBuilder,
          (AidType, $$AidTypesTableReferences),
          AidType,
          PrefetchHooks Function({bool campaignsRefs})
        > {
  $$AidTypesTableTableManager(_$AppDatabase db, $AidTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AidTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AidTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AidTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> requiresAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AidTypesCompanion(
                id: id,
                name: name,
                requiresAmount: requiresAmount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> requiresAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AidTypesCompanion.insert(
                id: id,
                name: name,
                requiresAmount: requiresAmount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AidTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({campaignsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (campaignsRefs) db.campaigns],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (campaignsRefs)
                    await $_getPrefetchedData<
                      AidType,
                      $AidTypesTable,
                      Campaign
                    >(
                      currentTable: table,
                      referencedTable: $$AidTypesTableReferences
                          ._campaignsRefsTable(db),
                      managerFromTypedResult: (p0) => $$AidTypesTableReferences(
                        db,
                        table,
                        p0,
                      ).campaignsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.aidTypeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AidTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AidTypesTable,
      AidType,
      $$AidTypesTableFilterComposer,
      $$AidTypesTableOrderingComposer,
      $$AidTypesTableAnnotationComposer,
      $$AidTypesTableCreateCompanionBuilder,
      $$AidTypesTableUpdateCompanionBuilder,
      (AidType, $$AidTypesTableReferences),
      AidType,
      PrefetchHooks Function({bool campaignsRefs})
    >;
typedef $$BeneficiariesTableCreateCompanionBuilder =
    BeneficiariesCompanion Function({
      Value<int> id,
      required String beneficiaryType,
      required String primaryName,
      required int villageId,
      required int residencePlaceId,
      Value<String?> phone,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BeneficiariesTableUpdateCompanionBuilder =
    BeneficiariesCompanion Function({
      Value<int> id,
      Value<String> beneficiaryType,
      Value<String> primaryName,
      Value<int> villageId,
      Value<int> residencePlaceId,
      Value<String?> phone,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BeneficiariesTableReferences
    extends BaseReferences<_$AppDatabase, $BeneficiariesTable, Beneficiary> {
  $$BeneficiariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VillagesTable _villageIdTable(_$AppDatabase db) =>
      db.villages.createAlias('beneficiaries__village_id__villages__id');

  $$VillagesTableProcessedTableManager get villageId {
    final $_column = $_itemColumn<int>('village_id')!;

    final manager = $$VillagesTableTableManager(
      $_db,
      $_db.villages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ResidencePlacesTable _residencePlaceIdTable(_$AppDatabase db) => db
      .residencePlaces
      .createAlias('beneficiaries__residence_place_id__residence_places__id');

  $$ResidencePlacesTableProcessedTableManager get residencePlaceId {
    final $_column = $_itemColumn<int>('residence_place_id')!;

    final manager = $$ResidencePlacesTableTableManager(
      $_db,
      $_db.residencePlaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residencePlaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HouseholdsTable, List<Household>>
  _householdsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.households,
    aliasName: 'beneficiaries__id__households__beneficiary_id',
  );

  $$HouseholdsTableProcessedTableManager get householdsRefs {
    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.beneficiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_householdsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.students,
    aliasName: 'beneficiaries__id__students__beneficiary_id',
  );

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.beneficiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ElderlyTable, List<ElderlyBeneficiary>>
  _elderlyRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.elderly,
    aliasName: 'beneficiaries__id__elderly__beneficiary_id',
  );

  $$ElderlyTableProcessedTableManager get elderlyRefs {
    final manager = $$ElderlyTableTableManager(
      $_db,
      $_db.elderly,
    ).filter((f) => f.beneficiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_elderlyRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MarriedTable, List<MarriedBeneficiary>>
  _marriedRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.married,
    aliasName: 'beneficiaries__id__married__beneficiary_id',
  );

  $$MarriedTableProcessedTableManager get marriedRefs {
    final manager = $$MarriedTableTableManager(
      $_db,
      $_db.married,
    ).filter((f) => f.beneficiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_marriedRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CampaignBeneficiariesTable,
    List<CampaignBeneficiary>
  >
  _campaignBeneficiariesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.campaignBeneficiaries,
        aliasName: 'beneficiaries__id__campaign_beneficiaries__beneficiary_id',
      );

  $$CampaignBeneficiariesTableProcessedTableManager
  get campaignBeneficiariesRefs {
    final manager = $$CampaignBeneficiariesTableTableManager(
      $_db,
      $_db.campaignBeneficiaries,
    ).filter((f) => f.beneficiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignBeneficiariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BeneficiariesTableFilterComposer
    extends Composer<_$AppDatabase, $BeneficiariesTable> {
  $$BeneficiariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryName => $composableBuilder(
    column: $table.primaryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VillagesTableFilterComposer get villageId {
    final $$VillagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableFilterComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableFilterComposer get residencePlaceId {
    final $$ResidencePlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableFilterComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> householdsRefs(
    Expression<bool> Function($$HouseholdsTableFilterComposer f) f,
  ) {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentsRefs(
    Expression<bool> Function($$StudentsTableFilterComposer f) f,
  ) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> elderlyRefs(
    Expression<bool> Function($$ElderlyTableFilterComposer f) f,
  ) {
    final $$ElderlyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.elderly,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElderlyTableFilterComposer(
            $db: $db,
            $table: $db.elderly,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> marriedRefs(
    Expression<bool> Function($$MarriedTableFilterComposer f) f,
  ) {
    final $$MarriedTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.married,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MarriedTableFilterComposer(
            $db: $db,
            $table: $db.married,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> campaignBeneficiariesRefs(
    Expression<bool> Function($$CampaignBeneficiariesTableFilterComposer f) f,
  ) {
    final $$CampaignBeneficiariesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignBeneficiaries,
          getReferencedColumn: (t) => t.beneficiaryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignBeneficiariesTableFilterComposer(
                $db: $db,
                $table: $db.campaignBeneficiaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeneficiariesTableOrderingComposer
    extends Composer<_$AppDatabase, $BeneficiariesTable> {
  $$BeneficiariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryName => $composableBuilder(
    column: $table.primaryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VillagesTableOrderingComposer get villageId {
    final $$VillagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableOrderingComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableOrderingComposer get residencePlaceId {
    final $$ResidencePlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableOrderingComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeneficiariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeneficiariesTable> {
  $$BeneficiariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryName => $composableBuilder(
    column: $table.primaryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VillagesTableAnnotationComposer get villageId {
    final $$VillagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableAnnotationComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableAnnotationComposer get residencePlaceId {
    final $$ResidencePlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> householdsRefs<T extends Object>(
    Expression<T> Function($$HouseholdsTableAnnotationComposer a) f,
  ) {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studentsRefs<T extends Object>(
    Expression<T> Function($$StudentsTableAnnotationComposer a) f,
  ) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> elderlyRefs<T extends Object>(
    Expression<T> Function($$ElderlyTableAnnotationComposer a) f,
  ) {
    final $$ElderlyTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.elderly,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElderlyTableAnnotationComposer(
            $db: $db,
            $table: $db.elderly,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> marriedRefs<T extends Object>(
    Expression<T> Function($$MarriedTableAnnotationComposer a) f,
  ) {
    final $$MarriedTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.married,
      getReferencedColumn: (t) => t.beneficiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MarriedTableAnnotationComposer(
            $db: $db,
            $table: $db.married,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> campaignBeneficiariesRefs<T extends Object>(
    Expression<T> Function($$CampaignBeneficiariesTableAnnotationComposer a) f,
  ) {
    final $$CampaignBeneficiariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignBeneficiaries,
          getReferencedColumn: (t) => t.beneficiaryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignBeneficiariesTableAnnotationComposer(
                $db: $db,
                $table: $db.campaignBeneficiaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeneficiariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeneficiariesTable,
          Beneficiary,
          $$BeneficiariesTableFilterComposer,
          $$BeneficiariesTableOrderingComposer,
          $$BeneficiariesTableAnnotationComposer,
          $$BeneficiariesTableCreateCompanionBuilder,
          $$BeneficiariesTableUpdateCompanionBuilder,
          (Beneficiary, $$BeneficiariesTableReferences),
          Beneficiary,
          PrefetchHooks Function({
            bool villageId,
            bool residencePlaceId,
            bool householdsRefs,
            bool studentsRefs,
            bool elderlyRefs,
            bool marriedRefs,
            bool campaignBeneficiariesRefs,
          })
        > {
  $$BeneficiariesTableTableManager(_$AppDatabase db, $BeneficiariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BeneficiariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BeneficiariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BeneficiariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> beneficiaryType = const Value.absent(),
                Value<String> primaryName = const Value.absent(),
                Value<int> villageId = const Value.absent(),
                Value<int> residencePlaceId = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BeneficiariesCompanion(
                id: id,
                beneficiaryType: beneficiaryType,
                primaryName: primaryName,
                villageId: villageId,
                residencePlaceId: residencePlaceId,
                phone: phone,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String beneficiaryType,
                required String primaryName,
                required int villageId,
                required int residencePlaceId,
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BeneficiariesCompanion.insert(
                id: id,
                beneficiaryType: beneficiaryType,
                primaryName: primaryName,
                villageId: villageId,
                residencePlaceId: residencePlaceId,
                phone: phone,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BeneficiariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                villageId = false,
                residencePlaceId = false,
                householdsRefs = false,
                studentsRefs = false,
                elderlyRefs = false,
                marriedRefs = false,
                campaignBeneficiariesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (householdsRefs) db.households,
                    if (studentsRefs) db.students,
                    if (elderlyRefs) db.elderly,
                    if (marriedRefs) db.married,
                    if (campaignBeneficiariesRefs) db.campaignBeneficiaries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (villageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.villageId,
                                    referencedTable:
                                        $$BeneficiariesTableReferences
                                            ._villageIdTable(db),
                                    referencedColumn:
                                        $$BeneficiariesTableReferences
                                            ._villageIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (residencePlaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.residencePlaceId,
                                    referencedTable:
                                        $$BeneficiariesTableReferences
                                            ._residencePlaceIdTable(db),
                                    referencedColumn:
                                        $$BeneficiariesTableReferences
                                            ._residencePlaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (householdsRefs)
                        await $_getPrefetchedData<
                          Beneficiary,
                          $BeneficiariesTable,
                          Household
                        >(
                          currentTable: table,
                          referencedTable: $$BeneficiariesTableReferences
                              ._householdsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeneficiariesTableReferences(
                                db,
                                table,
                                p0,
                              ).householdsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studentsRefs)
                        await $_getPrefetchedData<
                          Beneficiary,
                          $BeneficiariesTable,
                          Student
                        >(
                          currentTable: table,
                          referencedTable: $$BeneficiariesTableReferences
                              ._studentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeneficiariesTableReferences(
                                db,
                                table,
                                p0,
                              ).studentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (elderlyRefs)
                        await $_getPrefetchedData<
                          Beneficiary,
                          $BeneficiariesTable,
                          ElderlyBeneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$BeneficiariesTableReferences
                              ._elderlyRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeneficiariesTableReferences(
                                db,
                                table,
                                p0,
                              ).elderlyRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (marriedRefs)
                        await $_getPrefetchedData<
                          Beneficiary,
                          $BeneficiariesTable,
                          MarriedBeneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$BeneficiariesTableReferences
                              ._marriedRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeneficiariesTableReferences(
                                db,
                                table,
                                p0,
                              ).marriedRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignBeneficiariesRefs)
                        await $_getPrefetchedData<
                          Beneficiary,
                          $BeneficiariesTable,
                          CampaignBeneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$BeneficiariesTableReferences
                              ._campaignBeneficiariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeneficiariesTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignBeneficiariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BeneficiariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeneficiariesTable,
      Beneficiary,
      $$BeneficiariesTableFilterComposer,
      $$BeneficiariesTableOrderingComposer,
      $$BeneficiariesTableAnnotationComposer,
      $$BeneficiariesTableCreateCompanionBuilder,
      $$BeneficiariesTableUpdateCompanionBuilder,
      (Beneficiary, $$BeneficiariesTableReferences),
      Beneficiary,
      PrefetchHooks Function({
        bool villageId,
        bool residencePlaceId,
        bool householdsRefs,
        bool studentsRefs,
        bool elderlyRefs,
        bool marriedRefs,
        bool campaignBeneficiariesRefs,
      })
    >;
typedef $$HouseholdsTableCreateCompanionBuilder =
    HouseholdsCompanion Function({
      Value<int> beneficiaryId,
      Value<String?> wifeName,
      Value<int> familyMembersCount,
    });
typedef $$HouseholdsTableUpdateCompanionBuilder =
    HouseholdsCompanion Function({
      Value<int> beneficiaryId,
      Value<String?> wifeName,
      Value<int> familyMembersCount,
    });

final class $$HouseholdsTableReferences
    extends BaseReferences<_$AppDatabase, $HouseholdsTable, Household> {
  $$HouseholdsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeneficiariesTable _beneficiaryIdTable(_$AppDatabase db) => db
      .beneficiaries
      .createAlias('households__beneficiary_id__beneficiaries__id');

  $$BeneficiariesTableProcessedTableManager get beneficiaryId {
    final $_column = $_itemColumn<int>('beneficiary_id')!;

    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HouseholdsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wifeName => $composableBuilder(
    column: $table.wifeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get familyMembersCount => $composableBuilder(
    column: $table.familyMembersCount,
    builder: (column) => ColumnFilters(column),
  );

  $$BeneficiariesTableFilterComposer get beneficiaryId {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wifeName => $composableBuilder(
    column: $table.wifeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get familyMembersCount => $composableBuilder(
    column: $table.familyMembersCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeneficiariesTableOrderingComposer get beneficiaryId {
    final $$BeneficiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableOrderingComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wifeName =>
      $composableBuilder(column: $table.wifeName, builder: (column) => column);

  GeneratedColumn<int> get familyMembersCount => $composableBuilder(
    column: $table.familyMembersCount,
    builder: (column) => column,
  );

  $$BeneficiariesTableAnnotationComposer get beneficiaryId {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HouseholdsTable,
          Household,
          $$HouseholdsTableFilterComposer,
          $$HouseholdsTableOrderingComposer,
          $$HouseholdsTableAnnotationComposer,
          $$HouseholdsTableCreateCompanionBuilder,
          $$HouseholdsTableUpdateCompanionBuilder,
          (Household, $$HouseholdsTableReferences),
          Household,
          PrefetchHooks Function({bool beneficiaryId})
        > {
  $$HouseholdsTableTableManager(_$AppDatabase db, $HouseholdsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                Value<String?> wifeName = const Value.absent(),
                Value<int> familyMembersCount = const Value.absent(),
              }) => HouseholdsCompanion(
                beneficiaryId: beneficiaryId,
                wifeName: wifeName,
                familyMembersCount: familyMembersCount,
              ),
          createCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                Value<String?> wifeName = const Value.absent(),
                Value<int> familyMembersCount = const Value.absent(),
              }) => HouseholdsCompanion.insert(
                beneficiaryId: beneficiaryId,
                wifeName: wifeName,
                familyMembersCount: familyMembersCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HouseholdsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beneficiaryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (beneficiaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beneficiaryId,
                                referencedTable: $$HouseholdsTableReferences
                                    ._beneficiaryIdTable(db),
                                referencedColumn: $$HouseholdsTableReferences
                                    ._beneficiaryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HouseholdsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HouseholdsTable,
      Household,
      $$HouseholdsTableFilterComposer,
      $$HouseholdsTableOrderingComposer,
      $$HouseholdsTableAnnotationComposer,
      $$HouseholdsTableCreateCompanionBuilder,
      $$HouseholdsTableUpdateCompanionBuilder,
      (Household, $$HouseholdsTableReferences),
      Household,
      PrefetchHooks Function({bool beneficiaryId})
    >;
typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> beneficiaryId,
      required String schoolName,
      required String educationStage,
      required String classGrade,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> beneficiaryId,
      Value<String> schoolName,
      Value<String> educationStage,
      Value<String> classGrade,
    });

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeneficiariesTable _beneficiaryIdTable(_$AppDatabase db) => db
      .beneficiaries
      .createAlias('students__beneficiary_id__beneficiaries__id');

  $$BeneficiariesTableProcessedTableManager get beneficiaryId {
    final $_column = $_itemColumn<int>('beneficiary_id')!;

    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get educationStage => $composableBuilder(
    column: $table.educationStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classGrade => $composableBuilder(
    column: $table.classGrade,
    builder: (column) => ColumnFilters(column),
  );

  $$BeneficiariesTableFilterComposer get beneficiaryId {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get educationStage => $composableBuilder(
    column: $table.educationStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classGrade => $composableBuilder(
    column: $table.classGrade,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeneficiariesTableOrderingComposer get beneficiaryId {
    final $$BeneficiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableOrderingComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get educationStage => $composableBuilder(
    column: $table.educationStage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get classGrade => $composableBuilder(
    column: $table.classGrade,
    builder: (column) => column,
  );

  $$BeneficiariesTableAnnotationComposer get beneficiaryId {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, $$StudentsTableReferences),
          Student,
          PrefetchHooks Function({bool beneficiaryId})
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                Value<String> schoolName = const Value.absent(),
                Value<String> educationStage = const Value.absent(),
                Value<String> classGrade = const Value.absent(),
              }) => StudentsCompanion(
                beneficiaryId: beneficiaryId,
                schoolName: schoolName,
                educationStage: educationStage,
                classGrade: classGrade,
              ),
          createCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                required String schoolName,
                required String educationStage,
                required String classGrade,
              }) => StudentsCompanion.insert(
                beneficiaryId: beneficiaryId,
                schoolName: schoolName,
                educationStage: educationStage,
                classGrade: classGrade,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beneficiaryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (beneficiaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beneficiaryId,
                                referencedTable: $$StudentsTableReferences
                                    ._beneficiaryIdTable(db),
                                referencedColumn: $$StudentsTableReferences
                                    ._beneficiaryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, $$StudentsTableReferences),
      Student,
      PrefetchHooks Function({bool beneficiaryId})
    >;
typedef $$ElderlyTableCreateCompanionBuilder =
    ElderlyCompanion Function({Value<int> beneficiaryId, required int age});
typedef $$ElderlyTableUpdateCompanionBuilder =
    ElderlyCompanion Function({Value<int> beneficiaryId, Value<int> age});

final class $$ElderlyTableReferences
    extends BaseReferences<_$AppDatabase, $ElderlyTable, ElderlyBeneficiary> {
  $$ElderlyTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeneficiariesTable _beneficiaryIdTable(_$AppDatabase db) => db
      .beneficiaries
      .createAlias('elderly__beneficiary_id__beneficiaries__id');

  $$BeneficiariesTableProcessedTableManager get beneficiaryId {
    final $_column = $_itemColumn<int>('beneficiary_id')!;

    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ElderlyTableFilterComposer
    extends Composer<_$AppDatabase, $ElderlyTable> {
  $$ElderlyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  $$BeneficiariesTableFilterComposer get beneficiaryId {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElderlyTableOrderingComposer
    extends Composer<_$AppDatabase, $ElderlyTable> {
  $$ElderlyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeneficiariesTableOrderingComposer get beneficiaryId {
    final $$BeneficiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableOrderingComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElderlyTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElderlyTable> {
  $$ElderlyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  $$BeneficiariesTableAnnotationComposer get beneficiaryId {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElderlyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElderlyTable,
          ElderlyBeneficiary,
          $$ElderlyTableFilterComposer,
          $$ElderlyTableOrderingComposer,
          $$ElderlyTableAnnotationComposer,
          $$ElderlyTableCreateCompanionBuilder,
          $$ElderlyTableUpdateCompanionBuilder,
          (ElderlyBeneficiary, $$ElderlyTableReferences),
          ElderlyBeneficiary,
          PrefetchHooks Function({bool beneficiaryId})
        > {
  $$ElderlyTableTableManager(_$AppDatabase db, $ElderlyTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElderlyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElderlyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElderlyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                Value<int> age = const Value.absent(),
              }) => ElderlyCompanion(beneficiaryId: beneficiaryId, age: age),
          createCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                required int age,
              }) => ElderlyCompanion.insert(
                beneficiaryId: beneficiaryId,
                age: age,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ElderlyTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beneficiaryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (beneficiaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beneficiaryId,
                                referencedTable: $$ElderlyTableReferences
                                    ._beneficiaryIdTable(db),
                                referencedColumn: $$ElderlyTableReferences
                                    ._beneficiaryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ElderlyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElderlyTable,
      ElderlyBeneficiary,
      $$ElderlyTableFilterComposer,
      $$ElderlyTableOrderingComposer,
      $$ElderlyTableAnnotationComposer,
      $$ElderlyTableCreateCompanionBuilder,
      $$ElderlyTableUpdateCompanionBuilder,
      (ElderlyBeneficiary, $$ElderlyTableReferences),
      ElderlyBeneficiary,
      PrefetchHooks Function({bool beneficiaryId})
    >;
typedef $$MarriedTableCreateCompanionBuilder =
    MarriedCompanion Function({
      Value<int> beneficiaryId,
      required DateTime marriageDate,
    });
typedef $$MarriedTableUpdateCompanionBuilder =
    MarriedCompanion Function({
      Value<int> beneficiaryId,
      Value<DateTime> marriageDate,
    });

final class $$MarriedTableReferences
    extends BaseReferences<_$AppDatabase, $MarriedTable, MarriedBeneficiary> {
  $$MarriedTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeneficiariesTable _beneficiaryIdTable(_$AppDatabase db) => db
      .beneficiaries
      .createAlias('married__beneficiary_id__beneficiaries__id');

  $$BeneficiariesTableProcessedTableManager get beneficiaryId {
    final $_column = $_itemColumn<int>('beneficiary_id')!;

    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MarriedTableFilterComposer
    extends Composer<_$AppDatabase, $MarriedTable> {
  $$MarriedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => ColumnFilters(column),
  );

  $$BeneficiariesTableFilterComposer get beneficiaryId {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MarriedTableOrderingComposer
    extends Composer<_$AppDatabase, $MarriedTable> {
  $$MarriedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeneficiariesTableOrderingComposer get beneficiaryId {
    final $$BeneficiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableOrderingComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MarriedTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarriedTable> {
  $$MarriedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => column,
  );

  $$BeneficiariesTableAnnotationComposer get beneficiaryId {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MarriedTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MarriedTable,
          MarriedBeneficiary,
          $$MarriedTableFilterComposer,
          $$MarriedTableOrderingComposer,
          $$MarriedTableAnnotationComposer,
          $$MarriedTableCreateCompanionBuilder,
          $$MarriedTableUpdateCompanionBuilder,
          (MarriedBeneficiary, $$MarriedTableReferences),
          MarriedBeneficiary,
          PrefetchHooks Function({bool beneficiaryId})
        > {
  $$MarriedTableTableManager(_$AppDatabase db, $MarriedTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarriedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MarriedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MarriedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                Value<DateTime> marriageDate = const Value.absent(),
              }) => MarriedCompanion(
                beneficiaryId: beneficiaryId,
                marriageDate: marriageDate,
              ),
          createCompanionCallback:
              ({
                Value<int> beneficiaryId = const Value.absent(),
                required DateTime marriageDate,
              }) => MarriedCompanion.insert(
                beneficiaryId: beneficiaryId,
                marriageDate: marriageDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MarriedTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beneficiaryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (beneficiaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beneficiaryId,
                                referencedTable: $$MarriedTableReferences
                                    ._beneficiaryIdTable(db),
                                referencedColumn: $$MarriedTableReferences
                                    ._beneficiaryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MarriedTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MarriedTable,
      MarriedBeneficiary,
      $$MarriedTableFilterComposer,
      $$MarriedTableOrderingComposer,
      $$MarriedTableAnnotationComposer,
      $$MarriedTableCreateCompanionBuilder,
      $$MarriedTableUpdateCompanionBuilder,
      (MarriedBeneficiary, $$MarriedTableReferences),
      MarriedBeneficiary,
      PrefetchHooks Function({bool beneficiaryId})
    >;
typedef $$CampaignsTableCreateCompanionBuilder =
    CampaignsCompanion Function({
      Value<int> id,
      required String name,
      required String beneficiaryType,
      required int aidTypeId,
      Value<double?> amountPerBeneficiary,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$CampaignsTableUpdateCompanionBuilder =
    CampaignsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> beneficiaryType,
      Value<int> aidTypeId,
      Value<double?> amountPerBeneficiary,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$CampaignsTableReferences
    extends BaseReferences<_$AppDatabase, $CampaignsTable, Campaign> {
  $$CampaignsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AidTypesTable _aidTypeIdTable(_$AppDatabase db) =>
      db.aidTypes.createAlias('campaigns__aid_type_id__aid_types__id');

  $$AidTypesTableProcessedTableManager get aidTypeId {
    final $_column = $_itemColumn<int>('aid_type_id')!;

    final manager = $$AidTypesTableTableManager(
      $_db,
      $_db.aidTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aidTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CampaignVillagesTable, List<CampaignVillage>>
  _campaignVillagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.campaignVillages,
    aliasName: 'campaigns__id__campaign_villages__campaign_id',
  );

  $$CampaignVillagesTableProcessedTableManager get campaignVillagesRefs {
    final manager = $$CampaignVillagesTableTableManager(
      $_db,
      $_db.campaignVillages,
    ).filter((f) => f.campaignId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignVillagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CampaignResidencePlacesTable,
    List<CampaignResidencePlace>
  >
  _campaignResidencePlacesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.campaignResidencePlaces,
        aliasName: 'campaigns__id__campaign_residence_places__campaign_id',
      );

  $$CampaignResidencePlacesTableProcessedTableManager
  get campaignResidencePlacesRefs {
    final manager = $$CampaignResidencePlacesTableTableManager(
      $_db,
      $_db.campaignResidencePlaces,
    ).filter((f) => f.campaignId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignResidencePlacesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CampaignBeneficiariesTable,
    List<CampaignBeneficiary>
  >
  _campaignBeneficiariesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.campaignBeneficiaries,
        aliasName: 'campaigns__id__campaign_beneficiaries__campaign_id',
      );

  $$CampaignBeneficiariesTableProcessedTableManager
  get campaignBeneficiariesRefs {
    final manager = $$CampaignBeneficiariesTableTableManager(
      $_db,
      $_db.campaignBeneficiaries,
    ).filter((f) => f.campaignId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _campaignBeneficiariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CampaignsTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPerBeneficiary => $composableBuilder(
    column: $table.amountPerBeneficiary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AidTypesTableFilterComposer get aidTypeId {
    final $$AidTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aidTypeId,
      referencedTable: $db.aidTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AidTypesTableFilterComposer(
            $db: $db,
            $table: $db.aidTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> campaignVillagesRefs(
    Expression<bool> Function($$CampaignVillagesTableFilterComposer f) f,
  ) {
    final $$CampaignVillagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaignVillages,
      getReferencedColumn: (t) => t.campaignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignVillagesTableFilterComposer(
            $db: $db,
            $table: $db.campaignVillages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> campaignResidencePlacesRefs(
    Expression<bool> Function($$CampaignResidencePlacesTableFilterComposer f) f,
  ) {
    final $$CampaignResidencePlacesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignResidencePlaces,
          getReferencedColumn: (t) => t.campaignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignResidencePlacesTableFilterComposer(
                $db: $db,
                $table: $db.campaignResidencePlaces,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> campaignBeneficiariesRefs(
    Expression<bool> Function($$CampaignBeneficiariesTableFilterComposer f) f,
  ) {
    final $$CampaignBeneficiariesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignBeneficiaries,
          getReferencedColumn: (t) => t.campaignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignBeneficiariesTableFilterComposer(
                $db: $db,
                $table: $db.campaignBeneficiaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CampaignsTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPerBeneficiary => $composableBuilder(
    column: $table.amountPerBeneficiary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AidTypesTableOrderingComposer get aidTypeId {
    final $$AidTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aidTypeId,
      referencedTable: $db.aidTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AidTypesTableOrderingComposer(
            $db: $db,
            $table: $db.aidTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get beneficiaryType => $composableBuilder(
    column: $table.beneficiaryType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountPerBeneficiary => $composableBuilder(
    column: $table.amountPerBeneficiary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AidTypesTableAnnotationComposer get aidTypeId {
    final $$AidTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aidTypeId,
      referencedTable: $db.aidTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AidTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.aidTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> campaignVillagesRefs<T extends Object>(
    Expression<T> Function($$CampaignVillagesTableAnnotationComposer a) f,
  ) {
    final $$CampaignVillagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaignVillages,
      getReferencedColumn: (t) => t.campaignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignVillagesTableAnnotationComposer(
            $db: $db,
            $table: $db.campaignVillages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> campaignResidencePlacesRefs<T extends Object>(
    Expression<T> Function($$CampaignResidencePlacesTableAnnotationComposer a)
    f,
  ) {
    final $$CampaignResidencePlacesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignResidencePlaces,
          getReferencedColumn: (t) => t.campaignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignResidencePlacesTableAnnotationComposer(
                $db: $db,
                $table: $db.campaignResidencePlaces,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> campaignBeneficiariesRefs<T extends Object>(
    Expression<T> Function($$CampaignBeneficiariesTableAnnotationComposer a) f,
  ) {
    final $$CampaignBeneficiariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.campaignBeneficiaries,
          getReferencedColumn: (t) => t.campaignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CampaignBeneficiariesTableAnnotationComposer(
                $db: $db,
                $table: $db.campaignBeneficiaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CampaignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignsTable,
          Campaign,
          $$CampaignsTableFilterComposer,
          $$CampaignsTableOrderingComposer,
          $$CampaignsTableAnnotationComposer,
          $$CampaignsTableCreateCompanionBuilder,
          $$CampaignsTableUpdateCompanionBuilder,
          (Campaign, $$CampaignsTableReferences),
          Campaign,
          PrefetchHooks Function({
            bool aidTypeId,
            bool campaignVillagesRefs,
            bool campaignResidencePlacesRefs,
            bool campaignBeneficiariesRefs,
          })
        > {
  $$CampaignsTableTableManager(_$AppDatabase db, $CampaignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampaignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampaignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> beneficiaryType = const Value.absent(),
                Value<int> aidTypeId = const Value.absent(),
                Value<double?> amountPerBeneficiary = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CampaignsCompanion(
                id: id,
                name: name,
                beneficiaryType: beneficiaryType,
                aidTypeId: aidTypeId,
                amountPerBeneficiary: amountPerBeneficiary,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String beneficiaryType,
                required int aidTypeId,
                Value<double?> amountPerBeneficiary = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CampaignsCompanion.insert(
                id: id,
                name: name,
                beneficiaryType: beneficiaryType,
                aidTypeId: aidTypeId,
                amountPerBeneficiary: amountPerBeneficiary,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampaignsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aidTypeId = false,
                campaignVillagesRefs = false,
                campaignResidencePlacesRefs = false,
                campaignBeneficiariesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (campaignVillagesRefs) db.campaignVillages,
                    if (campaignResidencePlacesRefs) db.campaignResidencePlaces,
                    if (campaignBeneficiariesRefs) db.campaignBeneficiaries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (aidTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.aidTypeId,
                                    referencedTable: $$CampaignsTableReferences
                                        ._aidTypeIdTable(db),
                                    referencedColumn: $$CampaignsTableReferences
                                        ._aidTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (campaignVillagesRefs)
                        await $_getPrefetchedData<
                          Campaign,
                          $CampaignsTable,
                          CampaignVillage
                        >(
                          currentTable: table,
                          referencedTable: $$CampaignsTableReferences
                              ._campaignVillagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampaignsTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignVillagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campaignId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignResidencePlacesRefs)
                        await $_getPrefetchedData<
                          Campaign,
                          $CampaignsTable,
                          CampaignResidencePlace
                        >(
                          currentTable: table,
                          referencedTable: $$CampaignsTableReferences
                              ._campaignResidencePlacesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampaignsTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignResidencePlacesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campaignId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignBeneficiariesRefs)
                        await $_getPrefetchedData<
                          Campaign,
                          $CampaignsTable,
                          CampaignBeneficiary
                        >(
                          currentTable: table,
                          referencedTable: $$CampaignsTableReferences
                              ._campaignBeneficiariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CampaignsTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignBeneficiariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.campaignId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CampaignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignsTable,
      Campaign,
      $$CampaignsTableFilterComposer,
      $$CampaignsTableOrderingComposer,
      $$CampaignsTableAnnotationComposer,
      $$CampaignsTableCreateCompanionBuilder,
      $$CampaignsTableUpdateCompanionBuilder,
      (Campaign, $$CampaignsTableReferences),
      Campaign,
      PrefetchHooks Function({
        bool aidTypeId,
        bool campaignVillagesRefs,
        bool campaignResidencePlacesRefs,
        bool campaignBeneficiariesRefs,
      })
    >;
typedef $$CampaignVillagesTableCreateCompanionBuilder =
    CampaignVillagesCompanion Function({
      required int campaignId,
      required int villageId,
      Value<int> rowid,
    });
typedef $$CampaignVillagesTableUpdateCompanionBuilder =
    CampaignVillagesCompanion Function({
      Value<int> campaignId,
      Value<int> villageId,
      Value<int> rowid,
    });

final class $$CampaignVillagesTableReferences
    extends
        BaseReferences<_$AppDatabase, $CampaignVillagesTable, CampaignVillage> {
  $$CampaignVillagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CampaignsTable _campaignIdTable(_$AppDatabase db) =>
      db.campaigns.createAlias('campaign_villages__campaign_id__campaigns__id');

  $$CampaignsTableProcessedTableManager get campaignId {
    final $_column = $_itemColumn<int>('campaign_id')!;

    final manager = $$CampaignsTableTableManager(
      $_db,
      $_db.campaigns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VillagesTable _villageIdTable(_$AppDatabase db) =>
      db.villages.createAlias('campaign_villages__village_id__villages__id');

  $$VillagesTableProcessedTableManager get villageId {
    final $_column = $_itemColumn<int>('village_id')!;

    final manager = $$VillagesTableTableManager(
      $_db,
      $_db.villages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CampaignVillagesTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignVillagesTable> {
  $$CampaignVillagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableFilterComposer get campaignId {
    final $$CampaignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableFilterComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VillagesTableFilterComposer get villageId {
    final $$VillagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableFilterComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignVillagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignVillagesTable> {
  $$CampaignVillagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableOrderingComposer get campaignId {
    final $$CampaignsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableOrderingComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VillagesTableOrderingComposer get villageId {
    final $$VillagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableOrderingComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignVillagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignVillagesTable> {
  $$CampaignVillagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableAnnotationComposer get campaignId {
    final $$CampaignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableAnnotationComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VillagesTableAnnotationComposer get villageId {
    final $$VillagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villageId,
      referencedTable: $db.villages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillagesTableAnnotationComposer(
            $db: $db,
            $table: $db.villages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignVillagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignVillagesTable,
          CampaignVillage,
          $$CampaignVillagesTableFilterComposer,
          $$CampaignVillagesTableOrderingComposer,
          $$CampaignVillagesTableAnnotationComposer,
          $$CampaignVillagesTableCreateCompanionBuilder,
          $$CampaignVillagesTableUpdateCompanionBuilder,
          (CampaignVillage, $$CampaignVillagesTableReferences),
          CampaignVillage,
          PrefetchHooks Function({bool campaignId, bool villageId})
        > {
  $$CampaignVillagesTableTableManager(
    _$AppDatabase db,
    $CampaignVillagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignVillagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampaignVillagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampaignVillagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> campaignId = const Value.absent(),
                Value<int> villageId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampaignVillagesCompanion(
                campaignId: campaignId,
                villageId: villageId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int campaignId,
                required int villageId,
                Value<int> rowid = const Value.absent(),
              }) => CampaignVillagesCompanion.insert(
                campaignId: campaignId,
                villageId: villageId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampaignVillagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({campaignId = false, villageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (campaignId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.campaignId,
                                referencedTable:
                                    $$CampaignVillagesTableReferences
                                        ._campaignIdTable(db),
                                referencedColumn:
                                    $$CampaignVillagesTableReferences
                                        ._campaignIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (villageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.villageId,
                                referencedTable:
                                    $$CampaignVillagesTableReferences
                                        ._villageIdTable(db),
                                referencedColumn:
                                    $$CampaignVillagesTableReferences
                                        ._villageIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CampaignVillagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignVillagesTable,
      CampaignVillage,
      $$CampaignVillagesTableFilterComposer,
      $$CampaignVillagesTableOrderingComposer,
      $$CampaignVillagesTableAnnotationComposer,
      $$CampaignVillagesTableCreateCompanionBuilder,
      $$CampaignVillagesTableUpdateCompanionBuilder,
      (CampaignVillage, $$CampaignVillagesTableReferences),
      CampaignVillage,
      PrefetchHooks Function({bool campaignId, bool villageId})
    >;
typedef $$CampaignResidencePlacesTableCreateCompanionBuilder =
    CampaignResidencePlacesCompanion Function({
      required int campaignId,
      required int residencePlaceId,
      Value<int> rowid,
    });
typedef $$CampaignResidencePlacesTableUpdateCompanionBuilder =
    CampaignResidencePlacesCompanion Function({
      Value<int> campaignId,
      Value<int> residencePlaceId,
      Value<int> rowid,
    });

final class $$CampaignResidencePlacesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CampaignResidencePlacesTable,
          CampaignResidencePlace
        > {
  $$CampaignResidencePlacesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CampaignsTable _campaignIdTable(_$AppDatabase db) => db.campaigns
      .createAlias('campaign_residence_places__campaign_id__campaigns__id');

  $$CampaignsTableProcessedTableManager get campaignId {
    final $_column = $_itemColumn<int>('campaign_id')!;

    final manager = $$CampaignsTableTableManager(
      $_db,
      $_db.campaigns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ResidencePlacesTable _residencePlaceIdTable(_$AppDatabase db) =>
      db.residencePlaces.createAlias(
        'campaign_residence_places__residence_place_id__residence_places__id',
      );

  $$ResidencePlacesTableProcessedTableManager get residencePlaceId {
    final $_column = $_itemColumn<int>('residence_place_id')!;

    final manager = $$ResidencePlacesTableTableManager(
      $_db,
      $_db.residencePlaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residencePlaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CampaignResidencePlacesTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignResidencePlacesTable> {
  $$CampaignResidencePlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableFilterComposer get campaignId {
    final $$CampaignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableFilterComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableFilterComposer get residencePlaceId {
    final $$ResidencePlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableFilterComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignResidencePlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignResidencePlacesTable> {
  $$CampaignResidencePlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableOrderingComposer get campaignId {
    final $$CampaignsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableOrderingComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableOrderingComposer get residencePlaceId {
    final $$ResidencePlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableOrderingComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignResidencePlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignResidencePlacesTable> {
  $$CampaignResidencePlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CampaignsTableAnnotationComposer get campaignId {
    final $$CampaignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableAnnotationComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidencePlacesTableAnnotationComposer get residencePlaceId {
    final $$ResidencePlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residencePlaceId,
      referencedTable: $db.residencePlaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidencePlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.residencePlaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignResidencePlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignResidencePlacesTable,
          CampaignResidencePlace,
          $$CampaignResidencePlacesTableFilterComposer,
          $$CampaignResidencePlacesTableOrderingComposer,
          $$CampaignResidencePlacesTableAnnotationComposer,
          $$CampaignResidencePlacesTableCreateCompanionBuilder,
          $$CampaignResidencePlacesTableUpdateCompanionBuilder,
          (CampaignResidencePlace, $$CampaignResidencePlacesTableReferences),
          CampaignResidencePlace,
          PrefetchHooks Function({bool campaignId, bool residencePlaceId})
        > {
  $$CampaignResidencePlacesTableTableManager(
    _$AppDatabase db,
    $CampaignResidencePlacesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignResidencePlacesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CampaignResidencePlacesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CampaignResidencePlacesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> campaignId = const Value.absent(),
                Value<int> residencePlaceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampaignResidencePlacesCompanion(
                campaignId: campaignId,
                residencePlaceId: residencePlaceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int campaignId,
                required int residencePlaceId,
                Value<int> rowid = const Value.absent(),
              }) => CampaignResidencePlacesCompanion.insert(
                campaignId: campaignId,
                residencePlaceId: residencePlaceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampaignResidencePlacesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({campaignId = false, residencePlaceId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (campaignId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.campaignId,
                                    referencedTable:
                                        $$CampaignResidencePlacesTableReferences
                                            ._campaignIdTable(db),
                                    referencedColumn:
                                        $$CampaignResidencePlacesTableReferences
                                            ._campaignIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (residencePlaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.residencePlaceId,
                                    referencedTable:
                                        $$CampaignResidencePlacesTableReferences
                                            ._residencePlaceIdTable(db),
                                    referencedColumn:
                                        $$CampaignResidencePlacesTableReferences
                                            ._residencePlaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CampaignResidencePlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignResidencePlacesTable,
      CampaignResidencePlace,
      $$CampaignResidencePlacesTableFilterComposer,
      $$CampaignResidencePlacesTableOrderingComposer,
      $$CampaignResidencePlacesTableAnnotationComposer,
      $$CampaignResidencePlacesTableCreateCompanionBuilder,
      $$CampaignResidencePlacesTableUpdateCompanionBuilder,
      (CampaignResidencePlace, $$CampaignResidencePlacesTableReferences),
      CampaignResidencePlace,
      PrefetchHooks Function({bool campaignId, bool residencePlaceId})
    >;
typedef $$CampaignBeneficiariesTableCreateCompanionBuilder =
    CampaignBeneficiariesCompanion Function({
      Value<int> id,
      required int campaignId,
      required int beneficiaryId,
      Value<String> status,
      Value<double?> amount,
      Value<DateTime?> receivedAt,
      Value<DateTime> createdAt,
    });
typedef $$CampaignBeneficiariesTableUpdateCompanionBuilder =
    CampaignBeneficiariesCompanion Function({
      Value<int> id,
      Value<int> campaignId,
      Value<int> beneficiaryId,
      Value<String> status,
      Value<double?> amount,
      Value<DateTime?> receivedAt,
      Value<DateTime> createdAt,
    });

final class $$CampaignBeneficiariesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CampaignBeneficiariesTable,
          CampaignBeneficiary
        > {
  $$CampaignBeneficiariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CampaignsTable _campaignIdTable(_$AppDatabase db) => db.campaigns
      .createAlias('campaign_beneficiaries__campaign_id__campaigns__id');

  $$CampaignsTableProcessedTableManager get campaignId {
    final $_column = $_itemColumn<int>('campaign_id')!;

    final manager = $$CampaignsTableTableManager(
      $_db,
      $_db.campaigns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BeneficiariesTable _beneficiaryIdTable(_$AppDatabase db) => db
      .beneficiaries
      .createAlias('campaign_beneficiaries__beneficiary_id__beneficiaries__id');

  $$BeneficiariesTableProcessedTableManager get beneficiaryId {
    final $_column = $_itemColumn<int>('beneficiary_id')!;

    final manager = $$BeneficiariesTableTableManager(
      $_db,
      $_db.beneficiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CampaignBeneficiariesTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignBeneficiariesTable> {
  $$CampaignBeneficiariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CampaignsTableFilterComposer get campaignId {
    final $$CampaignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableFilterComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeneficiariesTableFilterComposer get beneficiaryId {
    final $$BeneficiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableFilterComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignBeneficiariesTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignBeneficiariesTable> {
  $$CampaignBeneficiariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CampaignsTableOrderingComposer get campaignId {
    final $$CampaignsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableOrderingComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeneficiariesTableOrderingComposer get beneficiaryId {
    final $$BeneficiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableOrderingComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignBeneficiariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignBeneficiariesTable> {
  $$CampaignBeneficiariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CampaignsTableAnnotationComposer get campaignId {
    final $$CampaignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.campaignId,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableAnnotationComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeneficiariesTableAnnotationComposer get beneficiaryId {
    final $$BeneficiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryId,
      referencedTable: $db.beneficiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeneficiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.beneficiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignBeneficiariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignBeneficiariesTable,
          CampaignBeneficiary,
          $$CampaignBeneficiariesTableFilterComposer,
          $$CampaignBeneficiariesTableOrderingComposer,
          $$CampaignBeneficiariesTableAnnotationComposer,
          $$CampaignBeneficiariesTableCreateCompanionBuilder,
          $$CampaignBeneficiariesTableUpdateCompanionBuilder,
          (CampaignBeneficiary, $$CampaignBeneficiariesTableReferences),
          CampaignBeneficiary,
          PrefetchHooks Function({bool campaignId, bool beneficiaryId})
        > {
  $$CampaignBeneficiariesTableTableManager(
    _$AppDatabase db,
    $CampaignBeneficiariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignBeneficiariesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CampaignBeneficiariesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CampaignBeneficiariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> campaignId = const Value.absent(),
                Value<int> beneficiaryId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<DateTime?> receivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CampaignBeneficiariesCompanion(
                id: id,
                campaignId: campaignId,
                beneficiaryId: beneficiaryId,
                status: status,
                amount: amount,
                receivedAt: receivedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int campaignId,
                required int beneficiaryId,
                Value<String> status = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<DateTime?> receivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CampaignBeneficiariesCompanion.insert(
                id: id,
                campaignId: campaignId,
                beneficiaryId: beneficiaryId,
                status: status,
                amount: amount,
                receivedAt: receivedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampaignBeneficiariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({campaignId = false, beneficiaryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (campaignId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.campaignId,
                                referencedTable:
                                    $$CampaignBeneficiariesTableReferences
                                        ._campaignIdTable(db),
                                referencedColumn:
                                    $$CampaignBeneficiariesTableReferences
                                        ._campaignIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (beneficiaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beneficiaryId,
                                referencedTable:
                                    $$CampaignBeneficiariesTableReferences
                                        ._beneficiaryIdTable(db),
                                referencedColumn:
                                    $$CampaignBeneficiariesTableReferences
                                        ._beneficiaryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CampaignBeneficiariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignBeneficiariesTable,
      CampaignBeneficiary,
      $$CampaignBeneficiariesTableFilterComposer,
      $$CampaignBeneficiariesTableOrderingComposer,
      $$CampaignBeneficiariesTableAnnotationComposer,
      $$CampaignBeneficiariesTableCreateCompanionBuilder,
      $$CampaignBeneficiariesTableUpdateCompanionBuilder,
      (CampaignBeneficiary, $$CampaignBeneficiariesTableReferences),
      CampaignBeneficiary,
      PrefetchHooks Function({bool campaignId, bool beneficiaryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VillagesTableTableManager get villages =>
      $$VillagesTableTableManager(_db, _db.villages);
  $$ResidencePlacesTableTableManager get residencePlaces =>
      $$ResidencePlacesTableTableManager(_db, _db.residencePlaces);
  $$AidTypesTableTableManager get aidTypes =>
      $$AidTypesTableTableManager(_db, _db.aidTypes);
  $$BeneficiariesTableTableManager get beneficiaries =>
      $$BeneficiariesTableTableManager(_db, _db.beneficiaries);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db, _db.households);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$ElderlyTableTableManager get elderly =>
      $$ElderlyTableTableManager(_db, _db.elderly);
  $$MarriedTableTableManager get married =>
      $$MarriedTableTableManager(_db, _db.married);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db, _db.campaigns);
  $$CampaignVillagesTableTableManager get campaignVillages =>
      $$CampaignVillagesTableTableManager(_db, _db.campaignVillages);
  $$CampaignResidencePlacesTableTableManager get campaignResidencePlaces =>
      $$CampaignResidencePlacesTableTableManager(
        _db,
        _db.campaignResidencePlaces,
      );
  $$CampaignBeneficiariesTableTableManager get campaignBeneficiaries =>
      $$CampaignBeneficiariesTableTableManager(_db, _db.campaignBeneficiaries);
}
