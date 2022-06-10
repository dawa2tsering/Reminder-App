// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/add_reminder/views/add_reminder_view.dart';
import 'package:reminder_app/app/modules/search_reminder/views/search_reminder_view.dart';
import 'package:reminder_app/app/widgets/custom_drawer.dart';

class CustomeHomePage extends StatelessWidget {
  String title;
  Widget body;
  CustomeHomePage({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            floating: false,
            expandedHeight: 200,
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.to(() => AddReminderView()),
                      icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () => Get.to(() => SearchReminderView()),
                      icon: Icon(Icons.search_rounded)),
                  PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Edit'),
                            ),
                            PopupMenuItem(
                              child: Text('Sort By'),
                            ),
                          ]),
                  SizedBox(
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
      drawer: CustomDrawer(),
    );
  }
}
