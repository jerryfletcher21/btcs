#!/bin/sh

info=$(cat << EOF
install.sh install-data|install-script|uninstall-data|uninstall-script
EOF
)

local_home="${XDG_LOCAL_HOME:-$HOME/.local}"
data_home="${XDG_DATA_HOME:-$local_home/share}"
bin_home="${XDG_BIN_HOME:-$local_home/bin}"

btcs_install_data() {
    project_home="$(dirname "$0")"

    if [ ! -d "$data_home" ]; then
        mkdir -p "$data_home"
    fi

    btcs_home="$data_home/btcs"
    if [ ! -d "$btcs_home" ]; then
        mkdir -p "$btcs_home"
    fi
    btcs_script_home="$btcs_home/scripts"
    if [ -d "$btcs_script_home" ]; then
        rm -rf "$btcs_script_home"
    fi
    if [ ! -d "$btcs_script_home" ]; then
        mkdir -p "$btcs_script_home"
    fi
    if ! cp -f "$project_home/btcs" "$btcs_home"; then
        echo "error: installing btcs script" >&2
        exit 1
    fi
    if
        ! find "$project_home/scripts" \
            -type f \
            -exec cp -f "{}" "$btcs_script_home" \; >/dev/null
    then
        echo "error: installing scripts" >&2
        exit 1
    fi

    echo "btcs data successfully installed"
}

btcs_install_script() {
    if [ -z "$BTC_BIN" ]; then
        echo "error: set BTC_BIN" >&2
        exit 1
    fi
    # shellcheck disable=SC2086
    if ! command -v $BTC_BIN >/dev/null 2>&1; then
        echo "error: $BTC_BIN is not a command" >&2
        exit 1
    fi

    if [ -z "$BTCS_NAME" ]; then
        echo "error: set BTCS_NAME" >&2
        exit 1
    fi
    if printf "%s\n" "$BTCS_NAME" | grep "[[:space:]]" >/dev/null 2>&1; then
        echo "error: $BTCS_NAME should not contain spaces" >&2
        exit 1
    fi

    if [ ! -d "$bin_home" ]; then
        mkdir -p "$bin_home"
    fi

    btcs_install_file="$bin_home/$BTCS_NAME"
    if ! touch "$btcs_install_file"; then
        echo "error: creating $btcs_install_file" >&2
        exit 1
    fi
    if ! chmod u+x "$btcs_install_file"; then
        echo "error: setting permission on $btcs_install_file" >&2
        exit 1
    fi
    btcs_install_file_content=$(cat << EOF
#!/bin/sh

export BTC_BIN="$BTC_BIN"

"\${XDG_DATA_HOME:-\${XDG_LOCAL_HOME:-\$HOME/.local}/share}/btcs/btcs" "\$@"
EOF
    )
    printf "%s\n" "$btcs_install_file_content" > "$btcs_install_file"

    echo "btcs script $BTCS_NAME successfully installed"
}

btcs_uninstall_data() {
    btcs_home="$data_home/btcs"
    if [ -e "$btcs_home" ]; then
        if ! rm -rf "$btcs_home"; then
            echo "error: removing $btcs_home" >&2
            exit 1
        fi
        echo "btcs data successfully uninstalled"
    else
        echo "btcs data was not installed"
    fi
}

btcs_uninstall_script() {
    if [ -z "$BTCS_NAME" ]; then
        echo "error: set BTCS_NAME" >&2
        exit 1
    fi
    if printf "%s\n" "$BTCS_NAME" | grep "[[:space:]]" >/dev/null 2>&1; then
        echo "error: $BTCS_NAME should not contain spaces" >&2
        exit 1
    fi

    btcs_install_file="$bin_home/$BTCS_NAME"
    if [ -f "$btcs_install_file" ]; then
        if ! rm -f "$btcs_install_file"; then
            echo "error: removing $btcs_install_file" >&2
            exit 1
        fi
        echo "$BTCS_NAME successfully uninstalled"
    else
        echo "$BTCS_NAME was not installed"
    fi
}

if [ "$#" -lt 1 ]; then
    echo "error: insert action" >&2
    exit 1
fi
action="$1"
shift 1

case "$action" in
    -h|--help)
        echo "$info"
        exit 0
    ;;
    install-data)
        btcs_install_data "$@"
    ;;
    install-script)
        btcs_install_script "$@"
    ;;
    uninstall-data)
        btcs_uninstall_data "$@"
    ;;
    uninstall-script)
        btcs_uninstall_script "$@"
    ;;
    *)
        echo "error: action $action not recognized" >&2
        exit 1
    ;;
esac
