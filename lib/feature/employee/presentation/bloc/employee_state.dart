part of 'employee_bloc.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

class Loading extends EmployeeState {}

class Success extends EmployeeState {
  final EmployeeEntity response;
  const Success({required this.response});
}

class IdFetchSuccessful extends EmployeeState {
  final EmployeeData response;
  const IdFetchSuccessful({required this.response});
}

class Error extends EmployeeState {
  final String message;
  const Error({required this.message});
}
