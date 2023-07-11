import 'package:flutter/material.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  List<String> list = <String>['0416', '0414', '0412'];
  late String dropdownValue;
  TextEditingController phoneNumbercontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.95,
      height: height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.04),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                value: dropdownValue,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _updateControllerText();
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (value) {
                _updateControllerText();
              },
              controller: phoneNumbercontroller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Insert numbers here',
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateControllerText() {
    String combinedText = '$dropdownValue-${phoneNumbercontroller.text}';
    widget.controller.text = combinedText;
  }
}
