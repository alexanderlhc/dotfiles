import { Center } from "./center.js";
import { Left } from "./left.js";
import { Right } from "./right.js";

const Topbar = ({ monitor = 0 }) =>
  Widget.Window({
    monitor,
    name: `bar${monitor}`,
    class_name: "topbar",
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    layer: "top",
    child: Widget.Box({
      children: [
        HeightControlled(37.5),
        Widget.CenterBox({
          start_widget: Left(),
          center_widget: Center(),
          end_widget: Right(),
        }),
      ],
    }),
  });

/** Creates a block to control the height of the bar */
const HeightControlled = (/** @type {number} */ height) =>
  Widget.DrawingArea({
    widthRequest: 0,
    heightRequest: height,
  });

export { Topbar };
