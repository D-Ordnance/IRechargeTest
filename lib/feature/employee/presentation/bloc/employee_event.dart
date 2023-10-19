part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployeesEvent extends EmployeeEvent {}

class FetchEmployeeDetailByIdEvent extends EmployeeEvent {
  final int id;
  const FetchEmployeeDetailByIdEvent(this.id);
}

class FetchEmployeesByKeysEvent extends EmployeeEvent {
  final Map<String, String> keys;
  const FetchEmployeesByKeysEvent(this.keys);
}
