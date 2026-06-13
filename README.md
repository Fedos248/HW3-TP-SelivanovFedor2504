# HW.

## Как запускать

права на запуск скрипта:

chmod +x run.sh


команды:  
./run.sh build_generator - собрать образ генератора  
./run.sh run_generator - сгенерировать данные  
./run.sh build_reporter - собрать образ аналитика  
./run.sh run_reporter - сделать HTML-отчет  
./run.sh report_server - запустить веб-сервер Nginx для просмотра отчета  

доп команды:  
./run.sh create_local_data - запуск генератора локально на хосте  
./run.sh structure - показать структуру файлов проекта  
./run.sh clear_data - удалить все сгенерированные файлы из папки data  
./run.sh inside_generator и ./run.sh inside_reporter - посмотреть файлы изнутри контейнеров  

## Как открыть отчет в Codespaces

./run.sh build_generator && ./run.sh run_generator  
./run.sh build_reporter && ./run.sh run_reporter  
./run.sh report_server  

Селиванов Фёдор Максимович 2504
