import { Clock } from 'ts/widgets/clock';
import { Date } from 'ts/widgets/date';
import { SysTray } from 'ts/widgets/systray';
import { Volume } from 'ts/widgets/volume';

const Right = () => {
  return Widget.Box({
    hpack: 'end',
    spacing: 8,
    children: [
      SysTray(),
      Volume(),
      Date(),
      Clock(),
    ]
  })
}

export { Right };
