import 'package:flutter/material.dart';
import 'package:dataform/constants/backend_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> insertNewUser(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String company,
      String country,
      int age) async {
    try {
      // Call the insert method with the user's information
      await _supabase.from(Constans.userDataTable).insert({
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'company': company,
        'Country': country,
        'age': age,
      });

      // Show a dialog indicating successful submission
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submitted'),
            content: Text('Data has been successfully submitted to Supabase.'),
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
    } catch (error) {
      // Handle error if insertion fails
      print('Error submitting data: $error');
    }
  }
}
