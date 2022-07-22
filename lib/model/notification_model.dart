import 'dart:convert';

class NotificationModel {
  final String? title;
  final String? body;
  final String? date;

  NotificationModel({
    this.title,
    this.body,
    this.date
  });

  factory NotificationModel.fromJson(Map<String, dynamic> jsonData) {
    return NotificationModel(
      title: jsonData['title'],
      body: jsonData['body'],
      date: jsonData['date'],
    );
  }

  static Map<String, dynamic> toMap(NotificationModel music) => {
    'title': music.title,
    'body': music.body,
    'date': music.date,
  };

  static String encode(List<NotificationModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => NotificationModel.toMap(music))
        .toList(),
  );

  static List<NotificationModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<NotificationModel>((item) => NotificationModel.fromJson(item))
          .toList();
}