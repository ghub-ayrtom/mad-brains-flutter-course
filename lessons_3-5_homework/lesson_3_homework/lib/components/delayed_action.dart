import 'dart:async';
import 'dart:ui';

// Выполнить действие по истечению таймера. Удобно, если необходимо обработать
// нажатие на кнопку (или на ввод), но исключить при этом множественное выполнение операции.
// В данном случае, будет выполняться только последняя операция, которая попадает на вход
class DelayedAction {
  factory DelayedAction() => _instance;

  DelayedAction._();
  static final DelayedAction _instance = DelayedAction._();

  static Timer? _timer;

  static void run(
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 250),
  }) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
