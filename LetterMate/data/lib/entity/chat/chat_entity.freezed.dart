// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) {
  return _ChatEntity.fromJson(json);
}

/// @nodoc
mixin _$ChatEntity {
  String get chatId => throw _privateConstructorUsedError;
  List<dynamic> get members => throw _privateConstructorUsedError;
  String get recentMessage => throw _privateConstructorUsedError;
  int? get recentMessageTime => throw _privateConstructorUsedError;
  String? get recentMessageSender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatEntityCopyWith<ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEntityCopyWith<$Res> {
  factory $ChatEntityCopyWith(
          ChatEntity value, $Res Function(ChatEntity) then) =
      _$ChatEntityCopyWithImpl<$Res, ChatEntity>;
  @useResult
  $Res call(
      {String chatId,
      List<dynamic> members,
      String recentMessage,
      int? recentMessageTime,
      String? recentMessageSender});
}

/// @nodoc
class _$ChatEntityCopyWithImpl<$Res, $Val extends ChatEntity>
    implements $ChatEntityCopyWith<$Res> {
  _$ChatEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? members = null,
    Object? recentMessage = null,
    Object? recentMessageTime = freezed,
    Object? recentMessageSender = freezed,
  }) {
    return _then(_value.copyWith(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      recentMessage: null == recentMessage
          ? _value.recentMessage
          : recentMessage // ignore: cast_nullable_to_non_nullable
              as String,
      recentMessageTime: freezed == recentMessageTime
          ? _value.recentMessageTime
          : recentMessageTime // ignore: cast_nullable_to_non_nullable
              as int?,
      recentMessageSender: freezed == recentMessageSender
          ? _value.recentMessageSender
          : recentMessageSender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatEntityImplCopyWith<$Res>
    implements $ChatEntityCopyWith<$Res> {
  factory _$$ChatEntityImplCopyWith(
          _$ChatEntityImpl value, $Res Function(_$ChatEntityImpl) then) =
      __$$ChatEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chatId,
      List<dynamic> members,
      String recentMessage,
      int? recentMessageTime,
      String? recentMessageSender});
}

/// @nodoc
class __$$ChatEntityImplCopyWithImpl<$Res>
    extends _$ChatEntityCopyWithImpl<$Res, _$ChatEntityImpl>
    implements _$$ChatEntityImplCopyWith<$Res> {
  __$$ChatEntityImplCopyWithImpl(
      _$ChatEntityImpl _value, $Res Function(_$ChatEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? members = null,
    Object? recentMessage = null,
    Object? recentMessageTime = freezed,
    Object? recentMessageSender = freezed,
  }) {
    return _then(_$ChatEntityImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      recentMessage: null == recentMessage
          ? _value.recentMessage
          : recentMessage // ignore: cast_nullable_to_non_nullable
              as String,
      recentMessageTime: freezed == recentMessageTime
          ? _value.recentMessageTime
          : recentMessageTime // ignore: cast_nullable_to_non_nullable
              as int?,
      recentMessageSender: freezed == recentMessageSender
          ? _value.recentMessageSender
          : recentMessageSender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatEntityImpl implements _ChatEntity {
  _$ChatEntityImpl(
      {required this.chatId,
      required final List<dynamic> members,
      required this.recentMessage,
      required this.recentMessageTime,
      required this.recentMessageSender})
      : _members = members;

  factory _$ChatEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatEntityImplFromJson(json);

  @override
  final String chatId;
  final List<dynamic> _members;
  @override
  List<dynamic> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String recentMessage;
  @override
  final int? recentMessageTime;
  @override
  final String? recentMessageSender;

  @override
  String toString() {
    return 'ChatEntity(chatId: $chatId, members: $members, recentMessage: $recentMessage, recentMessageTime: $recentMessageTime, recentMessageSender: $recentMessageSender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatEntityImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.recentMessage, recentMessage) ||
                other.recentMessage == recentMessage) &&
            (identical(other.recentMessageTime, recentMessageTime) ||
                other.recentMessageTime == recentMessageTime) &&
            (identical(other.recentMessageSender, recentMessageSender) ||
                other.recentMessageSender == recentMessageSender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chatId,
      const DeepCollectionEquality().hash(_members),
      recentMessage,
      recentMessageTime,
      recentMessageSender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatEntityImplCopyWith<_$ChatEntityImpl> get copyWith =>
      __$$ChatEntityImplCopyWithImpl<_$ChatEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatEntityImplToJson(
      this,
    );
  }
}

abstract class _ChatEntity implements ChatEntity {
  factory _ChatEntity(
      {required final String chatId,
      required final List<dynamic> members,
      required final String recentMessage,
      required final int? recentMessageTime,
      required final String? recentMessageSender}) = _$ChatEntityImpl;

  factory _ChatEntity.fromJson(Map<String, dynamic> json) =
      _$ChatEntityImpl.fromJson;

  @override
  String get chatId;
  @override
  List<dynamic> get members;
  @override
  String get recentMessage;
  @override
  int? get recentMessageTime;
  @override
  String? get recentMessageSender;
  @override
  @JsonKey(ignore: true)
  _$$ChatEntityImplCopyWith<_$ChatEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
