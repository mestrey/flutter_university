import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskCard(
            title: "Task ${index + 1}",
            description: "Description of task ${index + 1}",
            status: index % 2 == 0 ? "In Progress" : "Completed",
            onMoreDetails: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Task Details"),
                  content: Text("Details for Task ${index + 1}"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final VoidCallback onMoreDetails;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.onMoreDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon on the left
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.task_alt,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 16), // Space between icon and text
            // Task details (title, description, status)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    // style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    // style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: status == "Completed" ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            // Button for more details
            TextButton(
              onPressed: onMoreDetails,
              child: const Text("Подробнее"),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
