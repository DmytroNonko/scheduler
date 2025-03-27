1. Run project:
```bash
make up
```
---
2. Enter php container: 
```bash
make bash
```
---
3. Run migrations:
```bash
bin/console doctrine:migrations:migrate
```
---
4. Load fixtures:
```bash
bin/console doctrine:fixtures:load --purge-with-truncate
```
---
5. Run schedule generation:
```bash
bin/console schedule:generate --from=2025-03-25 --to=2025-04-12
```
