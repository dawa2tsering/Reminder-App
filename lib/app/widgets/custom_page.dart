// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/search_reminder/views/search_reminder_view.dart';

class CustomPage extends StatelessWidget {
  String title;
  Widget body;
  VoidCallback? onTap;
  CustomPage({Key? key, required this.title, required this.body, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            elevation: 0,
            pinned: true,
            floating: true,
            expandedHeight: 200,
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.to(() => SearchReminderView()),
                      icon: Icon(Icons.search_rounded)),
                  PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: onTap,
                              child: Text('Delete'),
                            ),
                            PopupMenuItem(
                              child: Text('Sort By'),
                            ),
                          ]),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: body,
          )
        ],
      ),
    );
  }
}
