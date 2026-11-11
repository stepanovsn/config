docker run \
    --rm \
    -it \
    --init \
    --network bridge \
    --pids-limit=512 \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    --name opencode-session \
    --detach-keys="ctrl-^" \
    -u hostuser \
    -v /home/${USER}/.config/opencode:/home/hostuser/.config/opencode:rw \
    -v /home/${USER}/.config/opencode/share:/home/hostuser/.local/share/opencode:rw \
    -v /home/${USER}/.config/opencode/local_settings:/etc/opencode:rw \
    -v /home/${USER}/.config/regconfig/recipes/opencode:/home/${USER}/.config/regconfig/recipes/opencode:ro \
    -v /home/${USER}/dev:/home/${USER}/dev:rw \
    -w /home/${USER}/dev \
    opencode
