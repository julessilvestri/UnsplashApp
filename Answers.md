## Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.

LazyVGrid est un conteneur de SwiftUI qui organise ses éléments dans une grille verticale. Il génère et rend dynamique les éléments visibles à l'écran, améliorant ainsi les performances lorsqu'il y a un grand nombre d'éléments.
L'utilisation de LazyVGrid est bénéfique pour optimiser les performances, car elle permet de ne charger et de rendre en mémoire que les éléments visibles à l'écran. 

## Types de colonnes et pourquoi utiliser flexible ici:
Colonnes flexibles (GridItem(.flexible())) : Une colonne flexible s'ajuste dynamiquement en fonction de l'espace disponible. Cela signifie que si la largeur de l'écran change, les colonnes de la grille s'adapteront automatiquement pour utiliser cet espace de manière optimale. Ceci est utile pour les mises en page adaptatives, où vous souhaitez que la grille réagisse aux différentes tailles d'écran.

## Pourquoi utiliser flexible ici ? 
En utilisant des colonnes flexibles, la grille peut s'adapter de manière dynamique à la largeur de l'écran, offrant une expérience utilisateur plus fluide sur différents dispositifs et tailles d'écran. Cela garantit que la disposition des images reste agréable, même si la largeur de l'écran change.

## Pourquoi les images prennent toute la largeur de l'écran:
Dans le code fourni, les images semblent prendre toute la largeur de l'écran en raison de l'utilisation de GridItem(.flexible()). Lorsque vous utilisez des colonnes flexibles, elles s'étendent pour occuper tout l'espace horizontal disponible. Cela peut sembler moins esthétique car les images peuvent paraître élargies en fonction de la largeur de l'écran.
Si vous souhaitez que les images conservent une largeur fixe et ne s'étendent pas pour remplir tout l'écran, vous pouvez remplacer GridItem(.flexible()) par GridItem(.fixed(width)), où width est la largeur souhaitée pour chaque colonne. Cela garantira que les images ont une largeur fixe et ne s'étendent pas pour remplir l'écran entier.


## Exercice 2 :
pour afficher des images dans la grille, j'ai besoin de l'url et de l'id de l'image.

## Il existe 3 façons de faire un appel asynchrone en Swift. Expliquez les différences entre ces 3 méthodes.
- async/await : Nouveau modèle asynchrone introduit dans Swift 5.5, utilisant les mots-clés async et await.
- Combine : Framework de programmation réactive par Apple, offrant des opérateurs pour manipuler des flux de données asynchrones.
- completionHandler / GCD : Modèle traditionnel utilisant des gestionnaires de complétion et GCD pour la gestion de l'asynchronisme.