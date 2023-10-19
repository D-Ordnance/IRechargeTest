import 'package:flutter/widgets.dart';
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
          first_name TEXT, last_name TEXT, designation TEXT, 
          level INTEGER, productivity_score REAL, current_salary TEXT, 
          employment_status INTEGER)''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertAllEmployee(List<EmployeeData> employee) async {
    final db = await init();
    employee.forEach((element) async {
      await db.insert(
        'employee',
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
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
          designation: employee[index]['designation'],
          employeeScore: employee[index]['employeeScore'],
          currentSalary: employee[index]['currentSalary'],
          employmentStatus: employee[index]['employmentStatus']);
    });
  }

  static Future<List<EmployeeData>> fetctEmployeeByKeys(
      Map<String, String> keys) async {
    final db = await init();
    final List<Map<String, dynamic>> employee = await db.query('employee',
        where: 'firstName = ? and level = ? and designation = ?',
        whereArgs: [keys['firstName'], keys['level'], keys['designation']]);
    return List.generate(employee.length, (index) {
      return EmployeeData(
          id: employee[index]['id'],
          firstName: employee[index]['firstName'],
          lastName: employee[index]['lastName'],
          level: employee[index]['level'],
          designation: employee[index]['designation'],
          employeeScore: employee[index]['employeeScore'],
          currentSalary: employee[index]['currentSalary'],
          employmentStatus: employee[index]['employmentStatus']);
    });
  }

  static Future<List<EmployeeData>> fetctEmployees() async {
    final db = await init();
    final List<Map<String, dynamic>> employee = await db.query('employee');
    return List.generate(employee.length, (index) {
      return EmployeeData(
          id: employee[index]['id'],
          firstName: employee[index]['firstName'],
          lastName: employee[index]['lastName'],
          level: employee[index]['level'],
          designation: employee[index]['designation'],
          employeeScore: employee[index]['employeeScore'],
          currentSalary: employee[index]['currentSalary'],
          employmentStatus: employee[index]['employmentStatus']);
    });
  }
}
