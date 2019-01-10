# Little lib for yoctapi
[public:assoc] YOCTAPI

# Env mode
YOCTAPI['env':'url']="THE HOST"
YOCTAPI['curl':'timeout']="10"

yoctapi::data::manipulate(){
    # Data should be manipulated here

    [private:map] array="$1"
    [private:assoc] data_array

    for key in "${!array[@]}"; do
        data_array['data':$key]="${array[$key]}"
    done

    Json::create data_array
}

yoctapi::curl(){
    [private] method="${1^^}" 
    [private] url="${2#/}" 
    [private] data="$3"

    [[ -z "${YOCTAPI['auth']}" ]] || _curl_auth="-H Authorization: ${YOCTAPI['auth']}"

    curl -s -X "$method" -H "Content-type: application/json" -d "$data" --connect-timeout "${YOCTAPI['curl':'timeout']}" ${YOCTAPI[$env:'url']%/}/api/$url
}

yoctapi::put::comment(){
    # You should get an array
    [private] array="$1" 
    [private] url="$2"

    type::variable::set array url || { echo "Missing Mandatory Data while adding comment..." >&2; exit; }

    yoctapi::curl "put" "machines/$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::post::machines(){
    # You should get an array
    [private] array="$1" 
    [private] url="machines"

    type::variable::set array || { echo "Missing Mandatory Data while posting machines..." >&2; exit; }

    yoctapi::curl "post" "$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::delete::machines(){
    [private] machine="$1"

    type::variable::set machine || { echo "Missing Mandatory Data while deleting machines..." >&2; exit; }
    
    [private] url="machines/$machine"

    yoctapi::curl "delete" "$url" 
}

yoctapi::put::machines(){
    [private] machine="$1" 
    [private] array="$2"

    type::variable::set machine array || { echo "Missing Mandatory Data while puting machines..." >&2; exit; }

    [private] url="machines/$machine"

    yoctapi::curl "put" "$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::get::machines(){
    [private] group="$1" 
    [private] array="$2"
    
    type::variable::set group array || { echo "Missing Mandatory Data while geting machines..." >&2; exit; }

    [private] url="machines/$group"

    Json::to::array "$array" "$(yoctapi::curl "get" "$url")"
}

yoctapi::get::user::entity(){
    [private] user="$1"
    [private] array="$2"
    [private] response

    type::variable::set user array || { echo "Missing Mandatory Data while getting user entity..." >&2; exit; }

    [private] url="/users/$user"

    Json::to::array "$array" "$(yoctapi::curl "get" "$url")"        
}
