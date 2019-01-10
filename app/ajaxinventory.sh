# Why don(t we have functions?
# Because we're rebels and don't respect google coding style :D

user="$(session::get USERNAME)"
[public:assoc] userEntity

# Get USer entity from yoctapi
yoctapi::get::user::entity "$user" "userEntity"

# Nagios host is defined in conf
[public:assoc] nagiosData
Json::to::array nagiosData "$(curl -s "${NAGIOS[$env:'url']}")"

[public:assoc] machines
yoctapi::get::machines ${userEntity['users':$user:'u_group']} machines

[public:assoc] outputJson

while read machine; do
    machineStatus="${machines['machines':$machine:'m_status']}"
    # Get nagios status
    nagiosStatus="${nagiosData['machines':$machine:'current_state']}"

    # This should never happend!!
    [[ "$machineStatus" == "null" ]] && continue

    if [[ "$machineStatus" == 0 && "$nagiosStatus" == 0 ]]; then
        newMachineStatus="20"
    elif [[ "$machineStatus" == "5" && "$nagiosStatus" == "0" ]]; then
        newMachineStatus="20"
    elif [[ "$machineStatus" == "30" && "$nagiosStatus" == "1" ]]; then
        newMachineStatus="10"
    elif [[ "$machineStatus" == "10" && "$nagiosStatus" == "0" ]]; then
        newMachineStatus="20"
    elif [[ "$machineStatus" == "25" && "$nagiosStatus" == "0" ]]; then
        newMachineStatus="20"
    elif [[ "$machineStatus" == "20" && "$nagiosStatus" == "1" ]]; then
        newMachineStatus="0"
    fi

    if [[ "$machineStatus" != "$newMachineStatus" && ! -z "$newMachineStatus" ]]; then
        [public:assoc] putMachine=([m_status]="$newMachineStatus")
        yoctapi::put::machines "${machines['machines':$machine:'id']}" putMachine >/dev/null
    fi

done < <(Type::array::get::key machines machines)

Type::array::fusion machines outputJson "machines:.*"
Type::array::fusion nagiosData outputJson "machines:.*"
Type::array::fusion nagiosData outputJson "services:.*:ESM:.*"

# Output the json
Json::create outputJso
n
