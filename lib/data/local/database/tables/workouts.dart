import 'package:drift/drift.dart';
import 'body_parts.dart';
import 'workout_types.dart';
import 'enums.dart';

@DataClassName('WorkoutData')
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get introduction => text()();

  // Enum stored as text
  TextColumn get level => textEnum<WorkoutLevel>()();

  // Foreign keys
  IntColumn get bodyPartId => integer().references(BodyParts, #id)();
  IntColumn get workoutTypeId => integer().references(WorkoutTypes, #id)();

  IntColumn get duration => integer()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
