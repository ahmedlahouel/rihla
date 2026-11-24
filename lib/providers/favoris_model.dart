import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/destination.dart';

/// Favoris partagés par tous les écrans.
class FavorisModel extends ChangeNotifier {
  static const _cle = 'favoris';

  // favoris rangés par id : Map<String, Destination>
  final Map<String, Destination> _favoris = {};

  // TODO estFavori(Destination d) -> bool
  bool estFavori(Destination d) => _favoris.containsKey(d.id);

  // TODO getter liste : les destinations favorites
  List<Destination> get liste => List.unmodifiable(_favoris.values);

  // TODO getter nombre
  int get nombre => _favoris.length;

  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();
    final textes = prefs.getStringList(_cle) ?? [];
    for (final texte in textes) {
      final d = Destination.fromJson(jsonDecode(texte) as Map<String, dynamic>);
      _favoris[d.id] = d;
    }
    notifyListeners();
  }

  Future<void> _sauvegarder() async {
    final prefs = await SharedPreferences.getInstance();
    final textes = _favoris.values.map((d) => jsonEncode(d.toJson())).toList();
    await prefs.setStringList(_cle, textes);
  }

  // TODO basculer(Destination d) : ajoute ou retire,
  //      prévient les écouteurs, renvoie true si ajouté
  bool basculer(Destination d) {
    final ajoute = !_favoris.containsKey(d.id);
    if (ajoute) {
      _favoris[d.id] = d;
    } else {
      _favoris.remove(d.id);
    }
    _sauvegarder();
    notifyListeners();
    return ajoute;
  }
}