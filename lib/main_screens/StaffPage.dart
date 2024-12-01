//import 'package:charts_flutter/flutter.dart' as charts;
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
        title: Text(
          "Staff Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            // Search bar
            _buildSearchBar(),
            SizedBox(height: 20),
            // Staff info section (example content)
            Text(
              "Staff Overview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            _buildStaffInfoCard("Total Staff", "150", Icons.people),
            SizedBox(height: 15),
            _buildStaffInfoCard("Active Staff", "130", Icons.check_circle),
            SizedBox(height: 15),
            _buildStaffInfoCard(
                "Staff Pending Approval", "20", Icons.access_time),
            SizedBox(height: 20),
            // Bar chart for Staff Distribution
            //_buildStaffChart(),
            SizedBox(height: 30),
            // Action Buttons (e.g., Add Staff, View Details)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                    context, "Add Staff", Icons.add, Colors.blue),
                _buildActionButton(
                    context, "View Details", Icons.visibility, Colors.green),
              ],
            ),
            SizedBox(height: 30),
            // Staff List (interactive)
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
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
          size: 40,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: Text(
          count,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  // Action button (Reusable)
  Widget _buildActionButton(
      BuildContext context, String title, IconData icon, Color color) {
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
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
      ),
    );
  }

  // Bar Chart for staff distribution (Active vs Pending)
  // Widget _buildStaffChart() {
  //var data = [
  // StaffData('Active', 130),
  // StaffData('Pending', 20),
  //];

  //var series = [
  //charts.Series<StaffData, String>(
  //id: 'Staff Distribution',
  //colorFn: (_, __) => charts.MaterialPalette.deepPurple.shadeDefault,
  //domainFn: (StaffData staff, _) => staff.status,
  //measureFn: (StaffData staff, _) => staff.count,
  //data: data,
  // )
  //];

  //return Container(
  // height: 200,
  // padding: EdgeInsets.all(10),
  // child: charts.BarChart(
  // series,
  // animate: true,
  // vertical: false,
  // barRendererDecorator: charts.BarLabelDecorator<String>(),
  //// domainAxis: charts.OrdinalAxisSpec(
  //   renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
  //  ),
  //),
  // );
  //}

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
          elevation: 5,
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

class StaffData {
  final String status;
  final int count;

  StaffData(this.status, this.count);
}
