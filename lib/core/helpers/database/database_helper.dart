import 'package:flutter/widgets.dart';
import 'package:mobile_assessment/core/error/exception.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    return openDatabase(
      join(await getDatabasesPath(), 'i_recharge.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE employee(id INTEGER PRIMARY KEY, 
          firstName TEXT, lastName TEXT, designation TEXT, 
          level INTEGER, productivityScore REAL, currentSalary TEXT, 
          employmentStatus INTEGER)''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertAllEmployee(List<EmployeeData> employee) async {
    final db = await init();
    for (final element in employee) {
      await db.insert(
        'employee',
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<EmployeeData>> fetctEmployeeById(int id) async {
    final db = await init();
    final List<Map<String, dynamic>> employee =
        await db.query('employee', where: 'id = ?', whereArgs: [id]);
    return List.generate(employee.length, (index) {
      return EmployeeData(
          id: employee[index]['id'],
          firstName: employee[index]['firstName'],
          lastName: employee[index]['lastName'],
          level: employee[index]['level'],
          newLevel: determineNewLevel(
              employee[index]['productivityScore'], employee[index]['level']),
          designation: employee[index]['designation'],
          productivityScore: employee[index]['productivityScore'],
          currentSalary: employee[index]['currentSalary'],
          employmentStatus: employee[index]['employmentStatus']);
    });
  }

  static int determineNewLevel(double score, int level) {
    if (score >= 80 && score <= 100) {
      return level + 1;
    } else if (score >= 50 && score <= 79) {
      return level;
    } else if (score >= 40 && score <= 49) {
      return level - 1;
    } else {
      return -1;
    }
  }

  static Future<List<EmployeeData>> fetctEmployeeByKeys(
      Map<String, String> keys) async {
    final db = await init();
    final List<Map<String, dynamic>> employee = await db.query('employee',
        where: 'firstName = ? and designation = ?',
        whereArgs: [keys['firstName'], keys['level'], keys['designation']]);
    return List.generate(employee.length, (index) {
      return EmployeeData(
          id: employee[index]['id'],
          firstName: employee[index]['firstName'],
          lastName: employee[index]['lastName'],
          level: employee[index]['level'],
          designation: employee[index]['designation'],
          productivityScore: employee[index]['productivityScore'],
          currentSalary: employee[index]['currentSalary'],
          employmentStatus: employee[index]['employmentStatus']);
    });
  }

  static Future<List<EmployeeData>> fetctEmployees() async {
    try {
      final db = await init();
      final List<Map<String, dynamic>> employee = await db.query('employee');
      return List.generate(employee.length, (index) {
        return EmployeeData(
            id: employee[index]['id'],
            firstName: employee[index]['firstName'],
            lastName: employee[index]['lastName'],
            level: employee[index]['level'],
            designation: employee[index]['designation'],
            productivityScore: employee[index]['productivityScore'],
            currentSalary: employee[index]['currentSalary'],
            employmentStatus: employee[index]['employmentStatus']);
      });
    } catch (e) {
      throw const CacheException(msg: "Cache Error");
    }
  }
}
