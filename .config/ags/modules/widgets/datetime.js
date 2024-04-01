import { Clock } from "./clock.js";
import { Date } from "./date.js";

const isExpanded = Variable(false);

const DateTime = () =>
  Widget.Button({
    child: Widget.Box({
      spacing: 8,
      children: [
        Clock(),

        Date().hook(isExpanded, self => {
          if (isExpanded.value) {
            self.show();
          } else {
            self.hide();
          }
        }),
      ]
    }),
    on_clicked: () => {
      isExpanded.value = !isExpanded.value;
    }
    ,
  })

export { DateTime };
