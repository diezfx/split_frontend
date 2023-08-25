run: 
	flutter run -d macos
browser: 
	flutter run -d chrome --web-port=3000


generate:
	dart run build_runner build