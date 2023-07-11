import 'package:flutter/material.dart';
import 'package:oxford_consultor/services/api_services.dart';
import 'package:oxford_consultor/widgets/dynamic_phone_number_info_box.dart';
import 'package:oxford_consultor/widgets/phone_number_field.dart';

import '../models/phone_number.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  String phoneNumberString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(), //aqui va el logo
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PhoneNumberField(
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    phoneNumberString = value;
                  });
                },
              )
            ]),
        if (phoneNumberString.length >= 12)
          FutureBuilder<PhoneNumber?>(
            future: ApiService().getPhoneNumber(phoneNumberString),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display a loading indicator while waiting for the API response
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error message if an error occurs
              } else {
                return DynamicPhoneNumberInfoBox(
                    phoneNumber: snapshot
                        .data!); // Pass the future directly to the DynamicPhoneNumberInfoBox
              }
            },
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SnackBar(
            content: Text(controller.value.text),
          );
        },
      ),
    );
  }
}
