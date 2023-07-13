import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¡Bienvenido!',
                  style: GoogleFonts.roboto(
                      color: const Color(0xff4043CF),
                      fontWeight: FontWeight.bold,
                      fontSize: 32)),
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
                child: Text('Ingrese el numero que quiera consultar',
                    style: GoogleFonts.roboto(
                        color: const Color(0xff4043CF), fontSize: 16)),
              ),
            ],
          ),
        ),
        Center(
          child: PhoneNumberField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                phoneNumberString = value;
              });
            },
          ),
        ),
        Container(
          height: height * 0.5,
          width: width * 0.9,
          color: Colors.white60,
          child: Column(
            children: [
              if (phoneNumberString.length >= 12)
                FutureBuilder<PhoneNumber?>(
                  future: ApiService().getPhoneNumber(phoneNumberString),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: Color(0xff4043CF),
                      ); // Display a loading indicator while waiting for the API response
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Display an error message if an error occurs
                    } else {
                      return DynamicPhoneNumberInfoBox(
                          phoneNumber: snapshot
                              .data); // Pass the future directly to the DynamicPhoneNumberInfoBox
                    }
                  },
                ),
            ],
          ),
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
