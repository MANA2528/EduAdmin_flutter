import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduAdmin Staff Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StaffPage(),
    );
  }
}

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final List<Map<String, String>> staffData = [
    {
      'name': 'John Doe',
      'role': 'Math Teacher',
      'email': 'john.doe@example.com',
      'phone': '123-456-7890',
    },
    {
      'name': 'Jane Smith',
      'role': 'Science Teacher',
      'email': 'jane.smith@example.com',
      'phone': '234-567-8901',
    },
    {
      'name': 'Emily Johnson',
      'role': 'History Teacher',
      'email': 'emily.johnson@example.com',
      'phone': '345-678-9012',
    },
  ];

  late List<Map<String, String>> filteredStaffData;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStaffData = staffData;
    searchController.addListener(_filterStaff);
  }

  void _filterStaff() {
    setState(() {
      filteredStaffData = staffData.where((staff) {
        return staff['name']!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            staff['role']!
                .toLowerCase()
                .contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Directory'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StaffSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredStaffData.length,
        itemBuilder: (context, index) {
          return StaffCard(staff: filteredStaffData[index]);
        },
      ),
    );
  }
}

class StaffCard extends StatelessWidget {
  final Map<String, String> staff;

  const StaffCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Text(
            staff['name']![0],
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        title: Text(staff['name']!),
        subtitle: Text(staff['role']!),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed staff page
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(staff['name']!),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Role: ${staff['role']}'),
                  Text('Email: ${staff['email']}'),
                  Text('Phone: ${staff['phone']}'),
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

class StaffSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on search query
    return Center(child: Text('No results found'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggest staff names based on query
    return Center(child: Text('Start typing to search staff'));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }
}
