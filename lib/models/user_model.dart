import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;

  User(this.email, this.password);
}
