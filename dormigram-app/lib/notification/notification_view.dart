import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          // Refresh button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Handle refresh action here (you can simply call setState if you use StatefulWidget)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refreshed")));
            },
          ),
          // Create Message button
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              // Navigate to the Create Message screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateMessageView()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Example list of 10 messages
        itemBuilder: (context, index) {
          return MessageCard(
            date: "2024-12-05", // Example date
            toWhom: "John Doe", // Example recipient
            subject: "Subject of message ${index + 1}",
            message: "This is a preview of the message content. It may contain important information...",
            onMessageTap: () {
              // Navigate to the message history screen when tapping a message
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MessageHistoryView(messageId: index + 1)),
              );
            },
          );
        },
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String date;
  final String toWhom;
  final String subject;
  final String message;
  final VoidCallback onMessageTap;

  const MessageCard({
    Key? key,
    required this.date,
    required this.toWhom,
    required this.subject,
    required this.message,
    required this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: InkWell(
        onTap: onMessageTap, // Navigate to message history view on tap
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon for the message
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.mail,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 16), // Space between icon and text
              // Message details (date, to whom, subject, preview)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To: $toWhom"),
                    SizedBox(height: 4),
                    Text("Subject: $subject"),
                    SizedBox(height: 4),
                    Text("Date: $date"),
                    SizedBox(height: 8),
                    Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              // Button for more details
              TextButton(
                onPressed: () {
                  // Handle onClick of "More Details" button here
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Message Details"),
                      content: Text("Full message content here."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("More Details"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageHistoryView extends StatelessWidget {
  final int messageId;

  const MessageHistoryView({Key? key, required this.messageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message History - $messageId"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Message History for Message #$messageId", style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text("Date: 2024-12-05"),
            SizedBox(height: 8),
            Text("To: John Doe"),
            SizedBox(height: 8),
            Text("Subject: Subject of message $messageId"),
            SizedBox(height: 8),
            Text(
              "Message Content: Full details about the message $messageId.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateMessageView extends StatefulWidget {
  const CreateMessageView({Key? key}) : super(key: key);

  @override
  _CreateMessageViewState createState() => _CreateMessageViewState();
}

class _CreateMessageViewState extends State<CreateMessageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _toWhomController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Message"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _toWhomController,
                decoration: InputDecoration(labelText: 'To'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipient.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message.';
                  }
                  return null;
                },
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the data (you can show a Snackbar or navigate)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message Sent!')),
                    );
                    // Optionally, clear the form fields after submission
                    _toWhomController.clear();
                    _subjectController.clear();
                    _messageController.clear();
                  }
                },
                child: Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationView(),
  ));
}
