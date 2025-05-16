import '../models/user.dart';

class DummyDataService {
  static final List<User> users = [
    User(
      id: '1',
      email: 'john.doe@example.com',
      name: 'John Doe',
      role: 'Student',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    User(
      id: '2',
      email: 'jane.smith@example.com',
      name: 'Jane Smith',
      role: 'Professor',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    User(
      id: '3',
      email: 'mike.wilson@example.com',
      name: 'Mike Wilson',
      role: 'Student',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
  ];

  static final List<Map<String, dynamic>> courses = [
    {
      'id': '1',
      'name': 'Introduction to Computer Science',
      'instructor': 'Jane Smith',
      'students': 45,
      'schedule': 'Mon, Wed 10:00 AM',
    },
    {
      'id': '2',
      'name': 'Data Structures and Algorithms',
      'instructor': 'John Doe',
      'students': 38,
      'schedule': 'Tue, Thu 2:00 PM',
    },
    {
      'id': '3',
      'name': 'Web Development',
      'instructor': 'Mike Wilson',
      'students': 52,
      'schedule': 'Fri 1:00 PM',
    },
  ];

  static final List<Map<String, dynamic>> announcements = [
    {
      'id': '1',
      'title': 'Welcome to Fall Semester',
      'content': 'Welcome back everyone! We hope you had a great summer break.',
      'date': '2024-09-01',
      'author': 'Jane Smith',
    },
    {
      'id': '2',
      'title': 'Midterm Schedule Released',
      'content': 'The midterm schedule has been posted. Please check your course pages.',
      'date': '2024-09-15',
      'author': 'John Doe',
    },
    {
      'id': '3',
      'title': 'Career Fair Next Week',
      'content': 'Don\'t forget to register for the annual career fair next week.',
      'date': '2024-09-20',
      'author': 'Mike Wilson',
    },
  ];
} 