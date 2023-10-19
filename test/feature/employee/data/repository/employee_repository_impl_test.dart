import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/core/models/response.dart';
import 'package:mobile_assessment/core/network/network_info.dart';
import 'package:mobile_assessment/feature/employee/data/datasource/employee_datasource.dart';
import 'package:mobile_assessment/feature/employee/data/repository/employee_repository_impl.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'employee_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EmployeeDataSource>(), MockSpec<NetworkInfo>()])
main() {
  late NetworkInfo networkInfo;
  late EmployeeDataSource dataSource;
  late EmployeeRepositoryImpl repo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockEmployeeDataSource();
    repo = EmployeeRepositoryImpl(networkInfo, dataSource);
  });

  group("Online", () {
    StatusResponse response =
        StatusResponse(success: true, message: "Successful", data: [{}]);
    when(networkInfo.isConnected).thenAnswer((_) async => true);
    test("get remoteSource and save data to local DB", () async {
      when(dataSource.remoteDataSource()).thenAnswer((_) async => response);

      final res = await repo.getEmployee();

      // final EmployeeEntity actual = res;
      // actual.

      // verify(dataSource.saveToLocal(EmployeeData.[{}]));

      // expect(actual, response);
    });
  });
}
