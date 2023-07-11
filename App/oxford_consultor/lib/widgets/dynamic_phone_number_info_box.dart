import 'package:flutter/material.dart';
import 'package:oxford_consultor/models/phone_number.dart';

class DynamicPhoneNumberInfoBox extends StatefulWidget {
  const DynamicPhoneNumberInfoBox({super.key, required this.phoneNumber});

  final PhoneNumber phoneNumber;

  @override
  State<DynamicPhoneNumberInfoBox> createState() =>
      _DynamicPhoneNumberInfoBoxState();
}

class _DynamicPhoneNumberInfoBoxState extends State<DynamicPhoneNumberInfoBox> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
