import 'package:dataform/services/db_service.dart';
import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({super.key});

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _age = TextEditingController();

  String _selectedCountry = 'USA'; // To store the selected country

  DbService dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // First name
                SizedBox(
                  width: 450,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Firstname",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    controller: _firstname,
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                // Last name
                SizedBox(
                  width: 450,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Lastname",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    controller: _lastname,
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                // Email
                SizedBox(
                  width: 450,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    controller: _email,
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                // company
                // Added for spacing
                SizedBox(
                  width: 450,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "company",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    controller: _company,
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                SizedBox(
                  width: 450,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue ?? '';
                      });
                    },
                    items: <String>[
                      'USA',
                      'Canada',
                      'UK',
                      'Australia',
                      'Japan',
                      'Germany',
                      'France'
                    ] // Add more countries as needed
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                SizedBox(
                  width: 450,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    controller: _age,
                  ),
                ),
                const SizedBox(height: 15), // Added for spacing

                SizedBox(
                  //signup textbutton
                  width: 170,
                  child: TextButton(
                    onPressed: () async {
                      if (_firstname.text.isEmpty ||
                          _lastname.text.isEmpty ||
                          _email.text.isEmpty ||
                          _age.text.isEmpty ||
                          _selectedCountry.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in all fields.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return; // Exit onPressed callback
                      }

                      String firstName = _firstname.text;
                      String lastName = _lastname.text;
                      String email = _email.text;
                      String company = _company.text;
                      int age = int.tryParse(_age.text) ?? 0;

                      await dbService.insertNewUser(context, firstName,
                          lastName, email, company, _selectedCountry, age);

                      _firstname.clear();
                      _lastname.clear();
                      _email.clear();
                      _company.clear();
                      _age.clear();
                      setState(() {
                        _selectedCountry = 'USA'; // Reset selected country
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
