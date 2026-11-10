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

### Palier 6

1. Sans clé, Flutter garde l’état selon la position de la carte. Après filtrage, le cœur peut se retrouver sur une autre destination ou le favori peut être perdu.
2. Avec key: ValueKey(d.nom), Flutter reconnaît chaque destination par son nom. Le cœur reste donc sur la bonne carte après le filtrage.

## TP 4

### Palier 2

1. Oui, le filtre est conservé. Quand on ouvre le détail, HomeScreen reste en mémoire. En revenant, on retrouve donc le même filtre.
2. DetailScreen reçoit la destination avec son constructeur (DetailScreen(destination: destination)). C'est le même principe que pour les autres widgets avec les paramètres final. On accède à la destination avec widget.destination.
3. Sans clipBehavior, l'effet d'animation au toucher dépasse des coins arrondis de la carte. Avec Clip.antiAlias, l'effet reste dans les limites de la carte.

### Palier 3

1. \_formKey.currentState!.validate() vérifie tous les champs du formulaire. Elle renvoie true si tout est correct et false s'il y a une erreur. Les messages d'erreur s'affichent sous les champs concernés.
2. inputFormatters empêche de saisir des caractères interdits et limite le nombre de chiffres. validator vérifie les données quand on clique sur Confirmer et affiche les erreurs.
3. dispose() permet de libérer les contrôleurs quand on quitte l'écran pour éviter de garder des ressources inutiles en mémoire.

### Palier 4

1. readOnly: true empêche l'utilisateur d'écrire directement dans le champ. Il doit choisir la date dans le calendrier. Sans ça, il pourrait saisir une date incorrecte.
2. \_total est recalculé automatiquement à chaque appel selon la formule choisie. Avec setState, l'écran se met à jour et affiche le nouveau prix sans avoir besoin de modifier \_total manuellement.

### Palier 5

1. reservation vaut null si l'utilisateur quitte le formulaire sans confirmer. Aucune réservation n'est renvoyée.
2. VS Code affiche l'avertissement « Don't use BuildContext's across async gaps ». Cela signifie qu'on ne doit pas utiliser context après un await sans vérifier que le widget existe encore. mounted permet de faire cette vérification.
3. Une boîte de dialogue fonctionne comme un écran. Elle s'ouvre au-dessus de l'écran actuel et se ferme avec Navigator.pop.

## TP 5

### Palier 0

- /destinations/99 : La destination n'existe pas, donc le serveur renvoie une erreur 404. Les codes 2xx indiquent un succès, les 4xx une erreur côté client et les 5xx une erreur côté serveur.

- Who chose the reservation id? C'est le serveur qui a généré l'ID automatiquement, car on n'a pas envoyé d'ID dans le body. C'est pour ça que Reservation.id peut être null.

- Why does GET have no body? GET sert à récupérer des données, donc l'URL suffit. POST sert à envoyer des données, comme une nouvelle réservation, donc il a besoin d'un body.
