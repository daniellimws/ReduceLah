class User {
  String name;
  int points;
  int rank;

  User({this.name, this.points, this.rank});
}

class LeaderboardData {
  List<User> users;
  User me;

  LeaderboardData({this.users, this.me});
}
