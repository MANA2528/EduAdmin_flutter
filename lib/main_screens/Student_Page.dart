import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  // Example list of students
  final List<Map<String, String>> students = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '123-456-7890',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'phone': '234-567-8901',
    },
    {
      'name': 'Emily Johnson',
      'email': 'emily.johnson@example.com',
      'phone': '345-678-9012',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentCard(
            student: students[index],
          );
        },
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final Map<String, String> student;

  StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(student['name']!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${student['email']}'),
            Text('Phone: ${student['phone']}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // On tap, show student details in an alert dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(student['name']!),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${student['email']}'),
                  Text('Phone: ${student['phone']}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
