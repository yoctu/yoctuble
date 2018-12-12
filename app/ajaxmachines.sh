user="$(session::get USERNAME)"
declare -A profile

yoctapi::get::user::entity "$(session::get USERNAME)" "profile"

machineCreate(){
    local model="${POST['model']}"

    type::variable::set model || return 1

    local machinename="V-$(date +%s)-$(( RANDOM % 1000 ))"
    local -A tmpArray=([host_name]="$machinename.$appEnv" [m_status]="5" [m_owner]="$user" [m_group]="${profile['users':"$user":'u_group']}" [m_type]="$model")
    machine::create "$user" "${profile['users':"$user":'u_group']}" "${profile['users':"$user":'email']}" "$machinename" "$model"
    yoctapi::post::machines "tmpArray"
}

machineRemove(){
    local hostid="${POST['id']}"    
    local hostname="${POST['name']}"

    type::variable::set hostid || return 1


    yoctapi::delete::machines "$hostid"

    machine::delete "$hostname"
}

machineStop(){
    local hostname="${POST['name']}" hostid="${POST['id']}"

    type::variable::set hostname hostid || return 1

    local -A tmpArray=([m_status]="30")
    yoctapi::put::machines "$hostid" "tmpArray"

    machine::stop "$hostname"
}

machineStart(){
    local hostname="${POST['name']}" hostid="${POST['id']}"

    type::variable::set hostname hostid || return 1

    local -A tmpArray=([m_type]="25")
    yoctapi::put::machines "$hostid" "tmpArray"

    machine::start "$hostname"
}

machineResize(){
    local hostname="${POST['hostname']}" hostid="${POST['id']}" machinetype="${POST['type']}"

    type::variable::set hostname hostid machinetype || return 1

    local -A tmpArray=([m_type]="$machinetype")
    yoctapi::put::machines "$hostid" "tmpArray"

    machine::resize "$hostname" "$machinetype"
}


case "${POST['action']}" in 
    "remove" )  machineRemove   ;; 
    "create" )  machineCreate   ;; 
    "start"  )  machineStart    ;; 
    "stop"   )  machineStop     ;;
    "resize" )  machineResize   ;; 
esac

