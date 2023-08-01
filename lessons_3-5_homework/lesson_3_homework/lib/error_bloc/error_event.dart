import 'package:equatable/equatable.dart';

// Стандартное событие ошибки
abstract class ErrorEvent extends Equatable {
  const ErrorEvent();

  @override
  List<Object> get props => [];
}

// Событие показа диалога с ошибкой (конкретная имплементация стандартного события ошибки)
class ShowDialogEvent extends ErrorEvent {
  final String? title;
  final String? message;

  const ShowDialogEvent({this.title, this.message});

  @override
  List<Object> get props => [title ?? "", message ?? ""];
}
