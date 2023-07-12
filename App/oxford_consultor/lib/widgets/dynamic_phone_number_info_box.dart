import 'package:flutter/material.dart';
import 'package:oxford_consultor/models/phone_number.dart';

class DynamicPhoneNumberInfoBox extends StatefulWidget {
  const DynamicPhoneNumberInfoBox({super.key, required this.phoneNumber});

  final PhoneNumber? phoneNumber;

  @override
  State<DynamicPhoneNumberInfoBox> createState() =>
      _DynamicPhoneNumberInfoBoxState();
}

class _DynamicPhoneNumberInfoBoxState extends State<DynamicPhoneNumberInfoBox> {
  @override
  Widget build(BuildContext context) {
    String observationString =
        (widget.phoneNumber?.observation ?? 'No existe una observacion');
    String stateString =
        (widget.phoneNumber?.state == 'A') ? 'Disponible' : 'No disponible';
    String expirationDateString =
        (widget.phoneNumber?.expirationDate ?? 'No tiene fecha de vencimiento');
    return Container(
      child: (widget.phoneNumber != null)
          ? Column(children: [
              Text(widget.phoneNumber!.phoneNumber),
              Text('Estado: $stateString'),
              Text('Observacion: $observationString'),
              Text(widget.phoneNumber!.observation ?? 'Placeholder text'),
              Text(
                  'Fecha de ultima actualizacion: ${widget.phoneNumber!.lastUpdateDate}'),
              Text('Fecha de vencimiento: $expirationDateString'),
              if (widget.phoneNumber!.state == 'A') Text('Disponible'),
            ])
          : const Text('Este numero no ha sido registrado'),
    );
  }
}
