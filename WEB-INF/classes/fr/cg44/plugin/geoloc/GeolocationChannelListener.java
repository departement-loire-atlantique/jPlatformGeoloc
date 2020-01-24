package fr.cg44.plugin.geoloc;

import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.ChannelListener;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.plugin.Plugin;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.JProperties;
import com.jalios.util.JPropertiesListener;
import com.jalios.util.LangProperties;
import com.jalios.util.Util;


public class GeolocationChannelListener extends ChannelListener implements JPropertiesListener, PluginComponent {

  private Logger logger;

  private static final String EXTRA_PREFIX = "extra.";
  private static final String PREFIX = "plugin.tools.geolocation";
  private static final String SUFFIX_EXTRA_DATA_LAT = PREFIX + ".latitude";
  private static final String SUFFIX_EXTRA_DATA_LNG = PREFIX + ".longitude";


  @Override
  public void propertiesChange(JProperties jproperties) {
    Channel channel = Channel.getChannel();
    LangProperties langproperties = channel.getProperties(EXTRA_PREFIX);
    Iterator<String> itProperties = langproperties.keySet().iterator();

    while (itProperties.hasNext()) {
      String property = itProperties.next();

      // La propriété est une extra data de géolocalisation.
      if (property != null && 
          (property.indexOf("." + SUFFIX_EXTRA_DATA_LAT) > -1
          || property.indexOf("." + SUFFIX_EXTRA_DATA_LNG) > -1
          || property.indexOf("." + PREFIX) > -1)) {
        channel.getChannelProperties().remove(property);
      }
    }

    String[] types = channel.getStringArrayProperty("plugin.geoloc.geolocation.types", new String[] {});

    for (int i = 0; i < types.length; i++) {
      // Création des extra data de géolocalisation.
      String latitudeProperty = (new StringBuilder()).append(EXTRA_PREFIX).append(types[i]).append(".").append(SUFFIX_EXTRA_DATA_LAT).toString();
      String longitudeProperty = (new StringBuilder()).append(EXTRA_PREFIX).append(types[i]).append(".").append(SUFFIX_EXTRA_DATA_LNG).toString();
      String jspProperty = (new StringBuilder()).append(EXTRA_PREFIX).append(types[i]).append(".").append(PREFIX).append(".jsp").toString();
      channel.setProperty(latitudeProperty, "");
      channel.setProperty(longitudeProperty, "");
      channel.setProperty(jspProperty, "plugins/GeolocPlugin/jsp/contentGeolocation.jsp");

      // Création des libellés des extra data de géolocalisation.
      List<String> languages = channel.getLanguageList();
      for (String language : languages) {
        String latitudeLangProperty = (new StringBuilder()).append(language).append(".").append(EXTRA_PREFIX).append(types[i]).append(".").append(SUFFIX_EXTRA_DATA_LAT).toString();
        String longitudeLangProperty = (new StringBuilder()).append(language).append(".").append(EXTRA_PREFIX).append(types[i]).append(".").append(SUFFIX_EXTRA_DATA_LNG).toString();
        String generalLangProperty = (new StringBuilder()).append(language).append(".").append(EXTRA_PREFIX).append(types[i]).append(".").append(PREFIX).toString();
        String latitudeLangPropertyValue = JcmsUtil.glp(language, SUFFIX_EXTRA_DATA_LAT, new Object[0]);
        String longitudeLangPropertyValue = JcmsUtil.glp(language, SUFFIX_EXTRA_DATA_LNG, new Object[0]);
        String generalLangPropertyValue = JcmsUtil.glp(language, PREFIX, new Object[0]);
        channel.setProperty(latitudeLangProperty, latitudeLangPropertyValue);
        channel.setProperty(longitudeLangProperty, longitudeLangPropertyValue);
        channel.setProperty(generalLangProperty, generalLangPropertyValue);
      }
    }
  }

  @Override
  public void handleFinalize() {
  }

  @Override
  public void initAfterStoreLoad() throws Exception {
    propertiesChange(null);
  }

  @Override
  public void initBeforeStoreLoad() throws Exception {}
}
