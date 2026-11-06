# Kranem Git Manager runner image.
#
# Wings starts this image as a throwaway container with the server's files mounted at
# /mnt/server and runs the extension's script with `/bin/sh /mnt/script/script.sh`.
# Wings passes the script as the container *command*, so this image must not define an
# ENTRYPOINT (that is why images like alpine/git, whose entrypoint is `git`, cannot be used).
FROM alpine:3.22

RUN apk add --no-cache \
        ca-certificates \
        git \
        git-lfs \
        openssh-client \
        findutils \
        coreutils \
    && git lfs install --system --skip-repo \
    && git --version && ssh -V

LABEL org.opencontainers.image.title="kranem-git-runner" \
      org.opencontainers.image.description="Runner image for the Kranem Git Manager Calagopus extension" \
      org.opencontainers.image.licenses="MIT"

# Default command only matters when the image is run by hand; Wings overrides it.
CMD ["/bin/sh"]
