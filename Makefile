all:
	elm make --output out/main.js src/Main.elm
	cp static/* out/

