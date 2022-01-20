// ignore_for_file: file_names
class Commit {
  String name;
  String date;
  String message;

  Commit(this.name, this.date, this.message);

  Commit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date,
        'message': message,
      };
}
