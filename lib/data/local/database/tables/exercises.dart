import 'package:drift/drift.dart';
import 'body_parts.dart';
import 'equipment.dart';
import 'exercise_types.dart';
import 'enums.dart';

@DataClassName('ExerciseData')
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get instructions => text()();

  // Foreign keys
  IntColumn get bodyPartId => integer().references(BodyParts, #id)();
  IntColumn get exerciseTypeId => integer().references(ExerciseTypes, #id)();
  IntColumn get equipmentId => integer().references(Equipment, #id)();

  // Enums stored as text
  TextColumn get difficulty => textEnum<ExerciseDifficulty>()();
  TextColumn get unit => textEnum<ExerciseUnit>()();

  IntColumn get defaultValue => integer()();
  TextColumn get animationUrl => text().nullable()();
}
