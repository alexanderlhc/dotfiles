import { Battery } from "../../modules/widgets/battery.js";
import { Power } from "../../modules/widgets/power.js";
import { Tray } from "../../modules/widgets/tray.js";
import { Volume } from "../../modules/widgets/volume.js";

const Right = () => {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [Tray(), Battery(), Volume(), Power()],
  });
};

export { Right };
