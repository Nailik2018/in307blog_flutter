# in307blog_flutter

A new Flutter project.

## Installation Backend

```
host file anpassen
C:\Windows\System32\drivers\etc\hosts
127.0.0.1 blog_mysql_container
```

cd .\in307blog_backend\
```bash
docker-compose up -d
```

Aufruf phpmyadmin: http://localhost:8080/
```
Benutername:
blog
Passwort:
blog
```

```
Die Daten in data.sql in phpmyadmin importieren oder kopieren
in307blog_flutter\in307blog_backend\src\sql\data.sql

Aufruf Backend: http://localhost:3000/api
```

```
Achtung in lib/services/blog_service.dart
Eigene IP Adresse eingeben (localhost oder 127.0.0.1 funktioniert nicht) Zeile 14
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

