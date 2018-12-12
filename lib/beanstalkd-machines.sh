# the tubes should be configured like this:
# BEANSTALKD['tubes':FUNCNAME]="tubename"

beanstalkd::machine::call(){
    local tube="$1" json="$2"
    
    Type::variable::set tube json || return 1
    beanstalkd::put "$tube" "100" "0" "100" "$json"
}

beanstalkd::machine::create(){
    beanstalkd::machine::call "${BEANSTALKD['tube':"$FUNCNAME"]}" "$*"
}

beanstalkd::machine::delete(){
    beanstalkd::machine::call "${BEANSTALKD['tube':"$FUNCNAME"]}" "$*"
}

beanstalkd::machine::stop(){
    beanstalkd::machine::call "${BEANSTALKD['tube':"$FUNCNAME"]}" "$*"
}

beanstalkd::machine::start(){
    beanstalkd::machine::call "${BEANSTALKD['tube':"$FUNCNAME"]}" "$*"
}

beanstalkd::machine::resize(){
    beanstalkd::machine::call "${BEANSTALKD['tube':"$FUNCNAME"]}" "$*"
}

