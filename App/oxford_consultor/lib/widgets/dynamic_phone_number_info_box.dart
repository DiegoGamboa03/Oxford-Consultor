import 'package:flutter/material.dart';
import 'package:oxford_consultor/models/phone_number.dart';
import 'package:oxford_consultor/services/api_services.dart';

class DynamicPhoneNumberInfoBox extends StatefulWidget {
  const DynamicPhoneNumberInfoBox(
      {super.key, required this.phoneNumber, this.phoneNumberString});

  final PhoneNumber? phoneNumber;
  final String? phoneNumberString;
  @override
  State<DynamicPhoneNumberInfoBox> createState() =>
      _DynamicPhoneNumberInfoBoxState();
}

class _DynamicPhoneNumberInfoBoxState extends State<DynamicPhoneNumberInfoBox> {
  late String observationString;
  late String stateString;
  late String expirationDateString;
  late String dropdownValue;
  List<String> optionslist = <String>[
    'Llamada efectuada',
    'No interesado',
    'No posee recursos en este momento',
    'No llamar mas',
    'No posee tiempo'
  ];

  Future<PhoneNumber?>? phoneNumberFuture; // Define the Future variable

  @override
  void initState() {
    observationString =
        (widget.phoneNumber?.observation ?? 'No existe una observacion');
    stateString =
        (widget.phoneNumber?.state == 'A') ? 'Disponible' : 'No disponible';
    expirationDateString =
        (widget.phoneNumber?.expirationDate ?? 'No tiene fecha de vencimiento');
    dropdownValue = 'Llamada efectuada';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.phoneNumber != null)
          ? Column(children: [
              //Numero existe
              Text(widget.phoneNumber!.phoneNumber),
              Text('Estado: $stateString'),
              Text('Observacion: $observationString'),
              Text(
                  'Fecha de ultima actualizacion: ${widget.phoneNumber!.lastUpdateDate}'),
              Text('Fecha de vencimiento: $expirationDateString'),
              (widget.phoneNumber!.state == 'A')
                  ? Column(children: [
                      DropdownButton<String>(
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
                        items: optionslist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {},
                        child: const Text('Procesar'),
                      ),
                    ])
                  : Container(),
            ])
          : Column(
              //Numero no existe
              children: [
                const Text('Este numero no ha sido registrado'),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    ApiService()
                        .createPhoneNumber(widget.phoneNumberString!)
                        .then((flag) {
                      if (flag) {
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('AlertDialog Title'),
                                  content:
                                      const Text('AlertDialog description'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                    });
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
    );
  }
}
