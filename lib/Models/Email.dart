class Email {
  String sentFromAddress;
  String textBody;
  String date;

  Email(this.sentFromAddress, this.textBody, this.date);

  Email.fromJson(Map<String, dynamic> json)
      : sentFromAddress = json['sentFromAddress'],
        textBody = json['textBody'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'sentFromAddress': sentFromAddress,
        'textBody': textBody,
        'date': date,
      };
}
