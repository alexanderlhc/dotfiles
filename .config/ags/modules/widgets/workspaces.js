import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";

const hyprland = await Service.import("hyprland");

const dispatch = (/** @type {string | number} */ ws) =>
  hyprland.messageAsync(`dispatch workspace ${ws}`);

const Workspaces = () =>
  Widget.EventBox({
    class_name: "workspaces",
    onScrollUp: () => dispatch("+1"),
    onScrollDown: () => dispatch("-1"),
    child: Widget.Box({
      children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
        Widget.Button({
          attribute: i,
          label: `WS ${i}`,
          onClicked: () => dispatch(i),
        }),
      ),
    }).hook(Hyprland, (box) => {
      box.children.forEach((btn, i) => {
        const ws = Hyprland.getWorkspace(i + 1);
        const isOccupied = (ws?.windows ?? 0) > 0;
        const isActive = Hyprland.active.workspace.id === i + 1;
        const isInUse = isOccupied || isActive;
        btn.visible = isInUse;
        btn.toggleClassName("occupied", isOccupied);
        btn.toggleClassName("active", isActive)
      });
    }),
  });

export { Workspaces };
