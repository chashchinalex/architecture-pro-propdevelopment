## РОЛИ И ПРАВА
| Роль              | Права роли                                                                                           | Группы пользователей              |
|-------------------|------------------------------------------------------------------------------------------------------|-----------------------------------|
| **viewer**        | Просмотр ресурсов (`get`, `list`, `watch`) для pods, deployments, services, ingresses, configmaps, secrets (только чтение), namespaces, nodes | finance-viewers, marketing-viewers, rnd-viewers |
| **configurator**  | Управление приложениями (`get`, `list`, `watch`, `create`, `update`, `patch`, `delete`) для pods, deployments, jobs, services, configmaps, ingresses, HPA; secrets — только чтение | finance-configurators, marketing-configurators, rnd-configurators |
| **secrets-privileged** | Полный доступ (`get`, `list`, `watch`, `create`, `update`, `patch`, `delete`) к secrets и configmaps в namespaces | platform-secrets |
| **ns-admin**      | Полный доступ ко всем ресурсам в пределах namespace (аналог admin-ролей на уровне ns)                 | finance-admins, marketing-admins, rnd-admins |


## Огранизация по namespaces

- `finance`
- `marketing`
- `rnd`

Доступ предоставляется группам по схеме «роль × namespace», например:
- `finance-viewers` ↔ RoleBinding к ClusterRole `viewer` в ns `finance`
- `rnd-configurators` ↔ RoleBinding к ClusterRole `configurator` в ns `rnd`
- `platform-secrets` ↔ RoleBinding к ClusterRole `secrets-privileged` во **всех** нужных namespaces

## Пользователи (примеры)

Будут созданы минимум два пользователя:

- **alice**: группы `finance-viewers` (чтение в `finance`)
- **bob**: группы `rnd-configurators` (конфигурирование приложений в `rnd`)

(опционально) **charlie**: группа `platform-secrets` (привилегии на работу с секретами; доступ задаётся RoleBinding-ами в нужных namespaces).