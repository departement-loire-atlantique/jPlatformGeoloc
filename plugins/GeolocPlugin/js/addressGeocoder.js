!function ($) {
	
    $(document).ready(function(){
    	
 	  // Value le champ adresse à partir de la liste autocmplete + ajout des attributs long/lat
      var addressGeocoderElement = $("#addressGeocoder");
      
  	  $(addressGeocoderElement).on('change blur',function() {
  		var liSelect = $(".dropdown-menu-adress li.active a");
		  if($(this).val()!=""){
			  if(liSelect.length == 1) {
			  	$(addressGeocoderElement).val(liSelect.html());
			  	$(addressGeocoderElement).attr("data-longitude",liSelect.attr("data-long"));
			  	$(addressGeocoderElement).attr("data-latitude",liSelect.attr("data-lat"));
			  }
		  }
  		  
  	  });
    });
	
  

}(window.jQuery);