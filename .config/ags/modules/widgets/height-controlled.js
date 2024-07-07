/** Creates a block to control the height of the bar */
export const HeightControlled = (/** @type {number} */ height) =>
  Widget.DrawingArea({
    widthRequest: 0,
    heightRequest: height,
  });
