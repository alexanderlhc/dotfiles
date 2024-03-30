import { Workspaces } from "../../widgets/workspaces.js";

const Left = () =>
  Widget.Box({
    spacing: 8,
    children: [Workspaces()],
  });

export { Left };
