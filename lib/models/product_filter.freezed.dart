// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductFilter {
  String? get name => throw _privateConstructorUsedError;
  bool get bestOfferOnly => throw _privateConstructorUsedError;
  double? get minimumPrice => throw _privateConstructorUsedError;
  double? get maximumPrice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductFilterCopyWith<ProductFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductFilterCopyWith<$Res> {
  factory $ProductFilterCopyWith(
          ProductFilter value, $Res Function(ProductFilter) then) =
      _$ProductFilterCopyWithImpl<$Res, ProductFilter>;
  @useResult
  $Res call(
      {String? name,
      bool bestOfferOnly,
      double? minimumPrice,
      double? maximumPrice});
}

/// @nodoc
class _$ProductFilterCopyWithImpl<$Res, $Val extends ProductFilter>
    implements $ProductFilterCopyWith<$Res> {
  _$ProductFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? bestOfferOnly = null,
    Object? minimumPrice = freezed,
    Object? maximumPrice = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bestOfferOnly: null == bestOfferOnly
          ? _value.bestOfferOnly
          : bestOfferOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      minimumPrice: freezed == minimumPrice
          ? _value.minimumPrice
          : minimumPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maximumPrice: freezed == maximumPrice
          ? _value.maximumPrice
          : maximumPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductFilterImplCopyWith<$Res>
    implements $ProductFilterCopyWith<$Res> {
  factory _$$ProductFilterImplCopyWith(
          _$ProductFilterImpl value, $Res Function(_$ProductFilterImpl) then) =
      __$$ProductFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      bool bestOfferOnly,
      double? minimumPrice,
      double? maximumPrice});
}

/// @nodoc
class __$$ProductFilterImplCopyWithImpl<$Res>
    extends _$ProductFilterCopyWithImpl<$Res, _$ProductFilterImpl>
    implements _$$ProductFilterImplCopyWith<$Res> {
  __$$ProductFilterImplCopyWithImpl(
      _$ProductFilterImpl _value, $Res Function(_$ProductFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? bestOfferOnly = null,
    Object? minimumPrice = freezed,
    Object? maximumPrice = freezed,
  }) {
    return _then(_$ProductFilterImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bestOfferOnly: null == bestOfferOnly
          ? _value.bestOfferOnly
          : bestOfferOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      minimumPrice: freezed == minimumPrice
          ? _value.minimumPrice
          : minimumPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maximumPrice: freezed == maximumPrice
          ? _value.maximumPrice
          : maximumPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ProductFilterImpl implements _ProductFilter {
  const _$ProductFilterImpl(
      {required this.name,
      required this.bestOfferOnly,
      required this.minimumPrice,
      required this.maximumPrice});

  @override
  final String? name;
  @override
  final bool bestOfferOnly;
  @override
  final double? minimumPrice;
  @override
  final double? maximumPrice;

  @override
  String toString() {
    return 'ProductFilter(name: $name, bestOfferOnly: $bestOfferOnly, minimumPrice: $minimumPrice, maximumPrice: $maximumPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFilterImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bestOfferOnly, bestOfferOnly) ||
                other.bestOfferOnly == bestOfferOnly) &&
            (identical(other.minimumPrice, minimumPrice) ||
                other.minimumPrice == minimumPrice) &&
            (identical(other.maximumPrice, maximumPrice) ||
                other.maximumPrice == maximumPrice));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, bestOfferOnly, minimumPrice, maximumPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFilterImplCopyWith<_$ProductFilterImpl> get copyWith =>
      __$$ProductFilterImplCopyWithImpl<_$ProductFilterImpl>(this, _$identity);
}

abstract class _ProductFilter implements ProductFilter {
  const factory _ProductFilter(
      {required final String? name,
      required final bool bestOfferOnly,
      required final double? minimumPrice,
      required final double? maximumPrice}) = _$ProductFilterImpl;

  @override
  String? get name;
  @override
  bool get bestOfferOnly;
  @override
  double? get minimumPrice;
  @override
  double? get maximumPrice;
  @override
  @JsonKey(ignore: true)
  _$$ProductFilterImplCopyWith<_$ProductFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
