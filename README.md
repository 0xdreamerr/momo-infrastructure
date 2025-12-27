# Momo Store

## Ссылки

1. Репозиторий с кодом: https://github.com/0xdreamerr/momo-store
2. Магазин: http://адрес_ВМ/momo-store/  
3. Grafana: http://адрес_ВМ/grafana  
4. Prometheus: http://адрес_ВМ/  
5. Nexus: https://nexus.praktikum-services.tech/repository/std-int-009-04-helm/

---

## Развёртывание приложения

### Шаги
1. Запустить корневой конвейер в репозитории momo-store. Он соберет docker-образ и в случае успеха поместит в GitLab Container Registry новый образ с актуальной версией.

2. Перейти в репозиторий momo-infrastructure и запустить конвейер с указанием параметра IMAGE_TAG, взятый из Container Registry. (Пример: 1.0.2579081)

## Устройство репозитория

Проект разделён на два репозитория:
1. Код приложения (momo-store)  
Содержит исходный код, Dockerfile и .gitlab-ci.yml для CI.

2. Инфраструктура (momo-infrastructure)  
Содержит Helm-чарты для деплоя приложений,
terraform-конфигурацию для создания ВМ, ansible для создания Kubernetes-кластера, манифесты Kubernetes и чарты для сервисов мониторинга/логирования.

## Развертывание инфраструктуры

### 1. Создание ВМ  
Перейти в папку terraform, поместить желаемое состояние в файл terraform.tfvars (см. пример):
```
instances = {
  kube-master = {
    cores  = 4
    memory = 8
    role   = "master"
  }

  kube-worker-1 = {
    cores  = 2
    memory = 4
    role   = "worker"
  }

  kube-worker-2 = {
    cores  = 2
    memory = 4
    role   = "worker"
  }
}
```  
Выполнить команды : 
```
terraform init
```
```
terraform plan
```
```
terraform apply 
```
```
terraform output -raw ansible_inventory > ../ansible/inventory.ini
```
### 2. Настройка кластера  
Перейти в папку ansible и выполнить следующую команду:
```
ansible-playbook -i inventory.ini site.yml
```
В результате выполнения создается кластер k8s.

### 3. Запуск чартов  
Настроив ~/.kube/config для подключения к кластеру, выполнить команды для установки чарта сервиса:
```
helm install momo-store helm
```
Далее, выполнить аналогичную команду для Prometheus/Grafana:
```
helm install prometheus prometheus 
```
### 4. Готово!

## Правила внесения изменений в инфраструктуру

### Изменение кол-ва ВМ  
Добавить/убрать запись в terraform.tfvars (согласно примеру).

### Изменение манифестов
Редактировать шаблоны/значения в папке helm, запушить изменения и вызвать конвейер в репозитории momo-infrastructure.

## Релизный цикл приложения и правила версионирования

Backend и frontend образы имеют тэг: *1.0.${CI_PIPELINE_ID}*  
Helm-чарты используют ту же версию, что и образы.  
Версия чарта обновляется при запуске CD конвейера.  
Новая версия приложения деплоится после успешной сборки и публикации артефактов в Nexus.
