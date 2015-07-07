PREFIX=/usr
BIN=/bin
DATA=/share
LICENSES=$(DATA)/licenses
PKGNAME=javagen


all: exceptiongenerator propertygenerator


obj/%/se/kth/maandree/javagen/%.class: src/se/kth/maandree/javagen/%.java
	@mkdir -p obj/$*
	javac -cp obj/$* -s src -d obj/$* $<

obj/%/META-INF/MANIFEST.MF: %.manifest
	@mkdir -p obj/$*/META-INF
	cp $< $@

obj/%/javagen.jar: obj/%/META-INF/MANIFEST.MF obj/%/se/kth/maandree/javagen/%.class
	@mkdir -p obj/$*
	cd obj/$* && jar -cfm javagen.jar META-INF/MANIFEST.MF se/kth/maandree/javagen/$*.class

obj/%.jar: obj/%/javagen.jar
	echo '#!/usr/bin/java -jar' > $@
	cat $< >> $@
	chmod a+x $@

exceptiongenerator: bin/javagen.exception
bin/javagen.exception: obj/ExceptionGenerator.jar
	@mkdir -p bin
	cp $< $@

propertygenerator: bin/javagen.property
bin/javagen.property: obj/PropertyGenerator.jar
	@mkdir -p bin
	cp $< $@


install:
	install -d "$(DESTDIR)$(PREFIX)$(BIN)"
	install -m 755 "javagen.exception" "$(DESTDIR)$(PREFIX)$(BIN)"
	install -m 755 "javagen.property" "$(DESTDIR)$(PREFIX)$(BIN)"
	install -d "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"
	install -m 644 "doc/ExceptionGenerator" "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"
	install -d "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"
	install -m 644 LICENSE COPYING "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"


uninstall:
	-rm -- "$(DESTDIR)$(PREFIX)$(BIN)/javagen.exception"
	-rm -- "$(DESTDIR)$(PREFIX)$(BIN)/javagen.property"
	-rm -r "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"


clean:
	-rm obj bin


.PHONY: all exceptiongenerator propertygenerator install uninstall clean

