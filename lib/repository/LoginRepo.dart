import 'package:flutter_bloc_demo/network/network.dart';
import 'package:flutter_bloc_demo/repository/Respository.dart';

import '../network/Apis.dart';
import '../network/resource.dart';

class LoginRepo extends Repository{
  @override
  Future delete(id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future auth(dynamic params) async {
    return Network().post(Apis.auth, params);
  }

  @override
  Future insert(data) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future read(id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future update(id, data) {
    // TODO: implement update
    throw UnimplementedError();
  }

}