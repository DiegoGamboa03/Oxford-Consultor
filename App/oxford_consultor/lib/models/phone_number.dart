class PhoneNumber {
  String? phoneNumber;

  PhoneNumber({required this.phoneNumber});

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(phoneNumber: json['picked_phone_number']);
  }
}
