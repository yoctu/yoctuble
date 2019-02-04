# machine lib

# You should set the machine li in this array
# default is beanstalkd
[private:assoc] MACHINE=([plugin]="beanstalkd")

machine::data(){
    [private:assoc] machineData
    [private] key

    for key in "$@"; do
        machineData[$key]="${!key}"
    done
    
    Json::create machineData
}

machine::create(){
    [private] owner="$1" 
    [private] group="$2" 
    [private] email="$3" 
    [private] machinename="$4" 
    [private] model="$5"
    
    type::variable::set owner group email machinename model || return 1
    
    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data owner group email machinename model)"
}

machine::delete(){
    [private] machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::start(){
    [private] machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::stop(){
    [private] machinename="$1"

    type::variable::set machinename || return 1

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename)"
}

machine::resize(){
    [private] machinename="$1" 
    [private] model="$2"

    type::variable::set machinename model || return 1 

    ${MACHINE['plugin']}::$FUNCNAME "$(machine::data machinename model)"
}

