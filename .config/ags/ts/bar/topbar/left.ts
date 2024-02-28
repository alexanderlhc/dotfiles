import { Workspaces } from 'ts/widgets/workspaces';

const Left = () => Widget.Box({
  spacing: 8,
  children: [
    Workspaces()
  ]
})

export { Left };
