import { App, Astal, Gtk, Gdk, } from "astal/gtk3"
import { SysTray } from "./SysTray";
import { Clock } from "./Clock";
import { Workspaces } from "./Hyprland/Workspaces";

function Left({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
	return <box>
		<Workspaces gdkmonitor={gdkmonitor} />
	</box>
}

function Center() {
	return <box ><label label={""} /></box>
}
function Right() {
	return <box
		halign={Gtk.Align.END}
	>
		<SysTray />
		<Clock />
	</box>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
	return <window
		className="Bar"
		gdkmonitor={gdkmonitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | LEFT | RIGHT}
		application={App}>
		<centerbox>
			<Left gdkmonitor={gdkmonitor} />
			<Center />
			<Right />
		</centerbox>
	</window>
}

