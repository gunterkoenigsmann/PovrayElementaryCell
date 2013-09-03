#### A target that creates all moving images at once. ########################
Films_PNG= $(patsubst %.pov,Film_%.png,*.pov)
Cells_PNG= $(patsubst %.pov,Cell_%.png,*.pov)
Films_WEBM=$(patsubst %.pov,Film_%.webm,*.pov)
Cells_WEBM=$(patsubst %.pov,Cell_%.webm,*.pov)
Films_FLV= $(patsubst %.pov,Film_%.flv,*.pov)
Cells_FLV= $(patsubst %.pov,Cell_%.flv,*.pov)
Films_GIF= $(patsubst %.pov,Film_%.gif,*.pov)
Cells_GIF= $(patsubst %.pov,Cell_%.gif,*.pov)
all: $(Films_PNG) $(Cells_PNG) $(Films_WEBM) $(Cells_WEBM) $(Films_FLV) $(Cells_FLV) $(Films_GIF) $(Cells_GIF)

#### 1st Step: Render the images using Povray ################################
Hires/Film_%002.png:%.pov
	mkdir -p Hires
	povray Film.ini +I $< +OFilm_$(patsubst %.pov,%,$<).png +K`echo "scale=4;$$i/250"|bc`
	mv Film_$(patsubst %.pov,%,$<)*.png Hires

Hires/Cell_%02.png:%.pov
	echo $(PNGs) 
	mkdir -p Hires
	povray Cell.ini +I $< +OCell_$(patsubst %.pov,%,$<).png +K`echo "scale=4;$$i/250"|bc`
	mv Cell_$(patsubst %.pov,%,$<)*.png Hires

#### 2nd Step: Scale the images. #############################################
#### Rendering hi-res images and scaling them afterwards manually adds
#### antialiassing to the images.
#### 
#### We can't use povray's antialiassing instead:
#### For apng files we replace all black pixels by transparency
#### which (since the background is black) changes the background color
#### to "transparent".
#### If povray would use antialiassing during the rendering phase this would
#### result in pixels at the border of our objects not being partially
#### transparent but partially black.
Antialias/%002.png:Hires/%002.png
	mkdir -p Antialias
	cd Hires&&for i in $(patsubst Antialias/%002.png,%,$@)???.png; do convert $$i -transparent black -resize 33% ../Antialias/$$i;done
Antialias/%02.png:Hires/%02.png
	mkdir -p Antialias
	cd Hires&&for i in $(patsubst Antialias/%02.png,%,$@)??.png;   do convert $$i -transparent black -resize 33% ../Antialias/$$i;done


#### 3rd Step: Assemble the files to a film. #################################


# Animated PNG: Allows pixels to be partially transparent and allows
# for infinite loops. But creates big files the internet explorer
# cannot animate.
%.png: Antialias/%002.png
	apngasm $@  $(patsubst %.png,Antialias/%???.png,$@) 1 25
%.png: Antialias/%02.png
	apngasm $@  $(patsubst %.png,Antialias/%??.png,$@) 1 25

# Flash Video: Somewhat legacy.
%.flv: Antialias/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0
%.flv: Antialias/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0

# Webm: HTML5 but does not support infinite loops at the file's sie.
%.webm: Antialias/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0 -qscale 5 -pass 1
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0 -qscale 5 -pass 2
%.webm: Antialias/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0 -qscale 5 -pass 1
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0 -qscale 5 -pass 2

# Gif: Partial support for transparencies but results in big files.
%.gif: Antialias/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0
%.gif: Antialias/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0

# Tell Make which files aren't to be automatically deleted on
# exit.
PNGs= $(patsubst %.pov,Hires/Cell_%02.png,$(wildcard *.pov))
PNGs+=$(patsubst %.pov,Hires/Cell_%002.png,$(wildcard *.pov))
PNGs+=$(patsubst %.pov,Antialias/Cell_%02.png,$(wildcard *.pov))
PNGs+=$(patsubst %.pov,Antialias/Cell_%002.png,$(wildcard *.pov))
.PRECIOUS:  $(PNGs) 
