## Build

```
    sudo docker build -t verice .
```

## Run

```
    sudo docker run       \
        --name verice     \
        --hostname verice \
        --publish 2222:22 \
        --workdir /home/an9wer \
        --mount type=bind,source=$(pwd)/..,target=/home/an9wer/verice \
        -it verice /bin/bash
```
