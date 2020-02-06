package paddy.ui;

import zui.Ext;
import zui.Id;
import zui.Zui;

// Editor
import paddy.data.Themes;
import paddy.data.Data.ObjectData;

@:access(zui.Zui)
class UIProperties {

	public static var propsW = 200;
	public static var propsH = 600;

	public static var propsHandle = Id.handle();

	public static var propTabHandle = Id.handle();

	public static var propPanelWinH = Id.handle({selected:true});
	public static var propPanelObjH = Id.handle({selected:true});

	public static var nodeSlots = [];

	public static function render(ui:Zui) {
		var window = App.window;

		var selectedObj = App.selectedObj;

		if(ui.window(propsHandle, kha.System.windowWidth()-propsW, 30, Std.int(propsW*ui.SCALE()), propsH)){
			if(ui.tab(propTabHandle, "Properties")){
				if(ui.panel(propPanelWinH, "Window")){
					ui.indent();
					ui.row([1/4, 3/4]);
					ui.text("Name");
					window.name = ui.textInput(Id.handle({text: window.name}), Right);
					ui.row([1/4, 3/4]);
					ui.text("Width");
					var handlew = Id.handle({text: window.width+""});
					handlew.text = window.width + "";
					var strw = ui.textInput(handlew, Right);
					window.width = Std.parseInt(strw);
					ui.row([1/4, 3/4]);
					ui.text("Height");
					var handleh = Id.handle({text: window.height+""});
					handleh.text = window.height + "";
					var strh = ui.textInput(handleh, Right);
					window.height = Std.parseInt(strh);
					ui.row([1/4, 3/4]);
					ui.text("Mode");
					var windowHandle = Id.handle({position: 0});
					ui.combo(Id.handle({position: 0}), ["Windowed", "Fullscreen"], Right);
					if (windowHandle.changed) window.windowMode = windowHandle.position;

					for (value in paddy.Plugin.plugins) if (value.propWinPanelUI != null) value.propWinPanelUI(ui);

					ui.unindent();
				}
				if(selectedObj!=null){
					var obj = selectedObj;
					var id = obj.id;
					if (ui.panel(propPanelObjH, "Object")) {
						ui.indent();
						ui.row([2/6, 4/6]);
						ui.text("Name");
						obj.name = ui.textInput(Id.handle().nest(id, {text: obj.name}), Right);

						ui.row([2/6, 4/6]);
						ui.text("X");
						var handlex = Id.handle().nest(id, {text: obj.x + ""});
						handlex.text = obj.x + "";
						var strx = ui.textInput(handlex, Right);
						obj.x = Std.parseFloat(strx);

						ui.row([2/6, 4/6]);
						ui.text("Y");
						var handley = Id.handle().nest(id, {text: obj.y + ""});
						handley.text = obj.y + "";
						var stry = ui.textInput(handley, Right);
						obj.y = Std.parseFloat(stry);

						ui.row([2/6, 4/6]);
						ui.text("Width");
						var handlew = Id.handle().nest(id, {text: obj.width + ""});
						handlew.text = obj.width + "";
						var strw = ui.textInput(handlew, Right);
						obj.width = Std.int(Std.parseFloat(strw));

						ui.row([2/6, 4/6]);
						ui.text("Height");
						var handleh = Id.handle().nest(id, {text: obj.height + ""});
						handleh.text = obj.height + "";
						var strh = ui.textInput(handleh, Right);
						obj.height = Std.int(Std.parseFloat(strh));

						ui.row([2/6, 4/6]);
						ui.text("Rotation");
						var handlerot = Id.handle().nest(id, {value: paddy.util.Math.roundPrecision(paddy.util.Math.toDegrees(obj.rotation == null ? 0 : obj.rotation), 2)});
						handlerot.value = paddy.util.Math.roundPrecision(paddy.util.Math.toDegrees(obj.rotation), 2);
						if (handlerot.value >= 360) handlerot.value = 0;
						obj.rotation = paddy.util.Math.toRadians(ui.slider(handlerot, "", 0.0, 360.0));

						obj.animate = ui.check(Id.handle().nest(id, {selected: false}), "Animate");

						if(ui.panel(Id.handle(), "Nodes")){
							if(UINodes.nodesArray.length != 0){
								if(ui.button("Add")) obj.scripts.push({name: " ", scriptRef: " "});
								for (slot in 0...obj.scripts.length){
									var nodesHandle = Id.handle().nest(slot, {position: 0});
									ui.combo(nodesHandle, UINodes.getNodesArrayNames(), Right);
									obj.scripts[slot] = {
										name: UINodes.getNodesArrayNames()[nodesHandle.position],
										scriptRef: UINodes.getNodesArrayNames()[nodesHandle.position]+".json"
									}
								}
							}else{
								ui.text("Create nodes first!");
							}
						}
						for (value in paddy.Plugin.plugins) if (value.propObjPanelUI != null) value.propObjPanelUI(ui);

						ui.unindent();
					}
				}
				for (value in paddy.Plugin.plugins) if (value.propTabUI != null) value.propTabUI(ui);
			}
			for (value in paddy.Plugin.plugins) if (value.propWinUI != null) value.propWinUI(ui);
		}
	}
}
