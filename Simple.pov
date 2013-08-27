#version 3.6;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.1 diffuse 0.9 }}
#include "colors.inc"
#include "textures.inc"

camera{ location  <0.0 , 0.0 , -3.5>
        look_at   <0.0 , 0.0 ,  1.0>
        right x*image_width/image_height
        angle 75 
	rotate <0,clock*360,clock*180>
}

light_source{<-800,1500,-2000> color White}

sphere{ <0,0,0>, 1
        texture{
          pigment{ color rgb<.25,1,0.1> transmit 1 }
          finish { phong 1 }
        }
      }
