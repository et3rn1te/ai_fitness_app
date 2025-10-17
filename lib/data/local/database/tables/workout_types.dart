import 'package:drift/drift.dart';

@DataClassName('WorkoutTypeData')
class WorkoutTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
