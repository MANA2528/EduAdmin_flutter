import 'package:flutter/material.dart';

// Course model
class Course {
  String title;
  String description;
  String instructor;
  String duration;

  Course({
    required this.title,
    required this.description,
    required this.instructor,
    required this.duration,
  });
}

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  // Sample list of courses
  List<Course> courses = [
    Course(
      title: 'Flutter Development',
      description: 'Learn to build apps with Flutter',
      instructor: 'John Doe',
      duration: '3 Months',
    ),
    Course(
      title: 'Data Science with Python',
      description: 'An introduction to data science concepts using Python',
      instructor: 'Jane Smith',
      duration: '4 Months',
    ),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Add or edit course
  void _addOrEditCourse([Course? course]) {
    if (course != null) {
      _titleController.text = course.title;
      _descriptionController.text = course.description;
      _instructorController.text = course.instructor;
      _durationController.text = course.duration;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course == null ? 'Add Course' : 'Edit Course'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Course Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Course Description'),
            ),
            TextField(
              controller: _instructorController,
              decoration: InputDecoration(labelText: 'Instructor'),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Validate and save course
              if (_titleController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _instructorController.text.isNotEmpty &&
                  _durationController.text.isNotEmpty) {
                setState(() {
                  if (course == null) {
                    // Add new course
                    courses.add(Course(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      instructor: _instructorController.text,
                      duration: _durationController.text,
                    ));
                  } else {
                    // Update existing course
                    course.title = _titleController.text;
                    course.description = _descriptionController.text;
                    course.instructor = _instructorController.text;
                    course.duration = _durationController.text;
                  }
                });
                Navigator.pop(context);
                _clearTextFields();
              }
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearTextFields();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Clear text fields
  void _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
    _instructorController.clear();
    _durationController.clear();
  }

  // Delete a course
  void _deleteCourse(Course course) {
    setState(() {
      courses.remove(course);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Course "${course.title}" has been deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addOrEditCourse(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  course.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(course.instructor),
                trailing: Wrap(
                  spacing: 8.0, // space between icons
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _addOrEditCourse(course),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteCourse(course),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CoursePage(),
  ));
}
