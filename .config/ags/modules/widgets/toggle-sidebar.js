import { toggleSidebar } from "../../apps/sidebar/init.js";

export const ToggleSidebar = () => Widget.Button({
  child: Widget.Label({ label: "☰" }),
  onClicked: () => {
    toggleSidebar()
  }
});
