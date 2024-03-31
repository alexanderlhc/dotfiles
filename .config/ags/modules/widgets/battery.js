const battery = await Service.import("battery");

const Battery = () => {
  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [BatteryIcon()],
  });
};

const BatteryIcon = () =>
  Widget.Icon({
    icon: "alarm-symbolic", // default, other is set at bind,
    tooltip_text: "Battery",
  }).hook(battery, (self) => {
    const { percent, charging } = battery;
    self.tooltip_text = `Battery: ${percent}% ${charging ? "(charging)" : ""}`;
    self.icon = batteryIconName(percent, charging);
  });

const batteryIconName = (
  /** @type {number} */ percent,
  /** @type {boolean} */ charging,
) => {
  const icon_level = Math.floor(percent / 10) * 10;
  return `battery-level-${icon_level}-${charging ? "charging-" : ""}symbolic`;
};

export { Battery };
