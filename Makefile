Hires/Film_%002.png:%.pov
	mkdir -p Hires
	povray Film.ini +I $< +OFilm_$(patsubst %.pov,%,$<).png +K`echo "scale=4;$$i/250"|bc`
	mv Film_$(patsubst %.pov,%,$<)*.png Hires

Hires/Cell_%02.png:%.pov
	mkdir -p Hires
	povray Cell.ini +I $< +OCell_$(patsubst %.pov,%,$<).png +K`echo "scale=4;$$i/250"|bc`
	mv Cell_$(patsubst %.pov,%,$<)*.png Hires

Scaled/%002.png:Hires/%002.png
	mkdir -p Scaled
	for i in Hires/$(patsubst %002.png,%,$@).???.png; do convert $$i -transparent black -resize 33% ../Scaled/$$i.png;done

Scaled/%02.png:Hires/%02.png
	mkdir -p Scaled
	for i in Hires/$(patsubst %02.png,%,$@).???.png; do convert $$i -transparent black -resize 33% ../Scaled/$$i.png;done


%.png: Scaled/%002.png
	apngasm $@  $(wildcard $(patsubst %.png,Scaled/%*.png,%@)) 1 25
%.png: Scaled/%02.png
	apngasm $@  $(wildcard $(patsubst %.png,Scaled/%*.png,%@)) 1 25

%.flv: Hires/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0
%.flv: Hires/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0

%.webm: Hires/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0 -qscale 5 -pass 1
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0 -qscale 5 -pass 2

%.webm: Hires/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0 -qscale 5 -pass 1
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0 -qscale 5 -pass 2

%.gif: Hires/%002.png
	avconv -i  $(patsubst %002.png,%,$<)%03d.png $@ -loop 0
%.gif: Hires/%02.png
	avconv -i  $(patsubst %02.png,%,$<)%02d.png $@ -loop 0
