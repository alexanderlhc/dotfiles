import GLib from "gi://GLib?version=2.0";
import { Variable } from "../../../../../usr/share/astal/gjs";

export function Clock() {
	function currentDate() {
		return GLib.DateTime.new_now_local().format("%H:%M • %d/%m") || "";
	}
	const date = Variable(currentDate())
		.poll(1000, currentDate);
	return <label className="date" label={date()} onDestroy={date.drop} />;
}

