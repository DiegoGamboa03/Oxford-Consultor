import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
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
      width: width * 0.90,
      height: height * 0.07,
      decoration: BoxDecoration(
        color: const Color(0xffDEDEDF),
        border: Border.all(color: const Color(0xffDEDEDF)),
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
                iconEnabledColor: const Color(0xff4043CF),
                style: GoogleFonts.roboto(color: const Color(0xff4043CF)),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _updateControllerText();
                    dropdownValue = value!;
                    if (widget.onChanged != null) {
                      widget.onChanged!(_updateControllerText());
                    }
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.roboto(color: const Color(0xff4043CF)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: VerticalDivider(
              color: Color(0xff4043CF),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
                onChanged: (value) {
                  setState(() {
                    _updateControllerText();
                    if (widget.onChanged != null) {
                      widget.onChanged!(_updateControllerText());
                    }
                  });
                },
                style: GoogleFonts.roboto(color: const Color(0xff4043CF)),
                controller: phoneNumbercontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ingrese el numero de telefono',
                    hintStyle:
                        GoogleFonts.roboto(color: const Color(0xff797585))),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                ]),
          )
        ],
      ),
    );
  }

  String _updateControllerText() {
    String combinedText = '$dropdownValue-${phoneNumbercontroller.text}';
    widget.controller.text = combinedText;
    return combinedText;
  }
}
