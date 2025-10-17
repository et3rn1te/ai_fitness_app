import 'package:drift/drift.dart';

@DataClassName('EquipmentData')
class Equipment extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
