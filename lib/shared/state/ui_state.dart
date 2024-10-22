import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../exception.dart';

part 'ui_state_model_mutex.dart';

typedef BushaUiStateRef<T extends BushaUiStateModel<T>> = List<T>;
typedef VoidWidgetCallback = Widget Function();

Widget _kIdleClosure() => const SizedBox.shrink();

final _$vmWriteMutex = UiStateMutex();

enum UiState {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == UiState.loading;

  bool get isError => this == UiState.error;

  bool get isSuccess => this == UiState.success;

  bool get isIdle => this == UiState.idle;
}

@immutable
abstract base class BushaUiStateModel<T extends BushaUiStateModel<T>>
    extends Equatable {
  const BushaUiStateModel({
    this.uiState = UiState.idle,
    this.exception = const EmptyException(),
  });

  final UiState uiState;
  final BushaException exception;

  T copyWith({
    UiState? uiState,
    BushaException? exception,
  });

  @visibleForTesting
  @protected
  @override
  List<Object?> get props => [uiState, exception, ...otherProps];

  List<Object?> get otherProps => [];
}

@immutable
abstract base class BushaFormUiStateModel<T extends BushaFormUiStateModel<T>>
    extends BushaUiStateModel<T> {
  const BushaFormUiStateModel({
    super.uiState,
    super.exception,
    this.showFormErrors = false,
  });

  final bool showFormErrors;

  @override
  T copyWith({
    UiState? uiState,
    BushaException? exception,
    bool? showFormErrors,
  });

  @override
  List<Object?> get props => [...super.props, showFormErrors];
}

Future<void> launch<E extends BushaUiStateModel<E>>(
  BushaUiStateRef<E> model,
  FutureOr<void> Function(BushaUiStateRef<E> model) function, {
  bool displayError = true,
  bool Function(E state) canDisplayError = _kDisplayError,
}) async {
  final result = await _$vmWriteMutex.protect<E>(() async {
    await function(model);
    return model._state;
  });

  if (result.reference.isEmpty || !displayError || !(canDisplayError(result))) {
    return;
  }
  result.displayError();
}

bool _kDisplayError([_]) => true;

extension DealershipFormUiStatelX<T extends BushaFormUiStateModel<T>> on T {
  T toggleFormErrors([bool? showFormError]) {
    return copyWith(showFormErrors: showFormError ?? !showFormErrors);
  }

  T reset() {
    return copyWith(
      showFormErrors: false,
      uiState: UiState.idle,
      exception: const EmptyException(),
    );
  }
}

extension UiStateX<T extends BushaUiStateModel<T>> on T {
  BushaUiStateRef<T> get reference => [this];

  Widget when({
    required VoidWidgetCallback onLoading,
    required Widget Function(BushaException error) onError,
    required Widget Function(T state) onSuccess,
    VoidWidgetCallback onIdle = _kIdleClosure,
  }) {
    return switch (uiState) {
      UiState.idle => onIdle(),
      UiState.loading => onLoading(),
      UiState.success => onSuccess(this),
      UiState.error => onError(exception),
    };
  }

  T emitTo(BushaUiStateRef<T> model) {
    return model.emit(this);
  }

  T reset() {
    return copyWith(
      uiState: UiState.idle,
      exception: const EmptyException(),
    );
  }

  T sError(BushaException error) {
    return copyWith(
      uiState: UiState.error,
      exception: error,
    );
  }

  T sSuccess() {
    return copyWith(uiState: UiState.success);
  }

  T sLoading() {
    return copyWith(uiState: UiState.loading);
  }

  void displayError() async {
    if (uiState != UiState.error) return;
    // assert(error is! EmptyException, 'Please pass appropriate exception');
    //
    // final context = AppRouter.navKey.currentContext!;
    // final snackbar = SnackBar(
    //   backgroundColor: Theme.of(context).colorScheme.error,
    //   duration: Constants.snackBarDur,
    //   content: Text(
    //     error.toString(),
    //     style: Theme.of(context)
    //         .textTheme
    //         .bodyMedium
    //         ?.copyWith(color: Theme.of(context).colorScheme.surface),
    //   ),
    // );
    //
    // ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackbar);
  }
}

extension ViewModelRefX<T extends BushaUiStateModel<T>> on BushaUiStateRef<T> {
  BushaUiStateRef<T> _assign(T value) => this..insert(0, value);

  T get _state => elementAt(0);

  T emit(T value) => _assign(value)._state;
}
