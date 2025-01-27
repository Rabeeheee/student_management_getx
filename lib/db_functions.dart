import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_getx/model/model.dart';

class DatabaseHelper extends GetxController {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  final students = <StudentModel>[].obs;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            grade TEXT,
            age TEXT,
            guardianName TEXT,
            guardianPhone TEXT,
            profileImage TEXT
          )
        ''');
      },
    );
  }

  Future<List<StudentModel>> fetchStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return StudentModel.fromMap(maps[i]);
    });
  }

  Future<void> insertStudent(StudentModel student) async {
    final db = await database;
    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await refreshStudents();
  }

  Future<void> deleteStudent(int id) async {
    final db = await database;
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
    await refreshStudents();
  }

  Future<void> updateStudent(StudentModel updatedStudent) async {
    final db = await database;
    await db.update(
      'students',
      updatedStudent.toMap(),
      where: 'id = ?',
      whereArgs: [updatedStudent.id],
    );
    await refreshStudents();
  }

  Future<void> refreshStudents() async {
    final studentList = await fetchStudents(); 
    students.assignAll(studentList); 
  }
}
