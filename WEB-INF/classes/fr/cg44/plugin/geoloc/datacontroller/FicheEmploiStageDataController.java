package fr.cg44.plugin.geoloc.datacontroller;

import java.util.Map;
import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.jcms.context.JcmsMessage.Level;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheEmploiStage;

public class FicheEmploiStageDataController extends BasicDataController implements PluginComponent {

	private static Channel channel = Channel.getChannel();

	@Override
	/* Les champs latitude et longitude sont obligatoires
	 * */
	public ControllerStatus checkIntegrity(Data data) {
		FicheEmploiStage itFiche = (FicheEmploiStage) data;

		String latitude = itFiche.getExtraData("extra.FicheEmploiStage.plugin.tools.geolocation.latitude");
		String longitude = itFiche.getExtraData("extra.FicheEmploiStage.plugin.tools.geolocation.longitude");

		if(Util.isEmpty(latitude)) {
			String userLang = channel.getCurrentJcmsContext().getUserLang();

			ControllerStatus status = new ControllerStatus();
			status.setProp("msg.edit.empty-field", JcmsUtil.glp(userLang, "plugin.tools.geolocation.latitude"));

			return status;
		}
		
		if(Util.isEmpty(longitude)) {
			String userLang = channel.getCurrentJcmsContext().getUserLang();
			
			ControllerStatus status = new ControllerStatus();
			status.setProp("msg.edit.empty-field", JcmsUtil.glp(userLang, "plugin.tools.geolocation.longitude"));
			
			return status;
		}
		
		return super.checkIntegrity(data);
	}


}