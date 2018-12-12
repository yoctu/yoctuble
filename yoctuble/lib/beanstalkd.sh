
beanstalkd::value::checker (){
    for value in "$@"
    do
        if [[ -z "${!value}" ]]
        then
            http::send::status 500
            echo "BEANSTALKD ERROR: No ${value} set!"
            exit
        fi
    done
}

beanstalkd::put (){
    local _tube="$1" priority="$2" delay="$3" ttr="$4" data="$5"

    # check if all values are set
    beanstalkd::value::checker priority delay ttr data _tube

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        put "$priority" "$delay" "$ttr" "$data"

}

beanstalkd::peekReady (){
    local _tube="$1"    

    # check if values are set
    beanstalkd::value::checker _tube

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        peek-ready
}

beanstalkd::buried (){
    local _tube="$1" _jobid="$2"

    # check if values are set
    beanstalkd::value::checker _tube _jobid="2"

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        bury "$_jobid"
}


beanstalkd::delete (){
    local _tube="$1" jobid="$2"

    # check if values are set
    beanstalkd::value::checker _tube jobid

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        delete "$_jobid"
}

beanstalkd::watch (){
    local _tube="$1"

    # check if values are set
    beanstalkt-value-checker _tube

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        watch    
}

beanstalkd::listTubes (){
    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" \
        list-tubes
}

beanstalkd::stats (){
    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" \
        stats
}


