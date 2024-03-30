#!/usr/bin/ags -c

import { Topbar } from "./modules/bar/topbar/topbar.js";
// import { idle } from "resource:///com/github/Aylur/ags/utils.js";

const scss = `${App.configDir}/style/style.scss`;
const css = `/tmp/my-style.css`;

const liveReload = true;

const reloadCss = () => {
  // compile, reset, apply
  Utils.exec(`sassc ${scss} ${css}`);
  App.resetCss();
  App.applyCss(css);
};
reloadCss();

if (liveReload) {
  Utils.monitorFile(`${App.configDir}/style`, reloadCss);
} else {
  Utils.exec(`sassc ${scss} ${css}`);
}

// /**
//  * @param {import('types/@girs/gtk-3.0/gtk-3.0').Gtk.Window[]} windows
//  */
// const addWindows = (windows) => {
//   windows.forEach((w) => App.addWindow(w));
// };
//
// idle(() => {
//   addWindows([Topbar({ monitor: 0 })]);
// });

App.config({
  style: css,
  windows: [Topbar({ monitor: 0 })],
});
