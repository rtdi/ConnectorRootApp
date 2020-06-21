sap.ui.define(["sap/ui/core/mvc/Controller"],
function(Controller) {"use strict";
return Controller.extend("io.rtdi.bigdata.Home", {
onInit : function() {
	var oModel = new sap.ui.model.json.JSONModel();
	oModel.loadData("./apps.json");
	this.getView().setModel(oModel);
}
});
});

