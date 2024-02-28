

// calls wlogout

const onClickPower = () => {
  Utils.exec('wlogout');
}

const Power = () => Widget.Box({
  class_name: 'power',
  children: [
    Widget.Button({
      onClicked: onClickPower,
      child: Widget.Icon({
        icon: 'system-shutdown-symbolic',
      }),
    })
    // Widget.Icon().hook('power', self => {
    //   self.icon = 'system-shutdown-symbolic';
    // }),
  ],
});


export { Power };
