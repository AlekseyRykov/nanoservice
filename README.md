# Тanoservice

## Инструкция по запуску
Склонировать репозиторий
```
git clone git@github.com:AlekseyRykov/nanoservice.git
```
Используя bundler установить все зависимости
```
bundle install
```
Запустить миграцию
```
rake db:migrate
```
Запустить redis
* Под windows - https://github.com/ServiceStack/redis-windows
```
redis-server.exe redis.windows.conf
```
* Под linux - https://redis.io/topics/quickstart
```
redis-server
```
Запустить реилс в режиме development
```
bundle exec rails s
```
Запустить sidekiq
```
bundle exec sidekiq
```
Пройти по адресу
```
http://localhost:3000
```