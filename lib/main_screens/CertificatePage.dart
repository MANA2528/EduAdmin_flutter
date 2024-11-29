import 'package:flutter/material.dart';

// Sample data for students and certificates
class Student {
  final String name;
  final String course;
  final DateTime completionDate;
  bool isCertified;

  Student({
    required this.name,
    required this.course,
    required this.completionDate,
    this.isCertified = false,
  });
}

class CertificatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  // Sample list of students with their certificate status
  final List<Student> studentList = [
    Student(
      name: 'John Doe',
      course: 'Flutter Development',
      completionDate: DateTime(2024, 10, 20),
    ),
    Student(
      name: 'Jane Smith',
      course: 'Data Science',
      completionDate: DateTime(2024, 11, 10),
    ),
    Student(
      name: 'Michael Brown',
      course: 'Mobile App Development',
      completionDate: DateTime(2024, 9, 30),
    ),
  ];

  // Function to issue certificate to a student
  void issueCertificate(Student student) {
    setState(() {
      student.isCertified = true; // Mark student as certified
    });

    // Optionally, show a confirmation Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Certificate issued to ${student.name}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Certificates'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Certificate Management',
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
                            'Course: ${student.course}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            'Completion Date: ${student.completionDate.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (student.isCertified)
                            Icon(Icons.check_circle, color: Colors.green)
                          else
                            ElevatedButton(
                              onPressed: () => issueCertificate(student),
                              child: Text('Issue Certificate'),
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
    home: CertificatePage(),
  ));
}
