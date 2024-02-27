const audio = await Service.import('audio');

const Volume = () => Widget.Box({
  class_name: 'volume',
  css: 'min-width: 180px',
  children: [
    Widget.Icon().hook(audio.speaker, self => {
      const category = {
        101: 'overamplified',
        67: 'high',
        34: 'medium',
        1: 'low',
        0: 'muted',
      };

      const iconValue = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
        threshold => threshold <= audio.speaker.volume * 100);

      const icon = iconValue === undefined ? 'dialog-error-symbolic' : `audio-volume-${category[iconValue]}-symbolic`;

      self.icon = icon;
    }),
    Widget.Slider({
      hexpand: true,
      draw_value: false,
      on_change: ({ value }) => audio.speaker.volume = value,
      setup: self => self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
    }),
  ],
});

export { Volume };
