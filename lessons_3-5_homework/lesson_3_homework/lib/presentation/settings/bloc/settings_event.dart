import 'package:equatable/equatable.dart';

// События, которые приводят к изменению состояния виджетов экрана настроек
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

// Событие загрузки любимого жанра сериалов пользователя из системного хранилища
// Shared Preferences
class LoadGenreEvent extends SettingsEvent {}

// Событие сохранения жанра в Shared Preferences
class SaveGenreEvent extends SettingsEvent {
  final String genre;

  const SaveGenreEvent({required this.genre});

  @override
  List<Object> get props => [genre];
}

// Событие удаления жанра из Shared Preferences
class ClearGenreEvent extends SettingsEvent {}
