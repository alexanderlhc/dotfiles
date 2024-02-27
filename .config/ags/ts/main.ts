//import Gdk from 'gi://Gdk';
// import { Workspaces } from "./bar/Workspaces"
import { TopBar } from "./bar/Topbar"
// 
// const Bar = (monitor: number) => Widget.Window({
//   name: `bar-${monitor}`,
//   child: Widget.Label('hello'),
// })
// 
// 
export default {
  // style: '/home/alexander/.config/ags/ts/style.css',
  windows: [
    // Bar(0),
    TopBar({monitor: 0}),
  ]
}

//const Bar = (monitor: number) => Widget.Window({
//    name: `bar-${monitor}`,
//    child: Widget.Label('hello'),
//})
//
//export default {
//    windows: [Bar(0)]
//}
