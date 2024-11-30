import 'package:flutter/material.dart';
import 'package:flutter_application_1/main_screens/CertificatePage.dart';
import 'package:flutter_application_1/main_screens/EnquiryPage.dart';
import 'package:flutter_application_1/main_screens/FeesPage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFF6F46B7), // Purple accent for highlights
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black45),
      ),
      cardTheme: CardTheme(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFFC107)),
    ),
    home: HomePage(),
    routes: {
      '/dashboard': (context) =>
          Scaffold(appBar: AppBar(title: const Text('Dashboard'))),
      '/profile': (context) =>
          Scaffold(appBar: AppBar(title: const Text('Profile'))),
      '/logout': (context) =>
          Scaffold(appBar: AppBar(title: const Text('Log Out'))),
      '/staff': (context) => StaffPage(), // StaffPage screen
      '/students': (context) => StudentPage(), // StudentPage screen
      '/settings': (context) =>
          Scaffold(appBar: AppBar(title: const Text('Settings'))),
      '/courses': (context) => CoursesPage(), // Define CoursesPage screen
    },
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            SizedBox(height: 20),
            _buildQuickActionsSection(context),
            SizedBox(height: 30),
            SectionTitleBar(title: 'Quick Activity'),
            SizedBox(height: 10),
            SectionTitleBar(title: 'Recent Activities'),
            SizedBox(height: 10),
            _buildRecentActivityList(),
            SizedBox(height: 20),
            SectionTitleBar(title: 'Notifications'),
            SizedBox(height: 10),
            _buildNotificationCard(
                'New student registration pending approval', Icons.warning),
            _buildNotificationCard('Staff meeting scheduled for tomorrow',
                Icons.notifications_active),
            _buildNotificationCard('Fee payment due for next semester',
                Icons.account_balance_wallet),
            SizedBox(height: 30),
            SectionTitleBar(title: 'Statistics'),
            SizedBox(height: 10),
            _buildStatsCard('Total Students', 1200, Icons.school),
            _buildStatsCard('Total Staff', 150, Icons.group),
            _buildStatsCard('Courses Offered', 35, Icons.menu_book),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.school, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'EduAdmin',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: 100.0,
      backgroundColor: Color.fromARGB(255, 111, 70, 181),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(Icons.person, color: Colors.deepPurple, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Text(
      'Welcome to EduAdmin',
      style: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard(context, 'Staff', Icons.people, Colors.blue, '/staff'),
            _buildCard(
                context, 'Students', Icons.school, Colors.green, '/students'),
            _buildCard(context, 'Enquiries', Icons.message, Colors.orange,
                '/settings'),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard(
                context, 'Fees', Icons.payment, Colors.pink, '/dashboard'),
            _buildCard(context, 'Certificates', Icons.document_scanner,
                Colors.yellow, '/profile'),
            _buildCard(
                context, 'Courses', Icons.book, Colors.purple, '/courses'),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            if (route == '/staff') {
              return StaffPage();
            } else if (route == '/students') {
              return StudentPage();
            } else if (route == '/enquiries') {
              return EnquiryPage();
            } else if (route == '/fees') {
              return FeesPage();
            } else if (route == '/certificates') {
              return CertificatePage();
            } else if (route == '/courses') {
              return CoursesPage();
            } else {
              return Scaffold();
            }
          },
        ));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.3),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Column(
      children: [
        _buildActivityCard('Course update: Math 101 syllabus uploaded',
            Icons.update, Colors.purple),
        _buildActivityCard('Student John Doe completed the exam',
            Icons.assignment_turned_in, Colors.purple),
        _buildActivityCard('Fee payment by student Jane Doe processed',
            Icons.payment, Colors.purple),
      ],
    );
  }

  Widget _buildActivityCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildNotificationCard(String message, IconData icon) {
    return Card(
      color: Colors.amber[100],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(message, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildStatsCard(String title, int count, IconData icon) {
    return Card(
      color: Colors.blue[100],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontSize: 18)),
        trailing: Text('$count', style: TextStyle(fontSize: 22)),
      ),
    );
  }

  Widget SectionTitleBar({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        Icon(Icons.arrow_forward, color: Colors.deepPurple),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Admin Name'),
            accountEmail: Text('admin@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50.0),
            ),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: Center(
        child: Text('Welcome to the Student Page!'),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Courses")),
      body: Center(
        child: Text("Courses Page Content Here"),
      ),
    );
  }
}

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page"),
      ),
      body: Center(
        child: Text("Welcome to the Staff Page!"),
      ),
    );
  }
}
