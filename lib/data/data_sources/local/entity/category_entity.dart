
import 'package:objectbox/objectbox.dart';


@Entity()
class CategoryEntity {

  @Id(assignable:true)
  int id = 0;

  String? name;

  String? image;

  int? position;

  String? desc;

  CategoryEntity(this.id, this.name, this.image, this.position, this.desc);

}


