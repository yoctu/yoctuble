
beanstalkd::value::checker (){
    for value in "$@"; do
        if [[ -z "${!value}" ]]; then
            http::send::status 500
            echo "BEANSTALKD ERROR: No ${value} set!"
            exit
        fi
    done
}

beanstalkd::put (){
    [private] _tube="$1" 
    [private] priority="$2" 
    [private:int] delay="$3" 
    [private] ttr="$4" 
    [private] data="$5"

    # check if all values are set
    beanstalkd::value::checker priority delay ttr data _tube

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        put "$priority" "$delay" "$ttr" "$data"

}

beanstalkd::peekReady (){
    [private] _tube="$1"    

    # check if values are set
    beanstalkd::value::checker _tube

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        peek-ready
}

beanstalkd::buried (){
    [private] _tube="$1" 
    [private] _jobid="$2"

    # check if values are set
    beanstalkd::value::checker _tube _jobid="2"

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        bury "$_jobid"
}


beanstalkd::delete (){
    [private] _tube="$1" 
    [private] jobid="$2"

    # check if values are set
    beanstalkd::value::checker _tube jobid

    beanstalk-client.sh -H "${BEANSTALKD[$env:'host']}" -P "${BEANSTALKD[$env:'port']}" -t "$_tube" \
        delete "$_jobid"
}

beanstalkd::watch (){
    [private] _tube="$1"

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


