# pray_time

Bonjour et bienvenue à l'application Flutter!

## Getting Started


Cette application est conçue pour aider les utilisateurs à gérer leur temps de prière en fonction de leur emplacement à Qatar. Elle est disponible en arabe et en anglais et prend en charge l'ajout de langues supplémentaires à l'avenir.

L'application comprend les fonctionnalités suivantes :

  - Des rappels pour chaque prière avec des options pour choisir entre une notification sonore d'adhane ou une simple sonnerie.
  - La possibilité pour l'utilisateur de définir le temps de rappel pour chaque prière, par exemple, l'alarme pour la prière du Fajr peut être réglée pour sonner 15         minutes après l'entrée de l'adhane.
  - L'utilisateur peut choisir entre une notification sonore d'adhane ou une simple sonnerie pour chaque prière.
  - La possibilité pour l'utilisateur de désactiver ou d'activer les rappels pour des prières spécifiques. Par exemple, l'utilisateur peut activer le rappel pour la         prière du Fajr, mais désactiver le rappel pour la prière du Dhuhr.
  - La possibilité de définir la direction de la qibla.

## Definir la direction de la Qibla avec flutter_qiblah

Flutter_qiblah est une bibliothèque Flutter open-source qui permet aux développeurs de facilement intégrer la direction de la qibla dans leurs applications. Cette bibliothèque utilise la boussole et les coordonnées GPS de l'appareil pour calculer la direction de la qibla par rapport à la position de l'utilisateur.

Pour utiliser Flutter_qiblah, il suffit d'ajouter la bibliothèque à votre projet Flutter et de l'importer dans votre fichier Dart. Vous pouvez ensuite utiliser la classe QiblahCompas pour récupérer la direction de la qibla. La bibliothèque fournit également des widgets pré-construits qui peuvent être personnalisés pour afficher la direction de la qibla à l'utilisateur.

## Définir des rappels pour chaque prière avec LocalNotification

LocalNotification est une bibliothèque open-source pour Flutter qui permet aux développeurs de facilement ajouter des notifications locales à leurs applications. Dans le contexte d'une application de prière, cette bibliothèque peut être utilisée pour définir des rappels pour chaque prière.

Pour utiliser LocalNotification, il suffit d'ajouter la bibliothèque à votre projet Flutter et de l'importer dans votre fichier Dart. Vous pouvez ensuite définir une notification pour chaque prière en utilisant la méthode schedule de la classe FlutterLocalNotificationsPlugin.

La méthode schedule prend plusieurs paramètres, y compris le temps de la notification, le contenu de la notification et l'identifiant unique de la notification. Vous pouvez utiliser l'heure de prière et le temps de rappel défini par l'utilisateur pour calculer le temps de la notification.

Lorsque l'heure de la prière est atteinte, la bibliothèque envoie une notification locale à l'utilisateur pour le rappeler de prier. L'utilisateur peut également choisir d'activer ou de désactiver les notifications pour chaque prière.

LocalNotification est une bibliothèque pratique et utile pour les applications de prière. Elle permet aux utilisateurs de définir des rappels personnalisés pour chaque prière, ce qui peut les aider à maintenir leur pratique religieuse et à ne pas manquer une prière importante.
