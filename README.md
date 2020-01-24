# jPlatformGeoloc
Gestion de la géolocalisation des contenus jPlatform

Ce module remplace celui de Jalios basé sur Google Map. Il permet la géolocalisation en back-office de contenus jPlatform.

Il est basé sur Maptiler pour le rendu des cartes, et la Base d'Adresses Nationales (BAN) pour la géolocalisation.

Le module ajoute 2 extradatas "Longitude" et "Latitude" aux types de contenus définis en propriété.

Les extradatas sont ajoutées dynamiquement à la fin du chargement du store via un ChannelListener, dans la méthode "initAfterStoreLoad".


Il a été convenu qu'un contenu ne pouvait avoir qu'une seule géolocalisation. 
