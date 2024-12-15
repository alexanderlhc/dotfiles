import Hyprland from "gi://AstalHyprland?version=0.1";
import Gdk from "gi://Gdk?version=3.0";
import { bind } from "astal";

export function Workspaces({ gdkmonitor }: { gdkmonitor: Gdk.Monitor; }) {
	const hypr = Hyprland.get_default();
	const monitorName = getMonitorName(gdkmonitor);

	return (
		<box className="workspaces">
			{bind(hypr, "workspaces").as((wss) => wss
				.filter((ws) => ws.id > 0 && ws.monitor.name === monitorName)
				.sort((a, b) => a.id - b.id)
				.map((ws) => (
					<button
						className={bind(hypr, "focusedWorkspace").as((fw) => ws === fw ? "primary" : "dim"
						)}
						onClicked={() => ws.focus()}
					>
						{ws.id}
					</button>
				))
			)}
		</box>
	);
}
const display = Gdk.Display.get_default();
export function getMonitorName(gdkmonitor: Gdk.Monitor) {
	if (display) {
		const screen = display.get_default_screen();
		for (let i = 0; i < display.get_n_monitors(); ++i) {
			if (gdkmonitor === display.get_monitor(i))
				return screen.get_monitor_plug_name(i);
		}
	} else {
		return null;
	}
}

