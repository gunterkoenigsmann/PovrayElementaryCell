#if (clock<1.5)

camera{ location  <0.0 , 0.0 , -3.5>
        look_at   <0.0 , 0.0 ,  1.0>
        right x*image_width/image_height
        angle 75 
	rotate <0,clock*360,clock*180>
}

light_source{
	<-800,1500,-2000> 
	color White
	rotate <0,clock*360,clock*180>
	}

#declare transparency=0;

#if (clock>.9)
#declare transparency=(clock-.9)*10;
#end

#if (clock<.6)
#declare transparency=1-((clock-.5)*10);
#end

#if (clock<.5) 
#declare transparency=1;
#end

#if (clock>=.5)
#declare x_pos=-20;
#while (x_pos<21)
#declare y_pos=-20;
#while (y_pos<21)
#declare z_pos=-20;
#while (z_pos<21)

Elementarzelle(x_pos,y_pos,z_pos,transparency)

#declare z_pos=z_pos+1;
#end
#declare y_pos=y_pos+1;
#end
#declare x_pos=x_pos+1;
#end
#end
 
#end

Elementarzelle(0,0,0,0)

#if (clock>1.5)

camera{ location  <0.0 , 0.0 , -4.0>
        look_at   <0.0 , 0.0 ,  0.0>
        right <1,0,0>
	up    <0,1,0>
        angle 20.1
	rotate <7*sin(clock*6.283185307179586),3.5*cos(clock*6.283185307179586),0>
}

light_source{
	<-800,1500,-2000> 
	color White
	rotate <7*sin(clock*6.283185307179586),3.5*cos(clock*6.283185307179586),0>
	}

#declare transparency=0;

#end