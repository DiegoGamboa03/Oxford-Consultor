import 'package:flutter/material.dart';
import 'package:oxford_consultor/widgets/phone_number_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(), //aqui va el logo
        Center(
          child: PhoneNumberField(controller: controller),
        ),
        (controller.text.length < 12)
            ? const Text("True")
            : const Text('Ingrese un numero de telefono'),
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
