// import { Notification } from 'ts/widgets/notification';
import { Clock } from "../../widgets/clock.js";
import { Date } from "../../widgets/date.js";

const Center = () =>
  Widget.Box({
    spacing: 8,
    children: [
      // Notification()
      Clock(),
      Date(),
    ],
  });

export { Center };
