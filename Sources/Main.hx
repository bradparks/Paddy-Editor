package;

import kha.Scheduler;
import kha.System;

class Main {

	public static var title = "Paddy-Editor";
	public static var width = 1024;
	public static var height = 768;

	public static function main() {
		System.start({title: title, width: width, height: height}, function (_) {
			var project = new Project();
			Scheduler.addTimeTask(function () { project.update(); }, 0, 1 / 60);
			System.notifyOnFrames(function (frames) { project.render(frames); });
		});
	}
}