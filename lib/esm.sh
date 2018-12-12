# a little fast esm yoconf lib

declare -A ESM
ESM['curl':'timeout']="10"

yoconf::curl(){
    local method="${1^^}" url="$2" data="$3"

    # check if all variables are set
    type::variable::set method url

    [[ -z "$data" ]] || _curl_opts="-d '$data'"
    [[ -z "${ESM['auth']}" ]] || _curl_auth="-H Authorization: ${ESM['auth']}"

    curl -s -k -X "$method" $_curl_auth $_curl_opts --connect-timeout "${ESM['curl':'timeout']}" $url
}

esm::yoconf::get(){
    local hostname="$1" service="$2"
    
    [[ -z "$3" ]] && exit
    # do it like a pro :D
    # XXX: This could avoid a lot of problems, but we will not use it
    #local -A "$3"

    # even more easyer for us, we're pro's

    local -n array="$3"

    type::variable::set hostname service || exit
    url="https://$hostname:8000/ajaxyoconf?service=$service"

    while read line
    do
        array["${line%%=*}"]="${line#*=}"
    done < <(yoconf::curl get "$url")
}

esm::yoconf::post(){
    local hostname="$1" project="$2" user="$3"

    url="https://$hostname:8000/ajaxyoconf"

    # this can't be correct.... but i will keep it, we don't know the code of lav...
    yoconf::curl post "$url" "{ project=$service&customer=$customer&host=$hostname }"
}
