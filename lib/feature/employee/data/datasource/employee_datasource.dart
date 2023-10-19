import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';

import '../../domain/entity/employee_entity.dart';

abstract class EmployeeDataSource {
  Future<EmployeeEntity> remoteDataSource();
  Future<EmployeeEntity> localDataSource();
  Future<void> saveToLocal(List<EmployeeData> employee);

  Future<EmployeeData> getEmployeeByIdLocalDataSource(int id);

  Future<EmployeeEntity> filterEmployeeByKeyslocalDataSource(
      Map<String, String> keys);
}
