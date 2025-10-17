import 'package:drift/drift.dart';

@DataClassName('ExerciseTypeData')
class ExerciseTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
