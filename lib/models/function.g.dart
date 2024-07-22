// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFunctionApiCollection on Isar {
  IsarCollection<FunctionApi> get functionApis => this.collection();
}

const FunctionApiSchema = CollectionSchema(
  name: r'FunctionApi',
  id: -4336257125227574770,
  properties: {
    r'$createdAt': PropertySchema(
      id: 0,
      name: r'$createdAt',
      type: IsarType.dateTime,
    ),
    r'$id': PropertySchema(
      id: 1,
      name: r'$id',
      type: IsarType.string,
    ),
    r'$syncedAt': PropertySchema(
      id: 2,
      name: r'$syncedAt',
      type: IsarType.dateTime,
    ),
    r'$updatedAt': PropertySchema(
      id: 3,
      name: r'$updatedAt',
      type: IsarType.dateTime,
    ),
    r'commands': PropertySchema(
      id: 4,
      name: r'commands',
      type: IsarType.string,
    ),
    r'enabled': PropertySchema(
      id: 5,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'entrypoint': PropertySchema(
      id: 6,
      name: r'entrypoint',
      type: IsarType.string,
    ),
    r'events': PropertySchema(
      id: 7,
      name: r'events',
      type: IsarType.stringList,
    ),
    r'execute': PropertySchema(
      id: 8,
      name: r'execute',
      type: IsarType.stringList,
    ),
    r'ignore': PropertySchema(
      id: 9,
      name: r'ignore',
      type: IsarType.stringList,
    ),
    r'logging': PropertySchema(
      id: 10,
      name: r'logging',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'runtime': PropertySchema(
      id: 12,
      name: r'runtime',
      type: IsarType.string,
    ),
    r'schedule': PropertySchema(
      id: 13,
      name: r'schedule',
      type: IsarType.string,
    ),
    r'timeout': PropertySchema(
      id: 14,
      name: r'timeout',
      type: IsarType.long,
    )
  },
  estimateSize: _functionApiEstimateSize,
  serialize: _functionApiSerialize,
  deserialize: _functionApiDeserialize,
  deserializeProp: _functionApiDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'projects': LinkSchema(
      id: -2027122305007031892,
      name: r'projects',
      target: r'ProjectApi',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _functionApiGetId,
  getLinks: _functionApiGetLinks,
  attach: _functionApiAttach,
  version: '3.1.0+1',
);

int _functionApiEstimateSize(
  FunctionApi object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.$id.length * 3;
  {
    final value = object.commands;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.entrypoint;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.events;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.execute;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.ignore;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.runtime.length * 3;
  {
    final value = object.schedule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _functionApiSerialize(
  FunctionApi object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.$id);
  writer.writeDateTime(offsets[2], object.syncedAt);
  writer.writeDateTime(offsets[3], object.updatedAt);
  writer.writeString(offsets[4], object.commands);
  writer.writeBool(offsets[5], object.enabled);
  writer.writeString(offsets[6], object.entrypoint);
  writer.writeStringList(offsets[7], object.events);
  writer.writeStringList(offsets[8], object.execute);
  writer.writeStringList(offsets[9], object.ignore);
  writer.writeBool(offsets[10], object.logging);
  writer.writeString(offsets[11], object.name);
  writer.writeString(offsets[12], object.runtime);
  writer.writeString(offsets[13], object.schedule);
  writer.writeLong(offsets[14], object.timeout);
}

FunctionApi _functionApiDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FunctionApi();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.$id = reader.readString(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[3]);
  object.commands = reader.readStringOrNull(offsets[4]);
  object.enabled = reader.readBoolOrNull(offsets[5]);
  object.entrypoint = reader.readStringOrNull(offsets[6]);
  object.events = reader.readStringList(offsets[7]);
  object.execute = reader.readStringList(offsets[8]);
  object.id = id;
  object.ignore = reader.readStringList(offsets[9]);
  object.logging = reader.readBoolOrNull(offsets[10]);
  object.name = reader.readString(offsets[11]);
  object.runtime = reader.readString(offsets[12]);
  object.schedule = reader.readStringOrNull(offsets[13]);
  object.timeout = reader.readLongOrNull(offsets[14]);
  return object;
}

P _functionApiDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readStringList(offset)) as P;
    case 9:
      return (reader.readStringList(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _functionApiGetId(FunctionApi object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _functionApiGetLinks(FunctionApi object) {
  return [object.projects];
}

void _functionApiAttach(
    IsarCollection<dynamic> col, Id id, FunctionApi object) {
  object.id = id;
  object.projects
      .attach(col, col.isar.collection<ProjectApi>(), r'projects', id);
}

extension FunctionApiQueryWhereSort
    on QueryBuilder<FunctionApi, FunctionApi, QWhere> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FunctionApiQueryWhere
    on QueryBuilder<FunctionApi, FunctionApi, QWhereClause> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FunctionApiQueryFilter
    on QueryBuilder<FunctionApi, FunctionApi, QFilterCondition> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'$createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'$createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'$createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'$createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'$id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'$id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'$id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> $idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'$id',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      $idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'$id',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> syncedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'$syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      syncedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'$syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      syncedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'$syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> syncedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'$syncedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'$updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'$updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'$updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'$updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commands',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commands',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> commandsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> commandsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commands',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commands',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> commandsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commands',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commands',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      commandsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commands',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> enabledEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'entrypoint',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'entrypoint',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entrypoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entrypoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entrypoint',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entrypoint',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      entrypointIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entrypoint',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> eventsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'events',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'events',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'events',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'events',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'events',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'events',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'events',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      eventsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'execute',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'execute',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'execute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'execute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'execute',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'execute',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'execute',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      executeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'execute',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> ignoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ignore',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ignore',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ignore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ignore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignore',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ignore',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      ignoreLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignore',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      loggingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logging',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      loggingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logging',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> loggingEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logging',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      runtimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'runtime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      runtimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'runtime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> runtimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'runtime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      runtimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'runtime',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      runtimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'runtime',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'schedule',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'schedule',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> scheduleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> scheduleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schedule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'schedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> scheduleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'schedule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schedule',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      scheduleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'schedule',
        value: '',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      timeoutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeout',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      timeoutIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeout',
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> timeoutEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeout',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      timeoutGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeout',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> timeoutLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeout',
        value: value,
      ));
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> timeoutBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeout',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FunctionApiQueryObject
    on QueryBuilder<FunctionApi, FunctionApi, QFilterCondition> {}

extension FunctionApiQueryLinks
    on QueryBuilder<FunctionApi, FunctionApi, QFilterCondition> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition> projects(
      FilterQuery<ProjectApi> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'projects');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'projects', length, true, length, true);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'projects', 0, true, 0, true);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'projects', 0, false, 999999, true);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'projects', 0, true, length, include);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'projects', length, include, 999999, true);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterFilterCondition>
      projectsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'projects', lower, includeLower, upper, includeUpper);
    });
  }
}

