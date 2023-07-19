import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oxford_consultor/models/phone_number.dart';
import '../constants.dart';

class ApiService {
  final _phoneNumberController = StreamController<PhoneNumber?>();

  Stream<PhoneNumber?> get phoneNumberStream => _phoneNumberController.stream;

  void dispose() {
    _phoneNumberController.close();
  }

  void getPhoneNumber(String phoneNumber) async {
    var url = Uri.parse('${ApiConstants.baseUrl}/$phoneNumber');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      _phoneNumberController.sink
          .add(PhoneNumber.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 202) {
      _phoneNumberController.sink.add(null);
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      _phoneNumberController.addError(Exception('Failed to load post'));
    }
  }

  Future<String> updateObservation(
      String phoneNumber, String observation) async {
    try {
      // Define the data to be updated
      final Map<String, dynamic> updateData = {
        'phone_number': phoneNumber,
        'observation': observation,
      };

      // Convert the data to JSON
      final jsonData = json.encode(updateData);

      // Make the API call to the update endpoint using PUT method
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/updateObservation'),
        body: jsonData,
        headers: {'Content-Type': 'application/json'},
      );

      // Check the response status code
      if (response.statusCode == 200) {
        return '200';
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exception
    }
    return '200';
  }

  Future<bool> createPhoneNumber(String phoneNumber) async {
    try {
      // Define the data to be updated
      final Map<String, dynamic> newPhoneNumber = {'phone_number': phoneNumber};

      // Convert the data to JSON
      final jsonData = json.encode(newPhoneNumber);

      // Make the API call to the update endpoint using PUT method
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/create'),
        body: jsonData,
        headers: {'Content-Type': 'application/json'},
      );

      // Check the response status code
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle exception
    }
    return false;
  }
}
