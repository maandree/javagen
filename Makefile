all: exceptiongenerator propertygenerator


exceptiongenerator:
	mkdir META-INF
	javac -cp . -s src -d . src/se/kth/maandree/javagen/*.java

	echo -e 'Manifest-Version: 1.0\nCreated-By: Mattias Andrée\nMain-Class: se.kth.maandree.javagen.ExceptionGenerator' > META-INF/MANIFEST.MF
	jar -cfm javagen.exception.jar META-INF/MANIFEST.MF se/kth/maandree/javagen/ExceptionGenerator.class
	echo "java -jar "$$\0".jar" > javagen.exception

	rm -r META-INF se
	rm *~ 2>/dev/null || echo -n


propertygenerator:
	mkdir META-INF
	javac -cp . -s src -d . src/se/kth/maandree/javagen/*.java

	echo -e 'Manifest-Version: 1.0\nCreated-By: Mattias Andrée\nMain-Class: se.kth.maandree.javagen.PropertyGenerator' > META-INF/MANIFEST.MF
	jar -cfm javagen.property.jar META-INF/MANIFEST.MF se/kth/maandree/javagen/PropertyGenerator.class
	echo "java -jar "$$\0".jar" > javagen.property

	rm -r META-INF se
	rm *~ 2>/dev/null || echo -n


install:
	install -d "${DESTDIR}/usr/bin"
	install -m 755 javagen.* "${DESTDIR}/usr/bin"


uninstall:
	unlink ${DESTDIR}/usr/bin/javagen.exception
	unlink ${DESTDIR}/usr/bin/javagen.exception.jar
	unlink ${DESTDIR}/usr/bin/javagen.property
	unlink ${DESTDIR}/usr/bin/javagen.property.jar


clean:
	unlink javagen.exception
	unlink javagen.exception.jar
	unlink javagen.property
	unlink javagen.property.jar
