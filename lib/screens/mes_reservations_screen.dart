import 'package:flutter/material.dart';

import '../models/reservation.dart';
import '../services/api_service.dart';
import 'home_screen.dart' show ErreurReseau;

class MesReservationsScreen extends StatefulWidget {
  const MesReservationsScreen({super.key});

  @override
  State<MesReservationsScreen> createState() => _MesReservationsScreenState();
}

class _MesReservationsScreenState extends State<MesReservationsScreen> {
  late Future<List<Reservation>> _futurReservations;

  @override
  void initState() {
    super.initState();
    _futurReservations = ApiService.getReservations();
  }

  Future<void> _recharger() async {
    final futur = ApiService.getReservations();
    setState(() {
      _futurReservations = futur;
    });
    try {
      await futur;
    } catch (_) {}
  }

  String _formaterDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Widget _construireCarte(Reservation r) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                r.destination.image,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.destination.nom,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Départ : ${_formaterDate(r.dateDepart)}'),
                  Text('Voyageurs : ${r.voyageurs} · ${r.formule}'),
                  const SizedBox(height: 4),
                  Text(
                    '${r.total} DT',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: _futurReservations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ErreurReseau(
            message: snapshot.error.toString(),
            onReessayer: _recharger,
          );
        }
        final reservations = snapshot.data!;
        return RefreshIndicator(
          onRefresh: _recharger,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Mes voyages',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (reservations.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(
                    child: Text('Aucune réservation pour le moment'),
                  ),
                )
              else
                for (final r in reservations) _construireCarte(r),
            ],
          ),
        );
      },
    );
  }
}