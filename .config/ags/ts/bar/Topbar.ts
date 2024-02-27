import { Workspaces } from './Workspaces';
const systemtray = await Service.import('systemtray');
const audio = await Service.import('audio');
const notifications = await Service.import('notifications');

// const Left = () => Widget.Box({
//   spacing: 8,
//   children: [
//     Workspaces(),
//   ],
// });

// const Center = () => Widget.Box({
//   spacing: 8,
//   children: [ ],
// });


// const Right = () => Widget.Box({
//   hpack: 'end',
//   spacing: 8,
//   children: [],
// });


const Left = () => Widget.Box({
  spacing: 8,
  children: [
    Workspaces()
  ]
})

function Notification() {
  const popups = notifications.bind('popups');
  return Widget.Box({
      class_name: 'notification',
      visible: popups.as(p => p.length > 0),
      children: [
          Widget.Icon({
              icon: 'preferences-system-notifications-symbolic',
          }),
          Widget.Label({
              label: popups.as(p => p[0]?.summary || ''),
          }),
      ],
  });
}

const Volume = () => Widget.Box({
  class_name: 'volume',
  css: 'min-width: 180px',
  children: [
      Widget.Icon().hook(audio.speaker, self => {
          const category = {
              101: 'overamplified',
              67: 'high',
              34: 'medium',
              1: 'low',
              0: 'muted',
          };

          const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
              threshold => threshold <= audio.speaker.volume * 100);

          self.icon = `audio-volume-${category[icon]}-symbolic`;
      }),
      Widget.Slider({
          hexpand: true,
          draw_value: false,
          on_change: ({ value }) => audio.speaker.volume = value,
          setup: self => self.hook(audio.speaker, () => {
              self.value = audio.speaker.volume || 0;
          }),
      }),
  ],
});


const Center = () => Widget.Box({
  spacing: 8,
  children: [
    Notification()
  ]
})


const date = Variable('', {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});




const Right = () => {

  const Clock = () => Widget.Label({
    class_name: 'clock',
    label: date.bind(),
});

const SysTray = () => Widget.Box({
  children: systemtray.bind('items').as(items =>
      items.map(item => Widget.Button({
          child: Widget.Icon({ icon: item.bind('icon') }),
          on_primary_click: (_, event) => item.activate(event),
          on_secondary_click: (_, event) => item.openMenu(event),
          tooltip_markup: item.bind('tooltip_markup'),
      })),
  ),
});

  return Widget.Box({
    hpack: 'end',
    spacing: 8,
    children: [
      SysTray(),
      Volume(),
      Clock()
    ]
  })
}


const TopBar = ({ monitor = 0 }: { monitor: number }) => Widget.Window({
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

export { TopBar };
