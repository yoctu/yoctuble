# machine lib

# You should set the machine li in this array
# default is beanstalkd
declare -A MACHINE=([plugin]="beanstalkd")

machine::data(){
    local -A machineData
    local key

    for key in "$@"; do
        machineData[$key]="${!key}"
    done
    
    Json::create machineData
}

machine::create(){
    local owner="$1" group="$2" email="$3" machinename="$4" model="$5"
    
    type::variable::set owner group email machinename model || return 1
    
    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data owner group email machinename model)"
}

machine::delete(){
    local machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::start(){
    local machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::stop(){
    local machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::resize(){
    local machinename="$1" model="$2"

    type::variable::set machinename model || return 1 

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename model)"
}

