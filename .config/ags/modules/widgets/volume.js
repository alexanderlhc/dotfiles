import { Icon } from "resource:///com/github/Aylur/ags/widgets/icon.js";
const { query } = await Service.import("applications");
const audio = await Service.import("audio");

const toShowSlider = Variable(false);

const Volume = () =>
  Widget.Box({
    class_name: "volume",
    children: [VolumeIcon(), VolumeSlider()],
  });

const VolumeIcon = () =>
  Widget.Button({
    on_secondary_click: () => {
      const pavucontrol = query("pavucontrol")[0];
      if (pavucontrol) pavucontrol.launch();
    },
    on_clicked: () => (toShowSlider.value = !toShowSlider.value),
    child: Widget.Icon().hook(audio.speaker, setIcon),
  });

const VolumeSlider = () =>
  Widget.Box({
    visible: toShowSlider.bind(),
    class_name: "volume-slider",
    children: [
      Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => (audio.speaker.volume = value),
        setup: (self) =>
          self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0;
          }),
      }),
    ],
  });

/**
 * @param {Icon<unknown>} self
 */
const setIcon = (self) => {
  const category = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  const iconValue = audio.speaker.is_muted
    ? 0
    : [101, 67, 34, 1, 0].find(
        (threshold) => threshold <= audio.speaker.volume * 100,
      );

  const icon =
    iconValue === undefined
      ? "dialog-error-symbolic"
      : `audio-volume-${category[iconValue]}-symbolic`;

  self.icon = icon;
};

export { Volume };
