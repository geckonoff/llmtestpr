# llmtestpr

Автоматизация тестирования ROCm + Ollama на разных версиях Ubuntu с использованием:
- **Packer** (сборка базовых образов)
- **Terraform** (оркестрация VM на libvirt)
- **Ansible** (установка ROCm/Vulkan/Ollama и тесты)

## Структура
- `packer/` — шаблоны для сборки qcow2-образов
- `terraform/` — манифесты для запуска VM на libvirt
- `ansible/` — плейбуки для конфигурации и тестирования
- `results/` — результаты тестов в JSON/CSV
