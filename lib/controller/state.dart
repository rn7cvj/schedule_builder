part of "controller.dart";

@freezed
abstract class ScheduleControllerState<T extends Identifiable, E>
    with _$ScheduleControllerState<T, E> {
  const factory ScheduleControllerState({
    @Default({}) Map<DateTime, DateState<T, E>> data,
    required DateTime selectedDate,
  }) = _ScheduleControllerState<T, E>;
}

@freezed
abstract class DateState<T extends Identifiable, E> with _$DateState<T, E> {
  const DateState._();

  bool get isLoading => this is _Loading;

  bool get isLoaded => this is _Loaded;

  factory DateState.loading() = _Loading<T, E>;

  factory DateState.loaded({required List<T> data, E? extra}) = _Loaded<T, E>;

  factory DateState.error({required Exception e}) = _Error<T, E>;
}
