import 'package:dartz/dartz.dart';
import 'package:mobile_assessment/core/error/exception.dart';
import 'package:mobile_assessment/core/error/failure.dart';
import 'package:mobile_assessment/feature/employee/data/datasource/employee_datasource.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';
import 'package:mobile_assessment/feature/employee/domain/repository/employee_repository.dart';

import '../../../../core/network/network_info.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  static const String GENERIC_ERROR_MSG = "Something went wrong";

  late EmployeeDataSource dataSource;
  late NetworkInfo networkInfo;
  EmployeeRepositoryImpl(this.networkInfo, this.dataSource);
  @override
  Future<Either<Failure, EmployeeEntity>> getEmployee() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.remoteDataSource();
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg ?? "Something went wrong"));
      }
    } else {
      return const Left(ServerFailure(msg: "No network connection"));
    }
  }

  @override
  Future<Either<Failure, EmployeeData>> getEmployeeDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getEmployeeByIdLocalDataSource(id);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg ?? GENERIC_ERROR_MSG));
      }
    } else {
      return const Left(ServerFailure(msg: "No network connection"));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getFilteredEmployees(
      Map<String, String> keys) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dataSource.filterEmployeeByKeyslocalDataSource(keys);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg ?? GENERIC_ERROR_MSG));
      }
    } else {
      return const Left(ServerFailure(msg: GENERIC_ERROR_MSG));
    }
  }
}
