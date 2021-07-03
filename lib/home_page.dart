import 'package:flutter/material.dart';
import 'package:learning_bloc/employee.dart';
import 'package:learning_bloc/employee_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Bloc Learn',
        ),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (context, AsyncSnapshot<List<Employee>> snapshot) {
            if(snapshot.hasError || snapshot.data == null){
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data[index].id}.",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data[index].name}",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              double.parse((snapshot.data[index].salary).toStringAsFixed(3)).toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.thumb_up_sharp,
                          ),
                          color: Colors.green,
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrement.add(
                              snapshot.data[index],
                            );
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.thumb_down_sharp,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecrement.add(
                              snapshot.data[index],
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
