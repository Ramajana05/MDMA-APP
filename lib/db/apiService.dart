import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String _token = '';

  Future<String> login() async {
    try {
      print('Sending login request...');
      final response = await _dio.post(
        'https://backend.mdma.haveachin.de/login',
        data: {
          "username": "H4r4ldD3rH4ck3r",
          "password": "password123",
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      print('Login successful');
      _token = token; // Store the token
      return token;
    } catch (e) {
      if (e is DioError && e.response != null) {
        final errorResponse = e.response?.data;
        print('Login error: $errorResponse');
      } else {
        print('Login error: $e');
      }
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      await _dio.delete(
        'https://backend.mdma.haveachin.de/logout',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization':
                'Bearer $_token', // Include the token in the headers
          },
        ),
      );
      print('Logout successful');
    } catch (e) {
      print('Error occurred during logout: $e');
      throw e;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      print('Sending request to API...');
      final response = await _dio.get(
        'https://backend.mdma.haveachin.de/accounts/users',
        options: Options(
          headers: {
            'Authorization':
                'Bearer $_token', // Include the token in the headers
          },
        ),
      );
      print('API request successful');
      final responseData = response.data;
      print(responseData);
      if (responseData != null) {
        final userList =
            List<User>.from(responseData.map((user) => User.fromJson(user)));
        return userList;
      } else {
        return []; // or throw an exception or handle the null response case accordingly
      }
    } catch (e) {
      if (e is DioError && e.response != null) {
        final errorResponse = e.response?.data;
        print('API request error: $errorResponse');
      } else {
        print('API request error: $e');
      }
      throw e;
    }
  }

  Future<List<User>> fetchUsers() async {
    await login(); // Perform login to get the token
    return getUsers();
  }

  Future<User> getUserById(int userId) async {
    try {
      print('Sending request to API...');
      final response = await _dio.get(
        'https://backend.mdma.haveachin.de/accounts/users/$userId',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization':
                'Bearer $_token', // Include the token in the headers
          },
        ),
      );
      print('API request successful');
      final userData = response.data;
      return User.fromJson(userData);
    } catch (e) {
      if (e is DioError && e.response != null) {
        final errorResponse = e.response?.data;
        print('API request error: $errorResponse');
      } else {
        print('API request error: $e');
      }
      throw e;
    }
  }
}

class User {
  final int id;
  final String username;
  final int roleId;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.roleId,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],

      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      username: json['username'] ?? '',
      roleId: json['roleId'] ?? 0,

    );
  }
}

void fetchUsers() async {
  try {
    print('Fetching users...');
    final List<User> userList = await ApiService().fetchUsers();
    if (userList != null) {
      print('Users fetched successfully');

      // Print the details of each user
      for (User user in userList) {
        print('User ID: ${user.id}');
        print('Username: ${user.username}');
        print('updatedAt: ${user.updatedAt}');
        print('createdAt: ${user.createdAt}');
        print('--------------------');
      }
    } else {
      print('Empty user list');
    }

    // Logout
    final apiService = ApiService();
    await apiService.logout();
    print('Logout completed');
  } catch (e) {
    print('Error occurred while fetching users: $e');
    // Handle error
  }
}

void main() {
  fetchUsers();
}
