import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Состояние основного BLoC-компонента локализации приложения
class LocaleState extends Equatable {
  final Locale? locale; // Текущая локализация

  const LocaleState({this.locale});

  LocaleState copyWith({Locale? locale}) => LocaleState(
        locale: locale ?? this.locale,
      );

  @override
  List<Object> get props => [
        locale ?? const Locale("ru", "RU"),
      ];
}
