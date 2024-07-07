import { Icon } from "resource:///com/github/Aylur/ags/widgets/icon.js";
const { query } = await Service.import("applications");
const audio = await Service.import("audio");

const toShowSlider = Variable(false);

const VolumePixel = () =>
  Widget.CenterBox({
    centerWidget: Widget.Box({
      class_name: "volume",
      children: [
        VolumeIcon(),
        VolumeSlider(),
        VolumeText(),
      ],
    })
  })

const VolumeText = () =>
  Widget.Label({
    label: (audio.speaker.volume * 100).toFixed(0) + "%",
  }).hook(audio.speaker, (self) => {
    self.label = (audio.speaker.volume * 100).toFixed(0) + "%";
  })


const VolumeIcon = () =>
  Widget.Button({
    on_secondary_click: () => {
      const pavucontrol = query("pavucontrol")[0];
      if (pavucontrol) pavucontrol.launch();
    },
    on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    child: Widget.Icon().hook(audio.speaker, setIcon),
  });

const fillWithChar = (char, length) => Array(length).join(char);

const getVolumeStringFormatted = (/** @type {number} */ volume) => {
  const zeroToHundredScale = Math.round(volume * 100);
  const width = 15;
  const filledBlocks = Math.round((zeroToHundredScale / 100) * width);
  const emptyBlocks = width - filledBlocks;

  return `[${fillWithChar("=", filledBlocks)}${fillWithChar("-", emptyBlocks)}]`;
}


const VolumeSlider = () =>
  Widget.Button({
    child: Widget.Label({
      label: getVolumeStringFormatted(0),
    }).hook(audio, (self) => {
      self.label = getVolumeStringFormatted(audio.speaker.volume);
    }),
    onScrollUp: () => {
      audio.speaker.volume += 0.02;
    },
    onScrollDown: () => {
      audio.speaker.volume -= 0.02;
    }
  })

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

  const iconDir = "./icons";
  const icon =
    iconValue === undefined
      ? "dialog-error-symbolic"
      : `${iconDir}/vol_${category[iconValue]}.png`

  self.icon = icon;
};

export { VolumePixel };
