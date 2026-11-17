import 'destination.dart';

class Reservation {
  final String? id;
  final Destination destination;
  final String nom;
  final String email;
  final String telephone;
  final DateTime dateDepart;
  final int voyageurs;
  final String formule;

  const Reservation({
    this.id,
    required this.destination,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.dateDepart,
    required this.voyageurs,
    required this.formule,
  });
  
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'].toString(),
      destination: Destination.fromJson(
        json['destination'] as Map<String, dynamic>,
      ),
      nom: json['nom'] as String,
      email: json['email'] as String,
      telephone: json['telephone'] as String,
      dateDepart: DateTime.parse(json['dateDepart'] as String),
      voyageurs: json['voyageurs'] as int,
      formule: json['formule'] as String,
    );
  }

  int get prixParPersonne => formule == 'Confort'
      ? (destination.prix * 1.3).round()
      : destination.prix;

  int get total => prixParPersonne * voyageurs;

  Map<String, dynamic> toJson() {
    return {
      'destinationId': destination.id,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'dateDepart': dateDepart.toIso8601String(),
      'voyageurs': voyageurs,
      'formule': formule,
      'total': total,
    };
  }
}
