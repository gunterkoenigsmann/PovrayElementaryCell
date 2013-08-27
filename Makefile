Hires/Film_%002.png:%.ini
	mkdir -p Hires
	povray +I $< +OFilm_$(patsubst %.ini,%,$<).png +K`echo "scale=4;$$i/250"|bc` Film.ini
	mv Film_$(patsubst %.ini,%,$<)*.png Hires;done

Hires/Cell_%02.png:%.ini
	mkdir -p Hires
	povray +I $< +OCell_$(patsubst %.ini,%,$<).png +K`echo "scale=4;$$i/250"|bc` Cell.ini
	mv Cell_$(patsubst %.ini,%,$<)*.png Hires;done

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
