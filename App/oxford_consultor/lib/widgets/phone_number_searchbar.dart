import 'package:flutter/material.dart';

class PhoneNumberSearchBar extends StatefulWidget {
  const PhoneNumberSearchBar({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<PhoneNumberSearchBar> createState() => _PhoneNumberSearchBarState();
}

class _PhoneNumberSearchBarState extends State<PhoneNumberSearchBar> {
  List<String> list = <String>['0416', '0414', '0412'];

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = widget.controller;
    String dropdownValue = list.first;
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
              controller: controller,
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
}
