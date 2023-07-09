import 'package:flutter/material.dart';
import 'package:oxford_consultor/widgets/phone_number_searchbar.dart';

class CreatePhoneNumberPage extends StatefulWidget {
  const CreatePhoneNumberPage({super.key});

  @override
  State<CreatePhoneNumberPage> createState() => _CreatePhoneNumberPageState();
}

class _CreatePhoneNumberPageState extends State<CreatePhoneNumberPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [PhoneNumberField(controller: controller)],
      ),
    );
  }
}
