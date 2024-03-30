import { Battery } from "../../widgets/battery.js";
import { Clock } from "../../widgets/clock.js";
import { Date } from "../../widgets/date.js";
import { Power } from "../../widgets/power.js";
import { Tray } from "../../widgets/tray.js";
import { Volume } from "../../widgets/volume.js";

const Right = () => {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [Tray(), Volume(), Date(), Clock(), Battery(), Power()],
  });
};

export { Right };
