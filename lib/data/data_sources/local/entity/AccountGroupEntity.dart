import '../../../../objectbox.g.dart';

@Entity()
class AccountGroupEntity {
  @Id(assignable: true)
  int id = 0;

  String name = "";
}
