import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// События, которые приводят к изменению локализации приложения
abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

// Событие загрузки выбранной пользователем ранее локализации из системного
// хранилища Shared Preferences
class LoadLocaleEvent extends LocaleEvent {}

// Событие изменения локализации
class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale; // Новая локализация

  const ChangeLocaleEvent(this.locale);

  @override
  List<Object> get props => [locale];
}
