// coverage:ignore-file

import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/exception.dart';
import '../../../shared/network/data_transformer.dart';
import '../domain/dtos/auth_dto.dart';
import '../domain/repository.dart';
import 'package:collection/collection.dart';

final class AuthRepositoryImpl implements AuthRepository {
  late final SharedPreferencesAsync _store = SharedPreferencesAsync();

  List<AuthDto> _signedUpUsers = [];

  Future<List<AuthDto>> _fetchSignedUpUsers() async {
    final String cache = await _store.getString('signed_up_users') ?? '';
    if (cache.isEmpty) return [];

    if (_signedUpUsers.isNotEmpty) return _signedUpUsers;
    final listResult = await jsonDecode(cache);
    _signedUpUsers = switch (listResult) {
      List list => list.map((e) => AuthDto.fromJson(e)).toList(),
      _ => [],
    };

    return _signedUpUsers;
  }

  Future<void> _saveUsers(AuthDto user) async {
    final users = await _fetchSignedUpUsers();
    users.add(user);
    await _store.setString('signed_up_users', jsonEncode(users));
  }

  @override
  FutureBushaExceptionOr<String> loginUser(AuthDto dto) async {
    final users = await _fetchSignedUpUsers();

    final user = users.firstWhereOrNull(
        (element) => element.emailAddress == dto.emailAddress);
    if (user == null) return Left(MessageException('User not found'));

    if (user.password != dto.password) {
      return Left(MessageException('Invalid password'));
    }

    return Right('Login successful');
  }

  @override
  FutureBushaExceptionOr<String> signupUser(AuthDto dto) async {
    final users = await _fetchSignedUpUsers();

    final user = users.firstWhereOrNull(
        (element) => element.emailAddress == dto.emailAddress);

    if (user != null) return Left(MessageException('User already exists'));

    await _saveUsers(dto);
    return Right('Signup successful');
  }
}
