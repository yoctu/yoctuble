# a little fast esm yoconf lib

[public:assoc] ESM
ESM['curl':'timeout']="10"

yoconf::curl(){
    [private] method="${1^^}" 
    [private] url="$2" 
    [private] data="$3"

    # check if all variables are set
    type::variable::set method url

    [[ -z "$data" ]] || _curl_opts="-d '$data'"
    [[ -z "${ESM['auth']}" ]] || _curl_auth="-H Authorization: ${ESM['auth']}"

    curl -s -k -X "$method" $_curl_auth $_curl_opts --connect-timeout "${ESM['curl':'timeout']}" $url
}

esm::yoconf::get(){
    [private] hostname="$1" 
    [private] service="$2"
    
    [[ -z "$3" ]] && exit
    # do it like a pro :D
    # XXX: This could avoid a lot of problems, but we will not use it
    #local -A "$3"

    # even more easyer for us, we're pro's

    [private:map] array="$3"

    type::variable::set hostname service || exit
    url="https://$hostname:8000/ajaxyoconf?service=$service"

    while read line; do
        array["${line%%=*}"]="${line#*=}"
    done < <(yoconf::curl get "$url")
}

esm::yoconf::post(){
    [private] hostname="$1" 
    [private] project="$2" 
    [private] user="$3"

    url="https://$hostname:8000/ajaxyoconf"

    # this can't be correct.... but i will keep it, we don't know the code of lav...
    yoconf::curl post "$url" "{ project=$service&customer=$customer&host=$hostname }"
}
