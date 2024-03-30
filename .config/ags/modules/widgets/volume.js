import { Icon } from "resource:///com/github/Aylur/ags/widgets/icon.js";
const audio = await Service.import("audio");

const toShowSlider = Variable(true);

const Volume = () =>
  Widget.Box({
    class_name: "volume",
    children: [VolumeIcon(), VolumeSlider()],
  });

const VolumeIcon = () =>
  Widget.Button({
    child: Widget.Icon().hook(audio.speaker, setIcon),
  }).on("clicked", () => {
    console.log("clicked", toShowSlider.value);
    toShowSlider.value = !toShowSlider.value;
  });

const VolumeSlider = (/** @type {boolean} */ toShow) =>
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
