import 'dart:async';
import 'package:learning_bloc/employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.00),
    Employee(2, "Employee Two", 20000.00),
    Employee(3, "Employee Three", 30000.00),
    Employee(4, "Employee Four", 40000.00),
    Employee(5, "Employee Five", 50000.00),
  ];

  final _employeeStreamController = StreamController<List<Employee>>();
  final _incrementStreamController = StreamController<Employee>();
  final _decrementStreamController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream =>
      _employeeStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _incrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _decrementStreamController.sink;

  EmployeeBloc() {
    _employeeStreamController.add(
      _employeeList,
    );
    _incrementStreamController.stream.listen(
      _incrementSalary,
    );
    _decrementStreamController.stream.listen(
      _decrementSalary,
    );
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double newSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + newSalary;
    employeeListSink.add(
      _employeeList,
    );
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double newSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - newSalary;
    employeeListSink.add(
      _employeeList,
    );
  }

  void dispose() {
    _incrementStreamController.close();
    _decrementStreamController.close();
    _employeeStreamController.close();
  }
}
