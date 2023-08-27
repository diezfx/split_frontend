run: 
	flutter run -d macos --dart-define=ENVIRONMENT=local
browser: 
	flutter run -d chrome --web-port=3000 --dart-define=ENVIRONMENT=local --web-renderer html
lint:
	dart analyze
fmt:
	dart format .
generate:
	dart run build_runner build