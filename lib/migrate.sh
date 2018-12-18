CLI::router::migrate(){
    echo haa
}

CLI::args::migrate(){
    while getopts "${OPTS}" arg; do
        case "${arg}" in
            s) _run="echo"                                                  ;;
            v) set -v                                                       ;;
            x) set -x                                                       ;;
            e) set -ve                                                      ;;
            h) _quit 0 "$HELP"                                              ;;
            ?) _quit 1 "Invalid Argument: $USAGE"                           ;;
            *) _quit 1 "$USAGE"                                             ;;
        esac
    done
    shift $((OPTIND - 1))
}
