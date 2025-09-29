part of "controller.dart";

@freezed
abstract class ScheduleControllerState<T extends Identifiable>
    with _$ScheduleControllerState<T> {
  factory ScheduleControllerState({
    @Default({}) Map<DateTime, DateState<T>> data,
    required DateTime selectedDate,
  }) = _ScheduleControllerState<T>;
}

@freezed
abstract class DateState<T extends Identifiable> with _$DateState<T> {
  DateState._();

  bool get isLoading => this is _Loading;

  bool get isLoaded => this is _Loaded;

  factory DateState.loading() = _Loading;

  factory DateState.loaded({required List<T> data}) = _Loaded;

  factory DateState.error({required Exception e}) = _Error;
}
