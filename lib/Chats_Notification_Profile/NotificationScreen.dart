import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static const String id = 'Notification_Page';
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Message',
      'message': 'You have received a new message from John.',
      'time': '2 min ago'
    },
    {
      'title': 'Update Available',
      'message': 'A new update is available for your app.',
      'time': '10 min ago'
    },
    {
      'title': 'Reminder',
      'message': 'Don\'t forget your meeting at 3 PM.',
      'time': '1 hour ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notifications[index]['title']!),
            subtitle: Text(notifications[index]['message']!),
            trailing: Text(notifications[index]['time']!),
            onTap: () {
              // Perform action on notification click
            },
          );
        },
      ),
    );
  }
}
