// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompleteReminderBox extends StatelessWidget {
  String? memo;
  String? date;
  VoidCallback? onPressed;
  VoidCallback? onTap;
  CompleteReminderBox(
      {Key? key, this.memo, this.date, this.onPressed, this.onTap})
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
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
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
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  )),
              if (date != "")
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('EEE, d MMM  hh:mm a')
                          .format(DateTime.parse(date!)),
                    ),
                  ],
                ),
            ]),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.check_box_outlined,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }
}
