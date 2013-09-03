#version 3.6;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.1 diffuse 0.9 }}
#include "colors.inc"
#include "textures.inc"
#include "Strukturen.inc"

#macro Elementarzelle (px,py, pz,transparency)
Kubisch (px,py, pz,transparency)
#end

#include "Film.inc"
