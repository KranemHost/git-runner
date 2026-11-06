# kranem-git-runner

Container image used by the **Git Manager** Calagopus extension (`hu.kranem.gitmanager`).
Every git action runs as a short-lived container on the node with the server's files at
`/mnt/server`: git, git-lfs and the OpenSSH client, nothing else.

## Publish

Push this folder to a GitHub repository (e.g. `kranem-git-runner`). The workflow builds
`linux/amd64` and `linux/arm64` and pushes:

- `ghcr.io/<owner>/kranem-git-runner:1`
- `ghcr.io/<owner>/kranem-git-runner:latest`

It also rebuilds weekly so Alpine/git security fixes are picked up.

Then **make the package public** (GitHub → Packages → kranem-git-runner → Package settings →
Change visibility), otherwise Wings cannot pull it without registry credentials.

Finally set the image in the panel: Admin → Extensions → Git Manager → Runner image.

## Build by hand

```sh
docker build -t ghcr.io/<owner>/kranem-git-runner:1 .
docker push ghcr.io/<owner>/kranem-git-runner:1
```

## Why not alpine/git?

Wings runs the script as the container command (`/bin/sh /mnt/script/script.sh`). Images
with an `ENTRYPOINT` (alpine/git uses `git`) would turn that into `git /bin/sh …`.
