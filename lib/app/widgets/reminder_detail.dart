import 'package:flutter/material.dart';

class ReminderDetail extends StatelessWidget {
  int? id;
  String? memo;
  String? time;
  String? place;
  String? status;
  int? category;
  ReminderDetail(
      {Key? key,
      this.id,
      this.memo,
      this.time,
      this.place,
      this.status,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('$id'),
          Text(memo!),
          Text(time!),
          Text(place!),
          Text(status!),
          Text('$category'),
          Text('lskdsjf'),
        ],
      ),
    );
  }
}
