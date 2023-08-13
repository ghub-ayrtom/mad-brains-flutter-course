import 'package:equatable/equatable.dart';

// Стандартное состояние ошибки (конкретной реализации состояния ошибки нет)
class ErrorState extends Equatable {
  const ErrorState();

  @override
  List<Object> get props => [];
}
