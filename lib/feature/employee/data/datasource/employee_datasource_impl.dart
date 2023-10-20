import 'package:mobile_assessment/core/error/exception.dart';
import 'package:mobile_assessment/core/error/failure.dart';
import 'package:mobile_assessment/core/helpers/api/data.dart';
import 'package:mobile_assessment/core/helpers/database/database_helper.dart';
import 'package:mobile_assessment/core/models/response.dart';
import 'package:mobile_assessment/feature/employee/data/datasource/employee_datasource.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';

class EmployeeDataSourceImpl implements EmployeeDataSource {
  @override
  Future<EmployeeEntity> filterEmployeeByKeyslocalDataSource(
      Map<String, String> keys) async {
    try {
      final employees = await DatabaseHelper.fetctEmployeeByKeys(keys);
      return EmployeeEntity(msg: "successful", employees: employees);
    } on CacheException catch (e) {
      throw CacheFailure(msg: e.msg ?? "Something went wrong");
    }
  }

  @override
  Future<EmployeeData> getEmployeeByIdLocalDataSource(int id) async {
    try {
      final response = await DatabaseHelper.fetctEmployeeById(id);
      return response.first;
    } on CacheException catch (e) {
      throw CacheFailure(msg: e.msg ?? "Something went wrong");
    }
  }

  @override
  Future<EmployeeEntity> localDataSource() async {
    try {
      final data = await DatabaseHelper.fetctEmployees();
      return EmployeeEntity(msg: "Successful", employees: data);
    } on CacheException catch (e) {
      throw CacheFailure(msg: e.msg ?? "Something went wrong");
    }
  }

  @override
  Future<EmployeeEntity> remoteDataSource() async {
    final response = StatusResponse.fromJson(Api.successResponse);
    final employees = toEmployeeDataList(response.data);
    await saveToLocal(employees);
    return await localDataSource();
  }

  @override
  Future<void> saveToLocal(List<EmployeeData> employee) async {
    await DatabaseHelper.insertAllEmployee(employee);
  }

  static List<EmployeeData> toEmployeeDataList(
      List<Map<String, dynamic>> response) {
    List<EmployeeData> employees = <EmployeeData>[];
    try {
      for (final element in response) {
        employees.add(EmployeeData(
            id: element['id'],
            firstName: element['first_name'],
            lastName: element['last_name'],
            level: element['level'],
            designation: element['designation'],
            productivityScore: element['productivity_score'],
            currentSalary: element['current_salary'],
            employmentStatus: element['employment_status']));
      }
    } catch (e) {
      throw const CacheException(msg: "Something went wrong");
    }

    return employees;
  }
}
