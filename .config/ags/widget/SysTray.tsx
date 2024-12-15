import Tray from "gi://AstalTray?version=0.1";
import Gdk from "gi://Gdk?version=3.0";
import { bind } from "../../../../../usr/share/astal/gjs";
import App from "../../../../../usr/share/astal/gjs/gtk3/app";

export function SysTray() {
	const tray = Tray.get_default();

	return <box>
		{bind(tray, "items").as(items => items.map(item => {
			if (item.iconThemePath)
				App.add_icons(item.iconThemePath);

			const menu = item.create_menu();

			return <button
				tooltipMarkup={bind(item, "tooltipMarkup")}
				onDestroy={() => menu?.destroy()}
				onClickRelease={self => {
					menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null);
				}}>
				<icon gIcon={bind(item, "gicon")} />
			</button>;
		}))}
	</box>;
}

