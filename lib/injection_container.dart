import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_assessment/core/network/network_info.dart';
import 'package:mobile_assessment/core/network/network_info_impl.dart';
import 'package:mobile_assessment/feature/employee/data/datasource/employee_datasource.dart';
import 'package:mobile_assessment/feature/employee/data/datasource/employee_datasource_impl.dart';
import 'package:mobile_assessment/feature/employee/data/repository/employee_repository_impl.dart';
import 'package:mobile_assessment/feature/employee/domain/repository/employee_repository.dart';
import 'package:mobile_assessment/feature/employee/domain/usecase/fetch_employee.dart';
import 'package:mobile_assessment/feature/employee/domain/usecase/fetch_employee_detail.dart';
import 'package:mobile_assessment/feature/employee/presentation/bloc/employee_bloc.dart';

import 'feature/employee/domain/usecase/fetch_filtered_employee.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory<EmployeeBloc>(
      () => EmployeeBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => FetchEmployees(getIt()));
  getIt.registerLazySingleton(() => FetchEmployeeDetails(getIt()));
  getIt.registerLazySingleton(() => FetchFilteredEmployee(getIt()));

  getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getIt(), getIt()));

  getIt.registerLazySingleton<EmployeeDataSource>(
      () => EmployeeDataSourceImpl());

  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: getIt()));

  getIt.registerLazySingleton(() => Connectivity());
}
