// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_member_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMemberEntity _$ChatMemberEntityFromJson(Map<String, dynamic> json) {
  return _ChatMemberEntity.fromJson(json);
}

/// @nodoc
mixin _$ChatMemberEntity {
  String get uuid => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get photoURL => throw _privateConstructorUsedError;
  String get fCMToken => throw _privateConstructorUsedError;
  String get isTyping => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMemberEntityCopyWith<ChatMemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMemberEntityCopyWith<$Res> {
  factory $ChatMemberEntityCopyWith(
          ChatMemberEntity value, $Res Function(ChatMemberEntity) then) =
      _$ChatMemberEntityCopyWithImpl<$Res, ChatMemberEntity>;
  @useResult
  $Res call(
      {String uuid,
      String uid,
      String name,
      String chatId,
      String photoURL,
      String fCMToken,
      String isTyping});
}

/// @nodoc
class _$ChatMemberEntityCopyWithImpl<$Res, $Val extends ChatMemberEntity>
    implements $ChatMemberEntityCopyWith<$Res> {
  _$ChatMemberEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? uid = null,
    Object? name = null,
    Object? chatId = null,
    Object? photoURL = null,
    Object? fCMToken = null,
    Object? isTyping = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: null == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String,
      fCMToken: null == fCMToken
          ? _value.fCMToken
          : fCMToken // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMemberEntityImplCopyWith<$Res>
    implements $ChatMemberEntityCopyWith<$Res> {
  factory _$$ChatMemberEntityImplCopyWith(_$ChatMemberEntityImpl value,
          $Res Function(_$ChatMemberEntityImpl) then) =
      __$$ChatMemberEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      String uid,
      String name,
      String chatId,
      String photoURL,
      String fCMToken,
      String isTyping});
}

/// @nodoc
class __$$ChatMemberEntityImplCopyWithImpl<$Res>
    extends _$ChatMemberEntityCopyWithImpl<$Res, _$ChatMemberEntityImpl>
    implements _$$ChatMemberEntityImplCopyWith<$Res> {
  __$$ChatMemberEntityImplCopyWithImpl(_$ChatMemberEntityImpl _value,
      $Res Function(_$ChatMemberEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? uid = null,
    Object? name = null,
    Object? chatId = null,
    Object? photoURL = null,
    Object? fCMToken = null,
    Object? isTyping = null,
  }) {
    return _then(_$ChatMemberEntityImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: null == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String,
      fCMToken: null == fCMToken
          ? _value.fCMToken
          : fCMToken // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMemberEntityImpl implements _ChatMemberEntity {
  _$ChatMemberEntityImpl(
      {required this.uuid,
      required this.uid,
      required this.name,
      required this.chatId,
      required this.photoURL,
      required this.fCMToken,
      required this.isTyping});

  factory _$ChatMemberEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMemberEntityImplFromJson(json);

  @override
  final String uuid;
  @override
  final String uid;
  @override
  final String name;
  @override
  final String chatId;
  @override
  final String photoURL;
  @override
  final String fCMToken;
  @override
  final String isTyping;

  @override
  String toString() {
    return 'ChatMemberEntity(uuid: $uuid, uid: $uid, name: $name, chatId: $chatId, photoURL: $photoURL, fCMToken: $fCMToken, isTyping: $isTyping)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMemberEntityImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.fCMToken, fCMToken) ||
                other.fCMToken == fCMToken) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uuid, uid, name, chatId, photoURL, fCMToken, isTyping);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMemberEntityImplCopyWith<_$ChatMemberEntityImpl> get copyWith =>
      __$$ChatMemberEntityImplCopyWithImpl<_$ChatMemberEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMemberEntityImplToJson(
      this,
    );
  }
}

abstract class _ChatMemberEntity implements ChatMemberEntity {
  factory _ChatMemberEntity(
      {required final String uuid,
      required final String uid,
      required final String name,
      required final String chatId,
      required final String photoURL,
      required final String fCMToken,
      required final String isTyping}) = _$ChatMemberEntityImpl;

  factory _ChatMemberEntity.fromJson(Map<String, dynamic> json) =
      _$ChatMemberEntityImpl.fromJson;

  @override
  String get uuid;
  @override
  String get uid;
  @override
  String get name;
  @override
  String get chatId;
  @override
  String get photoURL;
  @override
  String get fCMToken;
  @override
  String get isTyping;
  @override
  @JsonKey(ignore: true)
  _$$ChatMemberEntityImplCopyWith<_$ChatMemberEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
