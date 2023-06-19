import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<User>> getUsers() async {
    try {
      print('Sending request to API...');
      final response = await _dio.get(
        'https://backend.mdma.haveachin.de/accounts/users',
        options: Options(
          headers: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
          },
        ),
      );
      print('API request successful');
      final userList =
          List<User>.from(response.data.map((user) => User.fromJson(user)));
      return userList;
    } catch (e) {
      if (e is DioError && e.response != null) {
        final errorResponse = e.response?.data;
        print('Error: $errorResponse');
      } else {
        print('Error: $e');
      }
      throw e;
    }
  }

  Future<List<User>> fetchUsers() {
    return getUsers();
  }
}

class User {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String username;
  final int roleId;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      username: json['username'],
      roleId: json['roleId'],
    );
  }
}

void fetchUsers() async {
  try {
    print('Fetching users...');
    final List<User> userList = await ApiService().fetchUsers();
    print('Users fetched successfully');
    // Do something with the userList
    print('User List: $userList');
  } catch (e) {
    print('Error occurred while fetching users: $e');
    // Handle error
  }
}

void main() {
  fetchUsers();
}
