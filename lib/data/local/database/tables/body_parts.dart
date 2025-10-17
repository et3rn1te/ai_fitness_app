import 'package:drift/drift.dart';

@DataClassName('BodyPartData')
class BodyParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text().nullable()();
}
