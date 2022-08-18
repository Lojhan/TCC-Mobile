// import 'dart:async';

// import 'package:mobile/app/domain/entities/prediction.dart';
// import 'package:mobile/app/infra/interfaces/datasources/i_local_datasource.dart';
// import 'package:sqflite/sqflite.dart';

// class PredictionLocalDataSource implements ILocalDatasource<Prediction> {
//   late Database? db;
//   final String table = 'predictions';
//   late String databasePath;

//   PredictionLocalDataSource() {
//     createDatabase();
//   }

//   Future<void> createDatabase() async {
//     final path = "${await getDatabasesPath()}/'predictions_database.db";
//     databasePath = path;

//     final database = await openDatabase(path, onCreate: onCreate, version: 1);
//     onCreate(database, 1);
//     db = database;
//   }

//   Future<void> openDatabaseOrCreate(String path) async {
//     if (db == null) {
//       await createDatabase();
//     }
//     if (!db!.isOpen) {
//       await openDatabase(path);
//     }
//   }

//   onCreate(Database db, int version) {
//     return db.execute(
//       '''
//           CREATE TABLE predictions(
//             id TEXT PRIMARY KEY, 
//             dx TEXT, 
//             localImagePath TEXT,
//             remoteImagePath TEXT,
//             diseaseName TEXT,
//             createdAt TEXT,
//             predicted TEXT
//           );''',
//     );
//   }

//   Future<void> insert(Map<String, dynamic> prediction) async {
//     await openDatabaseOrCreate(databasePath);
//     await db!.insert(table, prediction,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   @override
//   Future<void> delete(String id) async {
//     await openDatabaseOrCreate(databasePath);
//     db!.delete(table, where: 'id = ?', whereArgs: [id]);
//   }

//   @override
//   Future<Prediction> getById(String id) async {
//     await openDatabaseOrCreate(databasePath);
//     final rawPred = await db!.query(table, where: 'id = ?', whereArgs: [id]);
//     return Prediction.fromLocal(rawPred.first.cast());
//   }

//   @override
//   Future<List<Prediction>> list() async {
//     await openDatabaseOrCreate(databasePath);
//     List<Map<String, dynamic>> rawPreds = await db!.query(table);

//     return rawPreds.map(Prediction.fromLocal).toList();
//   }

//   @override
//   Future<void> save(model) async {
//     await openDatabaseOrCreate(databasePath);
//     await db!.insert(table, model.toJson(true));
//   }

//   @override
//   Future<void> update(model) async {
//     await openDatabaseOrCreate(databasePath);
//     db!.update(table, model.toJson(true),
//         where: 'id = ?', whereArgs: [model.id]);
//   }
// }
