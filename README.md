# Running

Using docker compose is the recommended option, just git clone this repo, cd into the directory and run `docker compose up -d`

Using docker command

```bash
docker run -d --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0

# If on apple silicon or arm
docker run -d --platform linux/amd64 --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0
```
