all: love

love:
	zip -9 -q -r game.love .
war:
	@echo "Error: no task for 'war' did you mean 'love'?"
windows:
	cat build/love.exe game.love > ProjectSeshat.exe
