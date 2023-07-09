import 'package:flutter/material.dart';
import 'package:oxford_consultor/models/phone_number.dart';
import 'package:oxford_consultor/pages/create_phone_number.dart';
import 'package:oxford_consultor/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<PhoneNumber> phoneNumberFuture;

  List<String> optionslist = <String>[
    'Llamada efectuada',
    'No interesado',
    'No posee recursos en este momento',
    'No llamar mas',
    'No posee tiempo'
  ];

  String dropdownValue = 'Llamada efectuada';

  @override
  void initState() {
    super.initState();
    phoneNumberFuture = ApiService().occupyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Llame al siguiente numero:'),
            FutureBuilder<PhoneNumber>(
              future: phoneNumberFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: height * 0.015,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data!.phoneNumber.toString()),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          tooltip: 'Llamar',
                          onPressed: () {
                            _makePhoneCall(
                                snapshot.data!.phoneNumber.toString());
                          },
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                      'Hubo un error cargando el numero de telefono');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.015,
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                style: const TextStyle(color: Colors.blue),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items:
                    optionslist.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.015,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  phoneNumberFuture.then((value) {
                    ApiService()
                        .updateObservation(
                            value.phoneNumber.toString(), dropdownValue)
                        .then((value) {
                      if (value == '200') {
                        setState(() {
                          phoneNumberFuture = ApiService().occupyPhoneNumber();
                        });
                      }
                    });
                  });
                },
                child: const Text('Procesar'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreatePhoneNumberPage()));
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
