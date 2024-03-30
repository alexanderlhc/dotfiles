const date = Variable('', {
  poll: [1000, 'date "+%b %e."'],
});

const Date = () => Widget.Label({
  class_name: 'clock',
  label: date.bind(),
});


export { Date };
