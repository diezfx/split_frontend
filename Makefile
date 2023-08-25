run: 
	flutter run -d macos --dart-define-from-file=env/dev.json
browser: 
	flutter run -d chrome --web-port=3000 --dart-define-from-file=env/dev.json

lint:
	flutter analyze