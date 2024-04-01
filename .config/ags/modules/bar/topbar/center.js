// import { Notification } from 'ts/widgets/notification';
import { DateTime } from "../../widgets/datetime.js";

const Center = () =>
  Widget.Box({
    spacing: 8,
    children: [
      // Notification()
      DateTime(),
    ],
  });

export { Center };
