#macro Atom (px,py,pz,r,g,b,transparency)
sphere{ <px,py,pz>, 0.05*(1-transparency)
        texture{
          pigment{ color rgb<r,g,b> transmit transparency }
          finish { phong (1-transparency) }
        }
      }
#end

#macro Kubisch (px,py, pz,transparency)
Atom( .5+px, .5+py, .5+pz,.25,1,0.1,transparency)
Atom( .5+px, .5+py,-.5+pz,.25,1,0.1,transparency)
Atom( .5+px,-.5+py, .5+pz,.25,1,0.1,transparency)
Atom( .5+px,-.5+py,-.5+pz,.25,1,0.1,transparency)
Atom(-.5+px, .5+py, .5+pz,.25,1,0.1,transparency)
Atom(-.5+px, .5+py,-.5+pz,.25,1,0.1,transparency)
Atom(-.5+px,-.5+py, .5+pz,.25,1,0.1,transparency)
Atom(-.5+px,-.5+py,-.5+pz,.25,1,0.1,transparency)
#end

#macro KRZ (px,py, pz,transparency)
Kubisch (px,py, pz,transparency)
Atom(px,py,pz,1,.3,.01,transparency)
#end

#macro KFZ (px,py, pz,transparency)
Kubisch (px,py, pz,transparency)
Atom(-.5+px,    py,    pz,.65,.6,.1,transparency)
Atom( .5+px,    py,    pz,.65,.6,.1,transparency)
Atom(    px,-.5+py,    pz,.65,.6,.1,transparency)
Atom(    px, .5+py,    pz,.65,.6,.1,transparency)
Atom(    px,    py,-.5+pz,.65,.6,.1,transparency)
Atom(    px,    py, .5+pz,.65,.6,.1,transparency)
#end
