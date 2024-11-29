import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), // HomePage as the root of the app
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the StaffPage
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StaffPage()), // Navigate to StaffPage
            );
          },
          child: Text('Go to Staff Directory'),
        ),
      ),
    );
  }
}

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Staff Directory',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new staff page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStaffPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter options (optional)
            SizedBox(height: 20),
            // Staff List
            Expanded(child: _buildStaffList(context)),
          ],
        ),
      ),
    );
  }

  // Staff List: Displays a list of staff with brief details
  Widget _buildStaffList(BuildContext context) {
    List<Staff> staffList = [
      Staff(id: 'S001', name: 'John Doe', role: 'IT Specialist'),
      Staff(id: 'S002', name: 'Jane Smith', role: 'HR Manager'),
      // Add more staff here
    ];

    if (staffList.isEmpty) {
      return Center(
          child: Text('No staff found', style: TextStyle(fontSize: 18)));
    }

    return ListView.builder(
      itemCount: staffList.length,
      itemBuilder: (context, index) {
        final staff = staffList[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple,
              child: Text(staff.name[0],
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            title:
                Text(staff.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('ID: ${staff.id} | Role: ${staff.role}',
                style: TextStyle(color: Colors.grey[700])),
            trailing: Icon(Icons.arrow_forward, color: Colors.deepPurple),
            onTap: () {
              // Navigate to staff detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StaffDetailPage(staff: staff),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Staff Model
class Staff {
  final String id;
  final String name;
  final String role;

  Staff({required this.id, required this.name, required this.role});
}

// AddStaffPage for adding a new staff member
class AddStaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Staff',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the current page off the stack
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Staff Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Staff Role',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle adding staff functionality here
              },
              child: Text('Save Staff'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// StaffDetailPage to show staff's full details
class StaffDetailPage extends StatelessWidget {
  final Staff staff;

  StaffDetailPage({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(staff.name, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the current page off the stack
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Staff ID: ${staff.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Role: ${staff.role}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle edit or update action
              },
              child: Text('Edit Staff Info'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
