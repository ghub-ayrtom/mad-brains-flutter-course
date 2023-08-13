// Библиотека Equatable позволяет сравнить два отдельных состояния по их полям
// без жёсткой привязки к указателям в памяти
import 'package:equatable/equatable.dart';

// Состояние BLoC-компонента экрана настроек
class SettingsState extends Equatable {
  final String? genre; // Строка с любимым жанром сериалов пользователя

  const SettingsState({this.genre});

  // Данный метод подменяет (копирует) состояние виджета с новыми
  // (необязательными) значениями полей
  SettingsState copyWith({String? genre}) =>
      SettingsState(genre: genre ?? this.genre); // ?? - if null

  // Поле, по которому будет происходить сравнение двух отдельных состояний
  // (старого и нового)
  @override
  List<Object> get props => [genre ?? ""];
}
