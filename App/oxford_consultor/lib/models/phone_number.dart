class PhoneNumber {
  String phoneNumber;
  String? observation;
  String lastUpdateDate;
  String state;
  String? expirationDate;

  PhoneNumber(
      {required this.phoneNumber,
      this.observation,
      required this.lastUpdateDate,
      required this.state,
      this.expirationDate});

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
        phoneNumber: json['phone_number'],
        observation: json['observation'],
        lastUpdateDate: json['last_update_date'],
        state: json['state'],
        expirationDate: json['expiration_date']);
  }
}
