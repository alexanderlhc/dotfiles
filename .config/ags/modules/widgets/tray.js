import SystemTray, {
  TrayItem,
} from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Gdk from "gi://Gdk?version=3.0";

const toShowTray = Variable(false);

const Tray = () => Widget.Box({
  children: [
    TrayContainerIcon(),
    TrayContainer(),
  ]
})

const TrayContainerIcon = () =>
  Widget.Button({
    on_clicked: () => toShowTray.value = !toShowTray.value,
    child: Widget.Icon({
      icon: "view-app-grid-symbolic"
    })
  })

/**
 * @typedef {TrayItem} NewType
 */

/**
 * @param {import('types/service/systemtray').TrayItem} item
 */
const SysTrayItem = (item) =>
  Widget.Button({
    class_name: "tray-item",
    child: Widget.Icon({
      hpack: "center",
      icon: item.bind("icon"),
    }),
    tooltip_markup: item.bind("tooltip_markup"),
    on_clicked: (btn) =>
      item.menu?.popup_at_widget(
        btn,
        Gdk.Gravity.SOUTH,
        Gdk.Gravity.NORTH,
        null,
      ),
    on_secondary_click: (btn) =>
      item.menu?.popup_at_widget(
        btn,
        Gdk.Gravity.SOUTH,
        Gdk.Gravity.NORTH,
        null,
      ),
  });

const TrayContainer = () =>
  Widget.Box({
    class_name: "tray-container",
    visible: toShowTray.bind(),
    attribute: {
      items: new Map(),
      /**
       * @param {import('types/widgets/box').default} box
       * @param {string} id
       */
      onAdded: (box, id) => {
        const item = SystemTray.getItem(id);
        if (!item) return;
        // @ts-ignore
        if (item.menu) item.menu.class_name = "menu";
        if (box.attribute.items.has(id) || !item) return;
        const widget = SysTrayItem(item);
        box.attribute.items.set(id, widget);
        box.pack_start(widget, false, false, 0);
        // if (!toShowTray.value) return;
        box.show_all();
      },
      /**
       * @param {import('types/widgets/box').default} box
       * @param {string} id
       */
      onRemoved: (box, id) => {
        if (!box.attribute.items.has(id)) return;
        box.attribute.items.get(id).destroy();
        box.attribute.items.delete(id);
      },
    },
  })
    .hook(SystemTray, (box, id) => box.attribute.onAdded(box, id), "added")
    .hook(SystemTray, (box, id) => box.attribute.onRemoved(box, id), "removed");

export { Tray };
