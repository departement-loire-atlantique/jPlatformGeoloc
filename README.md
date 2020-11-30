# jPlatformGeoloc

<p>
  <a href="https://travis-ci.com/organizations/departement-loire-atlantique">
    <img src="https://travis-ci.com/departement-loire-atlantique/jPlatformGeoloc.svg?branch=master" />
  </a>
  <!--
  <a href="https://sonarcloud.io/organizations/departement-loire-atlantique">
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=ncloc" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=bugs" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=code_smells" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=coverage" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=duplicated_lines_density" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=sqale_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=alert_status" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=reliability_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=security_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=sqale_index" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformGeoloc&metric=vulnerabilities" />
    </a>
    -->
</p>
Gestion de la géolocalisation des contenus jPlatform

Ce module remplace celui de Jalios basé sur Google Map. Il permet la géolocalisation en back-office de contenus jPlatform.

Il est basé sur Maptiler pour le rendu des cartes, et la Base d'Adresses Nationales (BAN) pour la géolocalisation.

Le module ajoute 2 extradatas "Longitude" et "Latitude" aux types de contenus définis en propriété.

Les extradatas sont ajoutées dynamiquement à la fin du chargement du store via un ChannelListener, dans la méthode "initAfterStoreLoad".


Il a été convenu qu'un contenu ne pouvait avoir qu'une seule géolocalisation. 
