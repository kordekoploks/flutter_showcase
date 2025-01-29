// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'data/data_sources/local/entity/account_entity.dart';
import 'data/data_sources/local/entity/income_entity.dart';
import 'data/data_sources/local/entity/outcome_category_entity.dart';
import 'data/data_sources/local/entity/outcome_sub_category_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 7359631057605422155),
      name: 'OutcomeCategoryEntity',
      lastPropertyId: const obx_int.IdUid(5, 6683509701184670458),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 2786493064679965967),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 3798134373922412581),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1069846062488662881),
            name: 'image',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8878383454893538294),
            name: 'position',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 6683509701184670458),
            name: 'desc',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'subCategories',
            srcEntity: 'OutcomeSubCategoryEntity',
            srcField: 'outcomeCategory')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 4764500871628775411),
      name: 'OutcomeSubCategoryEntity',
      lastPropertyId: const obx_int.IdUid(4, 7590394418579054402),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8708407211266727236),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1955618820792334788),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1621959983335286454),
            name: 'desc',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 7590394418579054402),
            name: 'outcomeCategoryId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 666203549246372151),
            relationTarget: 'OutcomeCategoryEntity')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 7600219410570097336),
      name: 'AccountEntity',
      lastPropertyId: const obx_int.IdUid(5, 3733780343171772778),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 5654376858132276058),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 221469678137847452),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2045616521691828464),
            name: 'initialAmt',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 4666283972967581651),
            name: 'desc',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 3733780343171772778),
            name: 'accountGroup',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 2886093891279533130),
      name: 'IncomeEntity',
      lastPropertyId: const obx_int.IdUid(7, 2209880324749896458),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8515979234875493627),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5019048194379505791),
            name: 'idAccount',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 3505473539109248109),
            name: 'date',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5291430487061544644),
            name: 'amount',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 3549898390094250503),
            name: 'category',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4803267927051456456),
            name: 'note',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 2209880324749896458),
            name: 'isRepeat',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(4, 2886093891279533130),
      lastIndexId: const obx_int.IdUid(1, 666203549246372151),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    OutcomeCategoryEntity: obx_int.EntityDefinition<OutcomeCategoryEntity>(
        model: _entities[0],
        toOneRelations: (OutcomeCategoryEntity object) => [],
        toManyRelations: (OutcomeCategoryEntity object) => {
              obx_int.RelInfo<OutcomeSubCategoryEntity>.toOneBacklink(
                  4,
                  object.id,
                  (OutcomeSubCategoryEntity srcObject) =>
                      srcObject.outcomeCategory): object.subCategories
            },
        getId: (OutcomeCategoryEntity object) => object.id,
        setId: (OutcomeCategoryEntity object, int id) {
          object.id = id;
        },
        objectToFB: (OutcomeCategoryEntity object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          final descOffset =
              object.desc == null ? null : fbb.writeString(object.desc!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, imageOffset);
          fbb.addInt64(3, object.position);
          fbb.addOffset(4, descOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final imageParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final positionParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final descParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final object = OutcomeCategoryEntity(
              idParam, nameParam, imageParam, positionParam, descParam);
          obx_int.InternalToManyAccess.setRelInfo<OutcomeCategoryEntity>(
              object.subCategories,
              store,
              obx_int.RelInfo<OutcomeSubCategoryEntity>.toOneBacklink(
                  4,
                  object.id,
                  (OutcomeSubCategoryEntity srcObject) =>
                      srcObject.outcomeCategory));
          return object;
        }),
    OutcomeSubCategoryEntity:
        obx_int.EntityDefinition<OutcomeSubCategoryEntity>(
            model: _entities[1],
            toOneRelations: (OutcomeSubCategoryEntity object) =>
                [object.outcomeCategory],
            toManyRelations: (OutcomeSubCategoryEntity object) => {},
            getId: (OutcomeSubCategoryEntity object) => object.id,
            setId: (OutcomeSubCategoryEntity object, int id) {
              object.id = id;
            },
            objectToFB: (OutcomeSubCategoryEntity object, fb.Builder fbb) {
              final nameOffset =
                  object.name == null ? null : fbb.writeString(object.name!);
              final descOffset =
                  object.desc == null ? null : fbb.writeString(object.desc!);
              fbb.startTable(5);
              fbb.addInt64(0, object.id);
              fbb.addOffset(1, nameOffset);
              fbb.addOffset(2, descOffset);
              fbb.addInt64(3, object.outcomeCategory.targetId);
              fbb.finish(fbb.endTable());
              return object.id;
            },
            objectFromFB: (obx.Store store, ByteData fbData) {
              final buffer = fb.BufferContext(fbData);
              final rootOffset = buffer.derefObject(0);
              final idParam =
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
              final nameParam = const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6);
              final descParam = const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8);
              final object =
                  OutcomeSubCategoryEntity(idParam, nameParam, descParam);
              object.outcomeCategory.targetId =
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
              object.outcomeCategory.attach(store);
              return object;
            }),
    AccountEntity: obx_int.EntityDefinition<AccountEntity>(
        model: _entities[2],
        toOneRelations: (AccountEntity object) => [],
        toManyRelations: (AccountEntity object) => {},
        getId: (AccountEntity object) => object.id,
        setId: (AccountEntity object, int id) {
          object.id = id;
        },
        objectToFB: (AccountEntity object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final descOffset =
              object.desc == null ? null : fbb.writeString(object.desc!);
          final accountGroupOffset = fbb.writeString(object.accountGroup);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.initialAmt);
          fbb.addOffset(3, descOffset);
          fbb.addOffset(4, accountGroupOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final initialAmtParam =
              const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final descParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final accountGroupParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, '');
          final object = AccountEntity(idParam, nameParam, initialAmtParam,
              descParam, accountGroupParam);

          return object;
        }),
    IncomeEntity: obx_int.EntityDefinition<IncomeEntity>(
        model: _entities[3],
        toOneRelations: (IncomeEntity object) => [],
        toManyRelations: (IncomeEntity object) => {},
        getId: (IncomeEntity object) => object.id,
        setId: (IncomeEntity object, int id) {
          object.id = id;
        },
        objectToFB: (IncomeEntity object, fb.Builder fbb) {
          final idAccountOffset = fbb.writeString(object.idAccount);
          final dateOffset = fbb.writeString(object.date);
          final categoryOffset = fbb.writeString(object.category);
          final noteOffset = fbb.writeString(object.note);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, idAccountOffset);
          fbb.addOffset(2, dateOffset);
          fbb.addFloat64(3, object.amount);
          fbb.addOffset(4, categoryOffset);
          fbb.addOffset(5, noteOffset);
          fbb.addBool(6, object.isRepeat);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final idAccountParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final dateParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final amountParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final categoryParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final noteParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final isRepeatParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 16, false);
          final object = IncomeEntity(idParam, idAccountParam, dateParam,
              amountParam, categoryParam, noteParam, isRepeatParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [OutcomeCategoryEntity] entity fields to define ObjectBox queries.
class OutcomeCategoryEntity_ {
  /// See [OutcomeCategoryEntity.id].
  static final id = obx.QueryIntegerProperty<OutcomeCategoryEntity>(
      _entities[0].properties[0]);

  /// See [OutcomeCategoryEntity.name].
  static final name = obx.QueryStringProperty<OutcomeCategoryEntity>(
      _entities[0].properties[1]);

  /// See [OutcomeCategoryEntity.image].
  static final image = obx.QueryStringProperty<OutcomeCategoryEntity>(
      _entities[0].properties[2]);

  /// See [OutcomeCategoryEntity.position].
  static final position = obx.QueryIntegerProperty<OutcomeCategoryEntity>(
      _entities[0].properties[3]);

  /// See [OutcomeCategoryEntity.desc].
  static final desc = obx.QueryStringProperty<OutcomeCategoryEntity>(
      _entities[0].properties[4]);

  /// see [OutcomeCategoryEntity.subCategories]
  static final subCategories =
      obx.QueryBacklinkToMany<OutcomeSubCategoryEntity, OutcomeCategoryEntity>(
          OutcomeSubCategoryEntity_.outcomeCategory);
}

/// [OutcomeSubCategoryEntity] entity fields to define ObjectBox queries.
class OutcomeSubCategoryEntity_ {
  /// See [OutcomeSubCategoryEntity.id].
  static final id = obx.QueryIntegerProperty<OutcomeSubCategoryEntity>(
      _entities[1].properties[0]);

  /// See [OutcomeSubCategoryEntity.name].
  static final name = obx.QueryStringProperty<OutcomeSubCategoryEntity>(
      _entities[1].properties[1]);

  /// See [OutcomeSubCategoryEntity.desc].
  static final desc = obx.QueryStringProperty<OutcomeSubCategoryEntity>(
      _entities[1].properties[2]);

  /// See [OutcomeSubCategoryEntity.outcomeCategory].
  static final outcomeCategory =
      obx.QueryRelationToOne<OutcomeSubCategoryEntity, OutcomeCategoryEntity>(
          _entities[1].properties[3]);
}

/// [AccountEntity] entity fields to define ObjectBox queries.
class AccountEntity_ {
  /// See [AccountEntity.id].
  static final id =
      obx.QueryIntegerProperty<AccountEntity>(_entities[2].properties[0]);

  /// See [AccountEntity.name].
  static final name =
      obx.QueryStringProperty<AccountEntity>(_entities[2].properties[1]);

  /// See [AccountEntity.initialAmt].
  static final initialAmt =
      obx.QueryDoubleProperty<AccountEntity>(_entities[2].properties[2]);

  /// See [AccountEntity.desc].
  static final desc =
      obx.QueryStringProperty<AccountEntity>(_entities[2].properties[3]);

  /// See [AccountEntity.accountGroup].
  static final accountGroup =
      obx.QueryStringProperty<AccountEntity>(_entities[2].properties[4]);
}

/// [IncomeEntity] entity fields to define ObjectBox queries.
class IncomeEntity_ {
  /// See [IncomeEntity.id].
  static final id =
      obx.QueryIntegerProperty<IncomeEntity>(_entities[3].properties[0]);

  /// See [IncomeEntity.idAccount].
  static final idAccount =
      obx.QueryStringProperty<IncomeEntity>(_entities[3].properties[1]);

  /// See [IncomeEntity.date].
  static final date =
      obx.QueryStringProperty<IncomeEntity>(_entities[3].properties[2]);

  /// See [IncomeEntity.amount].
  static final amount =
      obx.QueryDoubleProperty<IncomeEntity>(_entities[3].properties[3]);

  /// See [IncomeEntity.category].
  static final category =
      obx.QueryStringProperty<IncomeEntity>(_entities[3].properties[4]);

  /// See [IncomeEntity.note].
  static final note =
      obx.QueryStringProperty<IncomeEntity>(_entities[3].properties[5]);

  /// See [IncomeEntity.isRepeat].
  static final isRepeat =
      obx.QueryBooleanProperty<IncomeEntity>(_entities[3].properties[6]);
}
