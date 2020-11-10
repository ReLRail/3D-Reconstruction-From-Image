# 3DReconstructionFromImage
> This is course project for CMPEN/EE 454 - FUNDAMENTALS OF COMPUTER VISION at Penn State

##Intro

The goal of this project is to implement a forward (3D point to 2D point) and inverse (2D point to 3D  ray) camera projection by performing various image process techniques. This project involved understanding relationships between 2D image coordinates and  3D  world coordinates and the chain of transformations that make up the pinhole camera model that was discussed in class.  Our tasks were to project  3D  coordinates  (sets of 3D  joint locations on a human body, measured by motion capture equipment) into image pixel coordinates that you can overlay on top of an image, to then convert those  2D  points back into  3D  viewing rays,  and then triangulate the viewing rays of two camera views to recover the original 3D  coordinates you started with (or values close to those coordinates). By utilizing the course material and variety of functions from Matlab we were able to create such image processing tools. There are three main functions we implemented, project3DTo2D, reconstruct3DFrom2D, and findEpipolarLines, with all these functional features we are able to make conversion between 3D coordinate and 2D coordinate, and with the help of skeleton functional a fully reperstatable skeleton of the subject can be observed.

![](/img/flowchat.png)


## Installation

OS X & Linux & Windows:

This project runs with MATLAB

Just Download and Open

## Usage example

## Meta

Dawang Shen

Zekun Peng

Zhenghan Fang     – [GitHub Link](https://github.com/ReLRail/)

## Contributing

1. Fork it (<https://github.com/ReLRail/3DReconstructionFromImage/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki
