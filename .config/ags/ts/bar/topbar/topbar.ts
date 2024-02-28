import { Center } from './center';
import { Left } from './left';
import { Right } from './right';


const Topbar = ({ monitor = 0 }: { monitor: number }) => Widget.Window({
  monitor,
  name: `bar${monitor}`,
  class_name: 'bar',
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  layer: "top",
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right()
  }),
});

export { Topbar };
