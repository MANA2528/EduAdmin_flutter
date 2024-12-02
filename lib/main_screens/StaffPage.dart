import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Back navigation
          },
        ),
        title: Text("Staff Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Text(
              "Welcome to the Staff Management Page!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            // Search bar
            _buildSearchBar(),
            SizedBox(height: 20),
            // Staff Overview
            _buildStaffInfoCard("Total Staff", "150", Icons.people),
            _buildStaffInfoCard("Active Staff", "130", Icons.check_circle),
            _buildStaffInfoCard("Pending Approval", "20", Icons.access_time),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(context, "Add Staff", Icons.add),
                _buildActionButton(context, "View Details", Icons.visibility),
              ],
            ),
            SizedBox(height: 20),
            // Staff List
            Expanded(child: _buildStaffList()),
          ],
        ),
      ),
    );
  }

  // Search bar (to filter staff members)
  Widget _buildSearchBar() {
    return CupertinoSearchTextField(
      padding: EdgeInsets.symmetric(horizontal: 10),
      placeholder: 'Search staff...',
      onChanged: (text) {
        // Implement search logic
        print("Searching for: $text");
      },
    );
  }

  // Staff info card (Reusable)
  Widget _buildStaffInfoCard(String title, String count, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          count,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Action button (Reusable)
  Widget _buildActionButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implement action (e.g., navigate to a new page or show a dialog)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$title clicked")),
        );
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Staff List (Scrollable with clickable items)
  Widget _buildStaffList() {
    List<String> staffMembers = [
      'John Doe - Developer',
      'Jane Smith - HR',
      'Michael Brown - Manager',
      'Sarah Lee - Designer',
      'David Wilson - Developer',
    ];

    return ListView.builder(
      itemCount: staffMembers.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                staffMembers[index]
                    [0], // Initial letter of the staff member's name
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(staffMembers[index]),
            trailing: Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () {
              // Implement navigation or other actions here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${staffMembers[index]} clicked")),
              );
            },
          ),
        );
      },
    );
  }
}
