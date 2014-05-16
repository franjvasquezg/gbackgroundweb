# Makefile

SHELL := sh -e

SCRIPTS = "debian/postinst configure" "debian/postrm purge"

all: build

test:

	# Aquí se realizan diversas pruebas para segurar que
	# todo lo que se realice con el Makefile salga bien
	# (compilación, instalación, desinstalación, entre otros)
	# Una práctica común es la de correr los scripts en modo
	# "de prueba" para comprobar que están bien escritos.

	@echo -n "\n===== Comprobando posibles errores de sintaxis en los scripts de mantenedor =====\n\n"

	@for SCRIPT in $(SCRIPTS); \
	do \
		echo -n "$${SCRIPT}\n"; \
		bash -n $${SCRIPT}; \
	done

	@echo -n "\n=================================================================================\nHECHO!\n\n"

build:

	# Aquí se realizan todos los procedimientos relativos a
	# generación de archivos que necesitan compilarse.
	# Por ejemplo, una conversión de imágenes PNG > JPG,
	# Debe ir aquí. La compilación de binarios C++, debe ir
	# aquí. Entre otros ejemplos. Todos los programas que
	# utilices acá, debes incluirlas como dependencias de
	# compilación en el campo "Build-Depends" del archivo
	# debian/control.
	# Si no hay nada que compilar (por ejemplo, si tu
	# programa está hecho en bash o PHP) puedes dejar éste
	# espacio en blanco.
	#
	# EJEMPLO:
	# convert ejemplo.png ejemplo.jpg

	@echo "Nada para compilar!"

install:

	# Aquí se instala el software. Para ello se mueven los
	# archivos necesarios a los lugares destinados para su
	# correcto funcionamiento. Es necesario crear todos los
	# directorios utilizados. Recuerda que el Makefile se
	# utiliza en la creación de la estructura de archivos 
	# del paquete.
	# Debes anteponer la variable $(DESTDIR) en todos los
	# destinos:
	# Si haces "make install", la variable $(DESTDIR) es
	# removida por no tener valor y el programa se instala
	# en el sistema tal cual.
	# Si utilizas el Makefile en el empaquetamiento, puedes
	# asignarle el valor DESTDIR=$(CURDIR)/debian/nombre-p/
	# para que sea el contenido del paquete.
	#
	
	mkdir -p $(DESTDIR)/etc/xdg/autostart/
	mkdir -p $(DESTDIR)/usr/bin/
	mkdir -p $(DESTDIR)/usr/share/gbackground-web/
	mkdir -p $(DESTDIR)/usr/share/pixmaps/
	mkdir -p $(DESTDIR)/usr/share/menu/	
	mkdir -p $(DESTDIR)/usr/share/applications/


	cp -r etc/xdg/autostart/gbackgroundweb.desktop $(DESTDIR)/etc/xdg/autostart/
	cp -r bin/gbackground_web $(DESTDIR)/usr/bin/
	cp -r share/gbackground-web/canaima-vector-miniatura.png $(DESTDIR)/usr/share/gbackground-web/
	cp -r share/gbackground-web/gbackgroundD_web $(DESTDIR)/usr/share/gbackground-web/
	cp -r share/gbackground-web/gbackground_web.glade $(DESTDIR)/usr/share/gbackground-web/
	cp -r share/icon/gbackgroundweb.svg $(DESTDIR)/usr/share/gbackground-web/
	ln -s /usr/share/gbackground-web/gbackgroundweb.svg $(DESTDIR)/usr/share/pixmaps/gbackgroundweb.svg
	cp -r AUTHORS COPYING LICENSE README THANKS TODO $(DESTDIR)/usr/share/gbackground-web/
	cp -r share/menu/gbackgroundweb $(DESTDIR)/usr/share/menu/
	cp -r share/gbackgroundweb.desktop $(DESTDIR)/usr/share/applications/	
	
	
uninstall:

# Aquí se deshace lo que se hizo en el install, borrando exactamente lo que
# se creó en el install

	rm -rf $(DESTDIR)/etc/xdg/autostart/gbackgroundweb.desktop
	rm -rf $(DESTDIR)/usr/bin/gbackground_web
	rm -rf $(DESTDIR)/usr/share/gbackground-web/
	rm -rf $(DESTDIR)/usr/share/pixmaps/
	rm -rf $(DESTDIR)/usr/share/menu/
	rm -rf $(DESTDIR)/usr/share/applications/gbackgroundweb.desktop
	rm -rf $(DESTDIR)/etc/skel/.local/usr/share/applications/alacarte-made.desktop

clean:

# Borrar todo lo hecho en build para que quede todo como estaba antes de la
# compilación

reinstall: uninstall install
