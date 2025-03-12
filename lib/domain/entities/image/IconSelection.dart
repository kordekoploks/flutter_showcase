import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IconSelection extends Equatable {
  final String id;
  final String name;
  final IconData icon;

  const IconSelection(
      {required this.id, required this.name, required this.icon});

  IconSelection copyWith({bool? isUpdated}) {
    return IconSelection(
      id: id,
      name: name,
      icon: icon,);
  }
  @override
  List<Object?> get props => [id];
}
