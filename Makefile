all: love

love:
	zip -9 -q -r game.love .
war:
	@echo "Error: no task for 'war' did you mean 'love'?"
windows:
	mkdir -p projectseshat-win64
	cat build/love-0.9.1-win64/love.exe game.love > projectseshat-win64/ProjectSeshat.exe
	cp build/love-0.9.1-win64/*.dll projectseshat-win64
	zip -r projectseshat-win64.zip projectseshat-win64
	mv projectseshat-win64.zip distributables/
	rm -rf projectseshat-win64
osx:
	mkdir -p projectseshat-osx
	cp -r build/love.app projectseshat-osx/ProjectSeshat.app
	cp game.love projectseshat-osx/ProjectSeshat.app/Contents/Resources/
	zip -r projectseshat-osx.zip projectseshat-osx
	mv projectseshat-osx.zip distributables/
	rm -rf projectseshat-osx

