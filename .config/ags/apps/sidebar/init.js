import { VolumePixel } from "../../modules/widgets/volume-dashed-slider.js";
import { HeightControlled } from "../../modules/widgets/height-controlled.js";

const SIDEBAR_ID = "sidebar"
export const toggleSidebar = () => App.ToggleWindow(SIDEBAR_ID)

/**
  * @param {number} length
  * @returns {string}
  */
const createDashedLine = (length) => Array(length).join("-")

const DashedLine = () => Widget.Label({
  label: createDashedLine(20),
})

const HeadlineText = (/** @type {string} */ headline, /** @type {number} */ width) => {
  const padding = width - headline.length
  if (padding < 0) {
    return headline
  }

  const leftPadding = Math.floor(padding / 2) - 1
  const rightPadding = padding - leftPadding - 1

  const left = createDashedLine(leftPadding)
  const right = createDashedLine(rightPadding)
  return `${left} ${headline} ${right}`
}

const DashedHeadline = (/** @type {string} */ headline, /** @type {number} */ width) => Widget.Label({
  label: HeadlineText(headline, width),
})

const SideBar = Widget.Box({
  className: "sidebar",
  widthRequest: 200,
  vertical: true,
  children: [
    Widget.CenterBox({
      centerWidget:
        Widget.Label({
          label: "Sidebar",
        }),
    }),
    HeightControlled(20),
    DashedHeadline("Volume", 20),
    VolumePixel(),
    HeightControlled(10),
  ]
})

/**
* @typedef {Object} TKeybind
* @property {string} key
* @property {() => void} action
*/

/** @type {TKeybind[]} */
const keybinds = [
  {
    key: "Escape",
    action: () => App.closeWindow(SIDEBAR_ID)
  }
]

/**
* @param {import("../../types/widgets/window.d.ts").Window} self
*/
const setupWindow = (self) => {
  keybinds.forEach(({ key, action }) => {
    self.keybind(
      // @ts-ignore
      key,
      action)
  })
}

const WindowApp = Widget.Window({
  name: SIDEBAR_ID,
  setup: setupWindow,
  // layer: "overlay",
  // type: Gtk.WindowType.POPUP,
  resizable: true,
  keymode: "on-demand",
  anchor: ["top", "bottom", "right"],
  child: SideBar,
})

const init = () => {
  App.config({
    windows: [WindowApp],
  })
  // App.closeWindow(SIDEBAR_ID)
}

init()
