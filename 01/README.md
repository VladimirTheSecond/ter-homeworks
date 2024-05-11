# Домашнее задание к занятию «Введение в Terraform»

### Чек-лист готовности к домашнему заданию

1. Скачайте и установите **Terraform** версии =1.5.Х (версия 1.6 может вызывать проблемы с Яндекс провайдером) . Приложите скриншот вывода команды ```terraform --version```.

Я решил похулиганить и установил последнюю версию с использованием VPN. Возможно я пожалею об этом позже, но версия 1.5 есть если что на ноутбуке, так что попробуем.
Вывод команды:
```vladimir@vladimir-desktop:~/Documents/netology/ter-homeworks/01$ terraform --version```
```Terraform v1.8.3-dev```
```on linux_amd64```

```Your version of Terraform is out of date! The latest version```
```is 1.8.3. You can update by downloading from https://www.terraform.io/downloads.html```

Скриншот так же будет приложен.

2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории **01/src**.
ок
3. Убедитесь, что в вашей ОС установлен docker.

```vladimir@vladimir-desktop:~/Documents/netology/ter-homeworks/01$ docker --version```
```Docker version 26.1.2, build 211e74b```

4. Зарегистрируйте аккаунт на сайте https://hub.docker.com/, выполните команду docker login и введите логин, пароль.

ок, логин в docker hub - vladimirthesecond, аналогично github
```Login Succeeded```

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте.

Применены команды:
```terraform init```
```terraform apply```

2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?

```personal.auto.tfvars```

3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.

```f"result": "ffEgsL9IQaqUNNe9"```

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

Выведено две ошибки: 
```Error: Missing name for resource```
и
```Error: Invalid resource name```
Первая ошибка вызвана тем, что у блока resource должно быть два параметра - type и name, а в файле всего один. Добавил второй параметр, name - "nginx".
Вторая ошибка вызвана опечатками - поправил "1nginx" на "nginx", в имени переменной убрал _FAKE.

5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  vladimir@vladimir-desktop:~/Documents/netology/ter-homeworks/01/src$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
63e17939673d   1d668e06f1e5   "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:9090->80/tcp   example_ffEgsL9IQaqUNNe9

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.

vladimir@vladimir-desktop:~/Documents/netology/ter-homeworks/01/src$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
8d2aeb602c2b   1d668e06f1e5   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:9090->80/tcp   hello_world_ffEgsL9IQaqUNNe9

Ключ --auto-approve пригодится, если код будет выполняться автоматизированно, без участия человека. Например, если нужно будет поставить на расписание запуск terraform, а присутствие человека невозможно или избыточно. Опасность в том, что могут примениться нежелательные изменения, которые не планировалось применять.

8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**.

vladimir@vladimir-desktop:~/Documents/netology/ter-homeworks/01/src$ cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.8.3",
  "serial": 11,
  "lineage": "b8e6e912-dcdf-c3a1-be35-9939f51f4da5",
  "outputs": {},
  "resources": [],
  "check_results": null
}

9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )

docker образ не был удалён, так как в main.tf указан параметр keep_locally = true, согласно которому команда terraform destroy не удалит образ, скачанный локально. Ссылка на документацию terraform: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
```"**keep_locally** (Boolean) If true, then the Docker **image won't be deleted on destroy operation**. . ."```
