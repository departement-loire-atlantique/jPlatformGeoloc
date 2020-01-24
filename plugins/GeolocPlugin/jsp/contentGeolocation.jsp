<%@ include file='/jcore/doInitPage.jsp' %><%
jcmsContext.addCSSHeader("https://api.tiles.mapbox.com/mapbox-gl-js/v1.3.1/mapbox-gl.css"); 
jcmsContext.addJavaScript("https://api.tiles.mapbox.com/mapbox-gl-js/v1.1.1/mapbox-gl.js");
jcmsContext.addJavaScript("plugins/GeolocPlugin/js/addressGeocoder.js");


Publication pub = channel.getPublication(request.getParameter("id"));
%>

<div class="form-group  widget field-publication">
    <div class="control-label  col-md-3 clearfix" max-width="90%">
        <label for="addressGeocoder"><%=glp("plugin.tools.geolocation")%></label>
    </div>
    <div class="widget-content col-md-9">
        <div class="input-group input-group-list-item tab-pane jalios-input-group">
            <input type="text" name="addressGeocoder" id="addressGeocoder"
                        class="form-control formTextfield typeahead adresseAutoComplete"
                        size="50" maxlength="50"
                        title="Précisez une adresse" placeholder="Saisir l'adresse"
                        value=""
                        data-jalios-ajax-refresh-url="plugins/GeolocPlugin/jsp/acAddress.jsp"
                        autocomplete="false"
                        data-longitude=""
                        data-latitude=""
                    />
            <div class="input-group-btn">
                <input class="btn btn-default" type="button" id="btnResetAddress" value="<%= glp("plugin.geoloc.geolocation.resetAddress") %>"/>
                <input class="btn btn-default" id="btnGeoloc" type="button" value="<%= glp("plugin.geoloc.geolocation.submit") %>" />
                <input class="btn btn-default" id="btnResetGeoloc" type="button" value="<%= glp("plugin.geoloc.geolocation.resetPosition") %>" />
            </div>
        </div>
        <div id="minimap" class="gmaps" style="margin-top:10px;  width:600px; height:300px;"></div>
    </div>
</div>


<jalios:javascript>
var map = new mapboxgl.Map({
    container: 'minimap',
    style: 'https://api.maptiler.com/maps/basic/style.json?key=<%=channel.getProperty("plugin.geoloc.maptiler.apikey") %>',
    center: [-1.8157647, 47.2780468],
    zoom: 9 - 1,
    minZoom: 6 -1,
    maxZoom: 19 -1
    
});

var marker = new mapboxgl.Marker({
        draggable: true
    });

// Ajout des contrôles sur la carte
map.addControl(new mapboxgl.NavigationControl());

/* Initialisation du marqueur long/lat sur la carte
 * But : récupérer les valeurs des extradatas longitude et latitude pour initialiser la carte.
 * 
 * Se baser sur le <div> parents qui contient la classe "widget-name-extraValues"
 * Regarder le <label> pour récupérer les champ long/lat
 * Récupérer la valeur de l'<input>
 */
var extradataElements = document.getElementsByClassName("widget-name-extraValues");
var longElement = null;
var latElement = null;


for (i = 0; i < extradataElements.length; i++) {
  // On cherche la longitude
  if(extradataElements[i].getElementsByTagName("label")[0].innerHTML=="Longitude"){
    longElement = extradataElements[i].getElementsByTagName("input")[0];
  }
  // On cherche la latitude
  else if(extradataElements[i].getElementsByTagName("label")[0].innerHTML=="Latitude"){
    latElement= extradataElements[i].getElementsByTagName("input")[0];
  }
}

// Coordonnées trouvées : on initialise la carte
if(longElement.value!="" && latElement.value!=""){
    flyToPoint(longElement.value,latElement.value);
}

// Modifie les champs long / lat après avoir déplacé le marqueur
function onDragEnd() {
    var lngLat = marker.getLngLat();
    longElement.value = lngLat.lng;
    latElement.value = lngLat.lat;
}

// Modifie les champs long / lat après avoir déplacé le marqueur
function flyToPoint(long,lat) {
    marker.setLngLat([long, lat])
        .addTo(map);  
        map.flyTo({center: [long, lat], zoom: 15});
    longElement.value = long;
    latElement.value = lat;
  
}

marker.on('dragend', onDragEnd);

// Actions sur les 3 boutons
var addressGeocoderElement = document.getElementById("addressGeocoder");
var btnResetAddressElement = document.getElementById("btnResetAddress");
var btnGeolocElement = document.getElementById("btnGeoloc");
var btnResetGeolocElement = document.getElementById("btnResetGeoloc");

// Reset adresse
btnResetAddressElement.on('click', function(){
    addressGeocoderElement.value = "";
});

// Reset géoloc
btnResetGeolocElement.on('click', function(){
    marker.remove();
    latElement.value = "";
    longElement.value = "";
});

// Déplace le marqueur à l'adresse saisie et value les long/lat
btnGeolocElement.on('click', function(){
    var long = addressGeocoderElement.getAttribute("data-longitude");
    var lat = addressGeocoderElement.getAttribute("data-latitude");

    if(long!="" && lat!=""){
        flyToPoint(long,lat);
    }
});

</jalios:javascript>

<jalios:javascript>
jQuery(document).ready(function() {
  jQuery('#AjaxCtxtDeflate').removeAttr("id");
  jQuery('body').removeAttr("id");
  jQuery('#CSRFTokenElm').removeAttr("id"); 
});
</jalios:javascript>

