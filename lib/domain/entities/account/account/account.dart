import 'package:equatable/equatable.dart';


class OutcomeAccount extends Equatable {
  final String id;
  final int position;
  final String name;
  final String desc;
  final String image;
  final bool isUpdated;

  const OutcomeAccount({
    required this.id,
    required this.position,
    required this.name,
    required this.desc,
    required this.image,
    this.isUpdated = false,
  });

  OutcomeAccount copyWith({bool? isUpdated}) {
    return OutcomeAccount(
      id: id,
      position: position,
      name: name,
      desc: desc,
      image: image,
      isUpdated: isUpdated ?? this.isUpdated,
      //   otomatis terudate saat memasukan yang dibutuhkan
    );
  }

  @override
  List<Object?> get props => [id];
}
