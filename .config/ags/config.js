#!/usr/bin/ags -c

import { Topbar } from "./modules/bar/topbar/topbar.js";

import { exec, monitorFile } from "resource:///com/github/Aylur/ags/utils.js";
import Gio from "gi://Gio";
import Gdk from "gi://Gdk";
import Gtk from 'gi://Gtk?version=3.0';

const scss = `${App.configDir}/style/style.scss`;
const css = `/tmp/my-style.css`;
const liveReload = true;

const applyScss = () => {
  // Compile scss
  exec(`sassc ${scss} ${css}`);
  console.log("scss compiled");

  // Apply compiled css
  App.resetCss();
  App.applyCss(`${css}`);
  console.log("Compiled css applied");
};

monitorFile(`${App.configDir}/style`, (_, eventType) => {
  if (eventType === Gio.FileMonitorEvent.CHANGES_DONE_HINT && liveReload) {
    applyScss();
  }
});

applyScss();

const monitorCount = Gdk.Display.get_default()?.get_n_monitors() || 1;

/**
 * @param {Function} makeWindow 
 * @returns {Gtk.Window[]} 
 */
const addToAllMonitors = (makeWindow) => {
  const windows = [];
  for (let i = 0; i < monitorCount; i++) {
    windows.push(makeWindow({ monitor: i }))
  }
  return windows;
}

App.config({
  style: css,
  windows: [
    ...addToAllMonitors(Topbar)
    // Topbar({ monitor: 0 })
  ],
});
