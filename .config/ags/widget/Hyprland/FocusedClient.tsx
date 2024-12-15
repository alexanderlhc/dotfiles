import Hyprland from "gi://AstalHyprland?version=0.1";
import Gdk from "gi://Gdk?version=3.0";
import { getMonitorName } from "./Workspaces";
import { bind } from "astal";

export function FocusedClient({ gdkmonitor }: { gdkmonitor: Gdk.Monitor; }) {
	const hypr = Hyprland.get_default();

	const focused = bind(hypr, "focusedClient");
	const monitorName = getMonitorName(gdkmonitor);

	return (
		<box visible={focused.as((f) => f && f.monitor.name === monitorName)}>
			{focused.as(
				(client) => client && (
					<label
						className="dim"
						label={bind(client, "title").as((s) => trunc(s || ""))} />
				)
			)}
		</box>
	);
}

function trunc(s: string, n = 32) {
	return s && s.length > n ? s.slice(0, n) + "…" : s || "";
}
