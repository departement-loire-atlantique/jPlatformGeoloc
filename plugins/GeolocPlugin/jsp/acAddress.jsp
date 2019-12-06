<%@ include file='/jcore/doInitPage.jsp' %>

<%
String txtSearch = getUntrustedStringParameter("autocomplete", "");

if(txtSearch.length() < 3) {%>
  <div class="typeahead-menu noTooltipCard typeahead-search ajax-refresh-div" style="display: none;">
    <ul class="dropdown-menu dropdown-menu-adress-r1 dropdown-menu-cg44" style="display: none;">
      <li>Nombre de caract�res insuffisants</li>
    </ul>
  </div>
  <% return;} %>
  
<div class="typeahead-menu noTooltipCard typeahead-search ajax-refresh-div resultats" >

  <ul id="adress-select" class="dropdown-menu dropdown-menu-adress dropdown-menu-cg44">
    <li id="load-adress"><img src="plugins/GeolocPlugin/images/ajax-loading.gif" width="20px" alt="Chargement en cours..." /></li>
  </ul>
  
	<script>
	// Ex�cute un appel AJAX GET
	// Prend en param�tres l'URL cible et la fonction callback appel�e en cas de succ�s
	// https://openclassrooms.com/fr/courses/3306901-creez-des-pages-web-interactives-avec-javascript/3626516-interrogez-un-serveur-web
	
	function ajaxGet(url, callback) {
	    var req = new XMLHttpRequest();
	    req.open("GET", url);
	    req.addEventListener("load", function () {
	        if (req.status >= 200 && req.status < 400) {
	            // Appelle la fonction callback en lui passant la r�ponse de la requ�te
	            callback(req.responseText);
	        } else {
	            console.error(req.status + " " + req.statusText + " " + url);
	        }
	    });
	    req.addEventListener("error", function () {
	        console.error("Erreur r�seau avec l'URL " + url);
	    });
	    req.send(null);
	}
	
	// Construction de la query pour la BAN. On rajoute "Loire-Atlantique" � la fin pour essayer de limiter les r�sultats � cette zone.
	var query = document.getElementById('addressGeocoder').value+" Loire-Atlantique";
	ajaxGet('<%=channel.getProperty("plugin.geoloc.geolocation.api")%>&q='+query, function (reponse) {

	   var obj = JSON.parse(reponse);
	   var features = obj.features;

	   if(features.length != 0) {
	       document.getElementById("load-adress").remove();
	       for(i in features){                 
               var list = document.createElement('li');
               if(i==0){
                   list.setAttribute('class', 'active');
               }
               var text = document.createTextNode(features[i].properties.label);
               var link = document.createElement('a');

               link.setAttribute('href', 'javascript:;');
               link.setAttribute('data-long', features[i].geometry.coordinates[0]);
               link.setAttribute('data-lat', features[i].geometry.coordinates[1]);
               
               link.appendChild(text);
               list.appendChild(link);             
               document.getElementById('adress-select').appendChild(list);
            }
         }else {             
           var list = document.createElement('li');
           var text = document.createTextNode("L'adresse n'est pas trouv�e");
           list.appendChild(text);
           document.getElementById('adress-select').appendChild(list);           
         }

    });

	</script>

</div>





