# Rihla

Application de voyage en Tunisie, TP 3 : Widgets & layouts (Flutter).

Ahmed Lahouel DSI33

## Questions de compréhension

### Palier 2

1. Sans Expanded, l’avatar se place juste après le texte, à gauche. Expanded prend l’espace restant et pousse l’avatar à droite.
2. prenom est déclaré final parce qu’on ne peut pas changer sa valeur après sa création.
3. cs.primary change selon la seedColor, alors que Colors.teal reste toujours la même couleur.

### Palier 3

1. On ne voit plus le dégradé, car l’image passe devant lui. Dans un Stack, le dernier élément se place devant les autres.
2. Sans ClipRRect, les coins de la bannière deviennent carrés au lieu d’être arrondis.
3. right: 130 laisse de la place à droite pour le bouton « Découvrir », pour que le texte ne passe pas dessous.

### Palier 4

1. Expanded donne une largeur limitée à la Column. Comme ça, Spacer peut prendre l’espace libre et pousser le prix à droite.
2. Il suffit d’ajouter une destination dans lib/data/destinations.dart et son image dans assets/images/. La boucle affiche automatiquement la nouvelle destination.

### Palier 5

1. \_categorie change en mémoire, mais l’écran ne change pas, car sans setState, Flutter ne met pas l’interface à jour.
2. \_filtrees est recalculé à chaque build() pour afficher les destinations selon la catégorie choisie. Une variable risque de garder l’ancienne liste.
3. HeroBanner reste un StatelessWidget parce qu’il ne change pas avec le filtre. Seul HomeScreen gère les changements.
