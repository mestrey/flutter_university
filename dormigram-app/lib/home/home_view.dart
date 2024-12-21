import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.goToProfile});

  final void Function() goToProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://www.w3schools.com/w3images/avatar2.png', // Placeholder image
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Software Developer at XYZ Company",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: goToProfile,
                          child: Text("View Profile"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              SectionTitle(title: "Quick Actions"),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _QuickActionButton(
                    icon: Icons.message,
                    label: "Send Message",
                    color: Colors.purple,
                    onPressed: () {
                      // Handle send message action
                    },
                  ),
                  _QuickActionButton(
                    icon: Icons.task,
                    label: "Create Task",
                    color: Colors.green,
                    onPressed: () {
                      // Handle create task action
                    },
                  ),
                  _QuickActionButton(
                    icon: Icons.event,
                    label: "Create Event",
                    color: Colors.orange,
                    onPressed: () {
                      // Handle create event action
                    },
                  ),
                  _QuickActionButton(
                    icon: Icons.calendar_today,
                    label: "View Calendar",
                    color: Colors.blue,
                    onPressed: () {
                      // Handle view calendar action
                    },
                  ),
                  _QuickActionButton(
                    icon: Icons.notifications,
                    label: "Notifications",
                    color: Colors.red,
                    onPressed: () {
                      // Handle notifications action
                    },
                  ),
                  _QuickActionButton(
                    icon: Icons.settings,
                    label: "Settings",
                    color: Colors.teal,
                    onPressed: () {
                      // Handle settings action
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Last Tasks Section
              SectionTitle(title: "Last Tasks"),
              TaskCard(
                title: "Complete Flutter Project",
                description: "Finish the task and submit the project by end of the week.",
                dueDate: "2024-12-10",
                status: "In Progress",
              ),
              TaskCard(
                title: "Code Review Meeting",
                description: "Attend the code review meeting at 3 PM tomorrow.",
                dueDate: "2024-12-06",
                status: "Scheduled",
              ),
              SizedBox(height: 24),

              // Last Messages Section
              SectionTitle(title: "Last Messages"),
              MessageCard(
                from: "Alice",
                subject: "Meeting Notes",
                date: "2024-12-05",
                preview: "Here are the notes from our last meeting...",
              ),
              MessageCard(
                from: "Bob",
                subject: "Project Update",
                date: "2024-12-04",
                preview: "The project is moving forward, everything is on track.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: color, // Button color
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Widget for Section Title
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// Widget for Task Cards
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;
  final String status;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Due: $dueDate",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  "Status: $status",
                  style: TextStyle(
                    color: status == "In Progress" ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Message Cards
class MessageCard extends StatelessWidget {
  final String from;
  final String subject;
  final String date;
  final String preview;

  const MessageCard({
    super.key,
    required this.from,
    required this.subject,
    required this.date,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "From: $from",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Subject: $subject",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Date: $date",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              preview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
