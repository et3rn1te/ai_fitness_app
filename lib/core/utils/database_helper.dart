import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern to ensure only one instance of the database helper exists
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'ai_fitness.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // This method runs only once when the database is first created.
  Future<void> _createDB(Database db, int version) async {
    // Table for custom workout metadata
    await db.execute('''
      CREATE TABLE custom_workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        introduction TEXT,
        level TEXT,
        durationMinutes INTEGER,
        imageUrl TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // Table to store the exercises within each custom workout
    await db.execute('''
      CREATE TABLE custom_workout_exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutId INTEGER NOT NULL,
        exerciseId INTEGER NOT NULL, -- The ID from your main server exercise library
        exerciseName TEXT NOT NULL, -- Denormalized for easy display
        animationUrl TEXT,
        exerciseOrder INTEGER NOT NULL,
        unit TEXT NOT NULL, -- 'REPS' or 'SECONDS'
        value INTEGER NOT NULL,
        FOREIGN KEY (workoutId) REFERENCES custom_workouts (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- CRUD Methods for Custom Workouts ---

  // Example: Insert a new custom workout
  // You would build out methods for get, update, and delete as well.
  Future<int> createCustomWorkout(String name) async {
    final db = await database;
    // In a real implementation, you would pass a full workout object
    final id = await db.insert('custom_workouts', {
      'name': name,
      'createdAt': DateTime.now().toIso8601String(),
    });
    return id;
  }

  // Example: Get all custom workouts
  Future<List<Map<String, dynamic>>> getCustomWorkouts() async {
    final db = await database;
    return await db.query('custom_workouts', orderBy: 'createdAt DESC');
  }
}
