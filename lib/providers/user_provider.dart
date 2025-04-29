import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/social_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  SocialModel? _social;
  String? _validacaoIA;
  String? _qrCodeData;

  UserModel? get user => _user;
  SocialModel? get social => _social;
  String? get validacaoIA => _validacaoIA;
  String? get qrCodeData => _qrCodeData;

  void cadastrarUsuario(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void cadastrarRedes(SocialModel social) {
    _social = social;
    notifyListeners();
  }

  void salvarValidacaoIA(String texto) {
    _validacaoIA = texto;
    notifyListeners();
  }

  void gerarQRCode(String dados) {
    _qrCodeData = dados;
    notifyListeners();
  }

  void limparTudo() {
    _user = null;
    _social = null;
    _validacaoIA = null;
    _qrCodeData = null;
    notifyListeners();
  }
}
