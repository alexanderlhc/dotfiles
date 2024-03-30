const time = Variable('', {
  poll: [1000, 'date "+%H:%M"'],
});

const Clock = () => Widget.Label({
  class_name: 'clock',
  label: time.bind(),
});

export { Clock };
