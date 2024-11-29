import 'package:flutter/material.dart';

// Enquiry Form Page
class EnquiryPage extends StatefulWidget {
  @override
  _EnquiryPageState createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  // To store the result of submission
  bool _isSubmitted = false;

  // Function to handle form submission
  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _messageController.text.isEmpty) {
      // Show a message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    // Handle data submission (e.g., send data to a backend)
    setState(() {
      _isSubmitted = true;
    });

    // You can integrate a backend service here like Firebase or REST API
    // For now, we just display a message to indicate submission

    // Reset form (Optional)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSubmitted = false; // Reset submission state
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Form'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isSubmitted)
              Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                    SizedBox(height: 10),
                    Text('Thank you for your enquiry!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        )),
                  ],
                ),
              )
            else ...[
              Text(
                'We are happy to assist you. Please fill in the details below:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Phone Field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Message Field
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Enquiry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EnquiryPage(),
  ));
}
