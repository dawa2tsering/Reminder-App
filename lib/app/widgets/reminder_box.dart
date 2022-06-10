// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReminderBox extends StatelessWidget {
  String? memo;
  String? date;
  VoidCallback? onChecked;
  VoidCallback? onTap;
  ReminderBox(
      {Key? key, required this.memo, this.date, this.onChecked, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: 200,
                  child: Text(
                    memo!,
                    overflow: TextOverflow.ellipsis,
                  )),
              if (date != "")
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(DateFormat('EEE, d MMM  hh:mm a')
                        .format(DateTime.parse(date!))),
                  ],
                ),
            ]),
            IconButton(
                onPressed: onChecked,
                icon: const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }
}
