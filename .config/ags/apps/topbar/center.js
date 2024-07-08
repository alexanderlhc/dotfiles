import { DateTime } from "../../modules/widgets/datetime.js";

const Center = () =>
  Widget.Box({
    spacing: 8,
    children: [
      DateTime(),
    ],
  });

export { Center };
