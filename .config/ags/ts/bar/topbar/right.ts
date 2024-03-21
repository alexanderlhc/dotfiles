import { Battery } from "ts/widgets/battery";
import { Clock } from "ts/widgets/clock";
import { Date } from "ts/widgets/date";
import { Power } from "ts/widgets/power";
import { SysTray } from "ts/widgets/systray";
import { Volume } from "ts/widgets/volume";

const Right = () => {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [SysTray(), Volume(), Date(), Clock(), Battery(), Power()],
  });
};

export { Right };
