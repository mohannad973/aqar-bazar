import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class SecureStorage{
  final _storage = FlutterSecureStorage();

  Future writeSecureEmail(String key , String value) async{
    var writeEmail = await _storage.write(key: key, value: value);
    return writeEmail;
  }

  Future readEmail(String key) async{
    var readEmail = await _storage.read(key: key);
    return readEmail;
  }

  Future deleteEmail(String key) async{
    var deleteEmail = await _storage.delete(key: key);
    return deleteEmail;
  }

  Future writeSecurePass(String key , String value) async{
    var writePass = await _storage.write(key: key, value: value);
    return writePass;
  }

  Future readPass(String key) async{
    var readPass = await _storage.read(key: key);
    return readPass;
  }

  Future deletePass(String key) async{
    var deletePass = await _storage.delete(key: key);
    return deletePass;
  }

  Future deleteAllSecureStorage(){
    var deleteAll = _storage.deleteAll();
    return deleteAll;
  }
}