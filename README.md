
```bash
docker images | x ja '!c(1, "}"){ next; } g("SIZE")<4096{ p() } }' | docker

docker images | x ja 'dict(1)&&g("SIZE")<4096{ p(); }' | docker rmi

```
