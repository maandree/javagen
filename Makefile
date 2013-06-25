PREFIX=/usr
BIN=/bin
DATA=/share
LICENSES=$(DATA)/licenses
PKGNAME=javagen


all: exceptiongenerator propertygenerator


exceptiongenerator:
	mkdir META-INF
	javac -cp . -s src -d . src/se/kth/maandree/javagen/*.java

	echo -e 'Manifest-Version: 1.0\nCreated-By: Mattias Andrée\nMain-Class: se.kth.maandree.javagen.ExceptionGenerator' > META-INF/MANIFEST.MF
	jar -cfm javagen.exception.jar META-INF/MANIFEST.MF se/kth/maandree/javagen/ExceptionGenerator.class
	echo 'java -jar "$$0".jar' > javagen.exception

	rm -r META-INF se
	-rm *~ 2>/dev/null


propertygenerator:
	mkdir META-INF
	javac -cp . -s src -d . src/se/kth/maandree/javagen/*.java

	echo -e 'Manifest-Version: 1.0\nCreated-By: Mattias Andrée\nMain-Class: se.kth.maandree.javagen.PropertyGenerator' > META-INF/MANIFEST.MF
	jar -cfm javagen.property.jar META-INF/MANIFEST.MF se/kth/maandree/javagen/PropertyGenerator.class
	echo 'java -jar "$$0".jar' > javagen.property

	rm -r META-INF se
	-rm *~ 2>/dev/null


install:
	install -d "$(DESTDIR)$(PREFIX)$(BIN)"
	install -m 755 "javagen."* "$(DESTDIR)$(PREFIX)$(BIN)"
	install -d "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"
	install -m 644 "doc/ExceptionGenerator" "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"
	install -d "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"
	install -m 644 LICENSE COPYING "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"


uninstall:
	-rm -- "$(DESTDIR)$(PREFIX)$(BIN)/javagen."{exception,property}{,.jar}
	-rm -r "$(DESTDIR)$(PREFIX)$(DATA)/doc/$(PKGNAME)"


clean:
	-rm javagen.{property,exception}{,.jar} 2>/dev/null
