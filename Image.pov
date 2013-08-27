camera{ location  <0.0 , 0.0 , -3.5>
        look_at   <0.0 , 0.0 ,  1.0>
        right x*image_width/image_height
        angle 75 
	rotate <0,10*sin(clock*6.283185307179586),10*sin(clock*6.283185307179586)>
}

light_source{
	<-800,1500,-2000> 
	color White
	rotate <0,10*sin(clock*6.283185307179586),10*sin(clock*6.283185307179586)>
	}

#declare transparency=0;

Elementarzelle(0,0,0,0)
