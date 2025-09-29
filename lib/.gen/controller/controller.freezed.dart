// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../controller/controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleControllerState<T extends Identifiable> {

 Map<DateTime, DateState<T>> get data; DateTime get selectedDate;
/// Create a copy of ScheduleControllerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleControllerStateCopyWith<T, ScheduleControllerState<T>> get copyWith => _$ScheduleControllerStateCopyWithImpl<T, ScheduleControllerState<T>>(this as ScheduleControllerState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleControllerState<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),selectedDate);

@override
String toString() {
  return 'ScheduleControllerState<$T>(data: $data, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class $ScheduleControllerStateCopyWith<T extends Identifiable,$Res>  {
  factory $ScheduleControllerStateCopyWith(ScheduleControllerState<T> value, $Res Function(ScheduleControllerState<T>) _then) = _$ScheduleControllerStateCopyWithImpl;
@useResult
$Res call({
 Map<DateTime, DateState<T>> data, DateTime selectedDate
});




}
/// @nodoc
class _$ScheduleControllerStateCopyWithImpl<T extends Identifiable,$Res>
    implements $ScheduleControllerStateCopyWith<T, $Res> {
  _$ScheduleControllerStateCopyWithImpl(this._self, this._then);

  final ScheduleControllerState<T> _self;
  final $Res Function(ScheduleControllerState<T>) _then;

/// Create a copy of ScheduleControllerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? selectedDate = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<DateTime, DateState<T>>,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleControllerState].
extension ScheduleControllerStatePatterns<T extends Identifiable> on ScheduleControllerState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleControllerState<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleControllerState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleControllerState<T> value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleControllerState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleControllerState<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleControllerState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<DateTime, DateState<T>> data,  DateTime selectedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleControllerState() when $default != null:
return $default(_that.data,_that.selectedDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<DateTime, DateState<T>> data,  DateTime selectedDate)  $default,) {final _that = this;
switch (_that) {
case _ScheduleControllerState():
return $default(_that.data,_that.selectedDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<DateTime, DateState<T>> data,  DateTime selectedDate)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleControllerState() when $default != null:
return $default(_that.data,_that.selectedDate);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleControllerState<T extends Identifiable> implements ScheduleControllerState<T> {
   _ScheduleControllerState({final  Map<DateTime, DateState<T>> data = const {}, required this.selectedDate}): _data = data;
  

 final  Map<DateTime, DateState<T>> _data;
@override@JsonKey() Map<DateTime, DateState<T>> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override final  DateTime selectedDate;

/// Create a copy of ScheduleControllerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleControllerStateCopyWith<T, _ScheduleControllerState<T>> get copyWith => __$ScheduleControllerStateCopyWithImpl<T, _ScheduleControllerState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleControllerState<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),selectedDate);

@override
String toString() {
  return 'ScheduleControllerState<$T>(data: $data, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class _$ScheduleControllerStateCopyWith<T extends Identifiable,$Res> implements $ScheduleControllerStateCopyWith<T, $Res> {
  factory _$ScheduleControllerStateCopyWith(_ScheduleControllerState<T> value, $Res Function(_ScheduleControllerState<T>) _then) = __$ScheduleControllerStateCopyWithImpl;
@override @useResult
$Res call({
 Map<DateTime, DateState<T>> data, DateTime selectedDate
});




}
/// @nodoc
class __$ScheduleControllerStateCopyWithImpl<T extends Identifiable,$Res>
    implements _$ScheduleControllerStateCopyWith<T, $Res> {
  __$ScheduleControllerStateCopyWithImpl(this._self, this._then);

  final _ScheduleControllerState<T> _self;
  final $Res Function(_ScheduleControllerState<T>) _then;

/// Create a copy of ScheduleControllerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? selectedDate = null,}) {
  return _then(_ScheduleControllerState<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<DateTime, DateState<T>>,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$DateState<T extends Identifiable> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DateState<$T>()';
}


}

/// @nodoc
class $DateStateCopyWith<T extends Identifiable,$Res>  {
$DateStateCopyWith(DateState<T> _, $Res Function(DateState<T>) __);
}


/// Adds pattern-matching-related methods to [DateState].
extension DateStatePatterns<T extends Identifiable> on DateState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading<T> value)?  loading,TResult Function( _Loaded<T> value)?  loaded,TResult Function( _Error<T> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading<T> value)  loading,required TResult Function( _Loaded<T> value)  loaded,required TResult Function( _Error<T> value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading<T> value)?  loading,TResult? Function( _Loaded<T> value)?  loaded,TResult? Function( _Error<T> value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<T> data)?  loaded,TResult Function( Exception e)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.e);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<T> data)  loaded,required TResult Function( Exception e)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.data);case _Error():
return error(_that.e);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<T> data)?  loaded,TResult? Function( Exception e)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.e);case _:
  return null;

}
}

}

/// @nodoc


class _Loading<T extends Identifiable> extends DateState<T> {
   _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DateState<$T>.loading()';
}


}




/// @nodoc


class _Loaded<T extends Identifiable> extends DateState<T> {
   _Loaded({required final  List<T> data}): _data = data,super._();
  

 final  List<T> _data;
 List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of DateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<T, _Loaded<T>> get copyWith => __$LoadedCopyWithImpl<T, _Loaded<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded<T>&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'DateState<$T>.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<T extends Identifiable,$Res> implements $DateStateCopyWith<T, $Res> {
  factory _$LoadedCopyWith(_Loaded<T> value, $Res Function(_Loaded<T>) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<T> data
});




}
/// @nodoc
class __$LoadedCopyWithImpl<T extends Identifiable,$Res>
    implements _$LoadedCopyWith<T, $Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded<T> _self;
  final $Res Function(_Loaded<T>) _then;

/// Create a copy of DateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}


}

/// @nodoc


class _Error<T extends Identifiable> extends DateState<T> {
   _Error({required this.e}): super._();
  

 final  Exception e;

/// Create a copy of DateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<T, _Error<T>> get copyWith => __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error<T>&&(identical(other.e, e) || other.e == e));
}


@override
int get hashCode => Object.hash(runtimeType,e);

@override
String toString() {
  return 'DateState<$T>.error(e: $e)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<T extends Identifiable,$Res> implements $DateStateCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 Exception e
});




}
/// @nodoc
class __$ErrorCopyWithImpl<T extends Identifiable,$Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error<T> _self;
  final $Res Function(_Error<T>) _then;

/// Create a copy of DateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? e = null,}) {
  return _then(_Error<T>(
e: null == e ? _self.e : e // ignore: cast_nullable_to_non_nullable
as Exception,
  ));
}


}

// dart format on
