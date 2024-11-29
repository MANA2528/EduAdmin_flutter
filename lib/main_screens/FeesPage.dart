import 'package:flutter/material.dart';

// Sample data for students and fees
class Student {
  final String name;
  final double feesDue;
  final DateTime dueDate;
  bool isPaid;

  Student({
    required this.name,
    required this.feesDue,
    required this.dueDate,
    this.isPaid = false,
  });
}

class FeesPage extends StatefulWidget {
  @override
  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  // Sample list of students with fees
  final List<Student> studentList = [
    Student(
      name: 'John Doe',
      feesDue: 500.00,
      dueDate: DateTime(2024, 12, 1),
    ),
    Student(
      name: 'Jane Smith',
      feesDue: 450.00,
      dueDate: DateTime(2024, 12, 15),
    ),
    Student(
      name: 'Michael Brown',
      feesDue: 600.00,
      dueDate: DateTime(2024, 12, 10),
    ),
  ];

  // Function to handle fee payment
  void markAsPaid(Student student) {
    setState(() {
      student.isPaid = true; // Mark fee as paid
    });

    // Optionally, show a confirmation Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fees for ${student.name} marked as paid!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Fees'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Fee Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  final student = studentList[index];
                  return Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        student.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fees Due: \$${student.feesDue.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            'Due Date: ${student.dueDate.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (student.isPaid)
                            Icon(Icons.check_circle, color: Colors.green)
                          else
                            ElevatedButton(
                              onPressed: () => markAsPaid(student),
                              child: Text('Mark as Paid'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeesPage(),
  ));
}
