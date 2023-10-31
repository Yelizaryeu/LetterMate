// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatModel {
  String get chatId => throw _privateConstructorUsedError;
  List<dynamic> get members => throw _privateConstructorUsedError;
  String get recentMessage => throw _privateConstructorUsedError;
  int? get recentMessageTime => throw _privateConstructorUsedError;
  String? get recentMessageSender => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {String chatId,
      List<dynamic> members,
      String recentMessage,
      int? recentMessageTime,
      String? recentMessageSender});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

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
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
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
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
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
    return _then(_$ChatModelImpl(
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

class _$ChatModelImpl implements _ChatModel {
  _$ChatModelImpl(
      {required this.chatId,
      required final List<dynamic> members,
      required this.recentMessage,
      required this.recentMessageTime,
      required this.recentMessageSender})
      : _members = members;

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
    return 'ChatModel(chatId: $chatId, members: $members, recentMessage: $recentMessage, recentMessageTime: $recentMessageTime, recentMessageSender: $recentMessageSender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.recentMessage, recentMessage) ||
                other.recentMessage == recentMessage) &&
            (identical(other.recentMessageTime, recentMessageTime) ||
                other.recentMessageTime == recentMessageTime) &&
            (identical(other.recentMessageSender, recentMessageSender) ||
                other.recentMessageSender == recentMessageSender));
  }

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
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);
}

abstract class _ChatModel implements ChatModel {
  factory _ChatModel(
      {required final String chatId,
      required final List<dynamic> members,
      required final String recentMessage,
      required final int? recentMessageTime,
      required final String? recentMessageSender}) = _$ChatModelImpl;

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
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
