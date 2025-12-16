  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  class User {
    final int id;
    final String name;
    final String email;

    User({required this.id, required this.name, required this.email});

    factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  class DashboardPage extends StatefulWidget {
    const DashboardPage({super.key});

    @override
    State<DashboardPage> createState() => _DashboardPageState();
  }

  class _DashboardPageState extends State<DashboardPage> {
    List<User> users = [];
    final String baseUrl = 'http://192.168.120.143:8000';
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    Future<void> addUser() async {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/users/?name=${nameController.text}&email=${emailController
                .text}'),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully')),
        );
        fetchUsers(); // إعادة تحميل القائمة
        nameController.clear();
        emailController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add user')),
        );
      }
    }

    @override
    void initState() {
      super.initState();
      fetchUsers();
    }

    Future<void> fetchUsers() async {
      final response = await http.get(Uri.parse('$baseUrl/users/'));
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        print(decoded);

        if (decoded is List) {
          setState(() {
            users = decoded.map((json) => User.fromJson(json)).toList();
          });
        } else {
          debugPrint('Unexpected JSON format: not a List');
        }
      } else {
        debugPrint('Failed to load users. Status code: ${response.statusCode}');
      }
    }

    Future<void> deleteUser(int userId) async {
      final response = await http.delete(Uri.parse('$baseUrl/users/$userId'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted')),
        );
        fetchUsers(); // إعادة تحميل القائمة
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete user')),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard - Users')),
        body: Column(
          children: [
            // نموذج إضافة مستخدم
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            ElevatedButton(
              onPressed: addUser,
              child: const Text('Add User'),
            ),

            // 🔄 عرض قائمة المستخدمين
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteUser(user.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

  }