extension FunctionApiQuerySortBy
    on QueryBuilder<FunctionApi, FunctionApi, QSortBy> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$createdAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$createdAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortBy$id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$id', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortBy$idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$id', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$syncedAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$syncedAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$updatedAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByCommands() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commands', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByCommandsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commands', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByEntrypoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrypoint', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByEntrypointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrypoint', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByLogging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logging', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByLoggingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logging', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByRuntime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runtime', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByRuntimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runtime', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortBySchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schedule', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schedule', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByTimeout() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeout', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> sortByTimeoutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeout', Sort.desc);
    });
  }
}

extension FunctionApiQuerySortThenBy
    on QueryBuilder<FunctionApi, FunctionApi, QSortThenBy> {
  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$createdAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$createdAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenBy$id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$id', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenBy$idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$id', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$syncedAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$syncedAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'$updatedAt', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByCommands() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commands', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByCommandsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commands', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByEntrypoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrypoint', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByEntrypointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entrypoint', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByLogging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logging', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByLoggingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logging', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByRuntime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runtime', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByRuntimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runtime', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenBySchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schedule', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schedule', Sort.desc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByTimeout() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeout', Sort.asc);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QAfterSortBy> thenByTimeoutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeout', Sort.desc);
    });
  }
}

extension FunctionApiQueryWhereDistinct
    on QueryBuilder<FunctionApi, FunctionApi, QDistinct> {
  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'$createdAt');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctBy$id(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'$id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'$syncedAt');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'$updatedAt');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByCommands(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commands', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByEntrypoint(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entrypoint', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByEvents() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'events');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByExecute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'execute');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByIgnore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ignore');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByLogging() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logging');
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByRuntime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'runtime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctBySchedule(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'schedule', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FunctionApi, FunctionApi, QDistinct> distinctByTimeout() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeout');
    });
  }
}

extension FunctionApiQueryProperty
    on QueryBuilder<FunctionApi, FunctionApi, QQueryProperty> {
  QueryBuilder<FunctionApi, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FunctionApi, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'$createdAt');
    });
  }

  QueryBuilder<FunctionApi, String, QQueryOperations> $idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'$id');
    });
  }

  QueryBuilder<FunctionApi, DateTime, QQueryOperations> syncedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'$syncedAt');
    });
  }

  QueryBuilder<FunctionApi, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'$updatedAt');
    });
  }

  QueryBuilder<FunctionApi, String?, QQueryOperations> commandsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commands');
    });
  }

  QueryBuilder<FunctionApi, bool?, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<FunctionApi, String?, QQueryOperations> entrypointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entrypoint');
    });
  }

  QueryBuilder<FunctionApi, List<String>?, QQueryOperations> eventsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'events');
    });
  }

  QueryBuilder<FunctionApi, List<String>?, QQueryOperations> executeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'execute');
    });
  }

  QueryBuilder<FunctionApi, List<String>?, QQueryOperations> ignoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ignore');
    });
  }

  QueryBuilder<FunctionApi, bool?, QQueryOperations> loggingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logging');
    });
  }

  QueryBuilder<FunctionApi, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FunctionApi, String, QQueryOperations> runtimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'runtime');
    });
  }

  QueryBuilder<FunctionApi, String?, QQueryOperations> scheduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schedule');
    });
  }

  QueryBuilder<FunctionApi, int?, QQueryOperations> timeoutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeout');
    });
  }
}
