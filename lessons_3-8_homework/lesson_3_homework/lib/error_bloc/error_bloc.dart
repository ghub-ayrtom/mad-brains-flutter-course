import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/dialogs/error_dialog.dart';
import 'package:lesson_3_homework/error_bloc/error_event.dart';
import 'package:lesson_3_homework/error_bloc/error_state.dart';

// Основной класс BLoC-компонента ошибок приложения, в котором собраны
// все события (файл  error_event.dart) и состояния (файл error_state.dart)
class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    // Ниже привязка событий из класса ErrorEvent к бизнес-логике самого
    // BLoC-компонента
    on<ShowDialogEvent>(_onShowDialog);
  }

  // Данный метод вызывается при событии показа диалога с ошибкой
  void _onShowDialog(ShowDialogEvent event, Emitter<ErrorState> emit) {
    // showExceptionDialog - метод вызова диалога с ошибкой (файл error_dialog.dart)
    showExceptionDialog(exception: '${event.title} ${event.message}');
  }
}
