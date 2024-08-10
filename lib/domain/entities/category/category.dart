import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final int position;
  final String name;
  final String desc;
  final String image;

  const Category({
    required this.id,
    required this.position,
    required this.name,
    required this.desc,
    required this.image,
  });



  @override
  List<Object?> get props => [id];
}
