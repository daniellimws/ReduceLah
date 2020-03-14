class User {
  int id;
  String name;
  int points;
  int rank;

  User({this.id, this.name, this.points, this.rank});
}

class LeaderboardData {
  List<User> users;
  User me;

  LeaderboardData({this.users, this.me});
}
