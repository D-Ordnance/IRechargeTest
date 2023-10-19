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
    saveToLocal(employees);
    return await localDataSource();
  }

  @override
  Future<void> saveToLocal(List<EmployeeData> employee) async {
    await DatabaseHelper.insertAllEmployee(employee);
  }

  static List<EmployeeData> toEmployeeDataList(
      List<Map<String, dynamic>> response) {
    List<EmployeeData> employees = List.empty();
    response.forEach((element) => employees.add(EmployeeData(
        id: element['id'],
        firstName: element['firstName'],
        lastName: element['lastName'],
        level: element['level'],
        designation: element['designation'],
        employeeScore: element['employeeScore'],
        currentSalary: element['currentSalary'],
        employmentStatus: element['employmentStatus'])));
    return employees;
  }
}
