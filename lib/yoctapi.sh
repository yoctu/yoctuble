# Little lib for yoctapi
declare -A YOCTAPI

# Env mode
YOCTAPI['env':'url']="THE HOST"
YOCTAPI['curl':'timeout']="10"

yoctapi::data::manipulate(){
    # Data should be manipulated here

    local -n array="$1"
    local -A data_array

    for key in "${!array[@]}"; do
        data_array['data':$key]="${array[$key]}"
    done

    Json::create data_array
}

yoctapi::curl(){
    local method="${1^^}" url="${2#/}" data="$3"

    [[ -z "${YOCTAPI['auth']}" ]] || _curl_auth="-H Authorization: ${YOCTAPI['auth']}"

    curl -s -X "$method" -H "Content-type: application/json" -d "$data" --connect-timeout "${YOCTAPI['curl':'timeout']}" ${YOCTAPI[$env:'url']%/}/api/$url
}

yoctapi::put::comment(){
    # You should get an array
    local array="$1" url="$2"

    type::variable::set array url || { echo "Missing Mandatory Data while adding comment..." >&2; exit; }

    yoctapi::curl "put" "machines/$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::post::machines(){
    # You should get an array
    local array="$1" url="machines"

    type::variable::set array || { echo "Missing Mandatory Data while posting machines..." >&2; exit; }

    yoctapi::curl "post" "$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::delete::machines(){
    local machine="$1"

    type::variable::set machine || { echo "Missing Mandatory Data while deleting machines..." >&2; exit; }
    
    local url="machines/$machine"

    yoctapi::curl "delete" "$url" 
}

yoctapi::put::machines(){
    local machine="$1" array="$2"

    type::variable::set machine array || { echo "Missing Mandatory Data while puting machines..." >&2; exit; }

    local url="machines/$machine"

    yoctapi::curl "put" "$url" "$(yoctapi::data::manipulate "$array")"
}

yoctapi::get::machines(){
    local group="$1" array="$2"
    
    type::variable::set group array || { echo "Missing Mandatory Data while geting machines..." >&2; exit; }

    local url="machines/$group"

    Json::to::array "$array" "$(yoctapi::curl "get" "$url")"
}

yoctapi::get::user::entity(){
    local user="$1"
    local array="$2"
    local response

    type::variable::set user array || { echo "Missing Mandatory Data while getting user entity..." >&2; exit; }

    local url="/users/$user"

    Json::to::array "$array" "$(yoctapi::curl "get" "$url")"        
}
