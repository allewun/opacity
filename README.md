# Opacity

Given an image that contains layers of overlapping color with unknown opacities,
determine the possible original overlay layer colors and opacities, using only the
base layer color and the blended result color. It's not possible to calculate a
single original rgba value in most cases, so all the possible values are returned.

![Diagram](https://raw.github.com/allewun/opacity/master/opacity.png)


## Usage

    ./opacity.rb [options]
         -a, --alpha N                    Alpha opacity granularity (defaults to 0.01)
         -b, --background R,G,B           Specify background color
         -o, --overlay R,G,B              Specify overlay (blended) color
         -h, --help                       Show the help screen


## Example

    > ruby opacity.rb -o 108,183,117 -b 213,213,213

      Overlay/blended color:
        rgb(108, 183, 117)

      Background color:
        rgb(213, 213, 213)

      Possible foreground colors:
      ---------------------------
      rgba(3, 153, 21, 0.5)
      rgba(7, 154, 25, 0.51)
      rgba(11, 155, 28, 0.52)

      ...

      rgba(106, 182, 115, 0.98)
      rgba(107, 183, 116, 0.99)
      rgba(108, 183, 117, 1.0)
