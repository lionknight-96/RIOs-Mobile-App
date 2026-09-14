import '../models/user_model.dart';

class AuthService {
  static User? currentUser;

  final List<Map<String, dynamic>> users = [
    {
      "username": "staff1",
      "password": "123456",
      "name": "Kiraslava Poezzhaeva",
      "id": "6603523",
      "image": "assets/images/female1.png"
    },
    {
      "username": "staff2",
      "password": "123456",
      "name": "Daniel Romanov",
      "id": "6603524",
      "image": "assets/images/male1.png"
    },
    {
      "username": "staff3",
      "password": "123456",
      "name": "Sophia Ivanova",
      "id": "6603525",
      "image": "assets/images/female2.png"
    },
    {
      "username": "staff4",
      "password": "123456",
      "name": "Alex Petrov",
      "id": "6603526",
      "image": "assets/images/male2.png"
    },
  ];

  User? login(String username, String password) {
    for (var u in users) {
      if (u["username"] == username && u["password"] == password) {
        currentUser = User(
          id: u["id"],
          name: u["name"],
          username: username,
          image: u["image"],
        );
        return currentUser;
      }
    }
    return null;
  }

  void logout() {
    currentUser = null;
  }
}