# ajaxcomment.sh
# This should update comment in Yoctapi

main(){

    local comment="${POST['comment']}"
    local hostid="${POST['id']}"

    # Check if valid fields are set
    [[ -z "$comment" || -z "$hostid" ]] && { echo "Missing madnatory fields!"; exit; }

    # Create array with importent data
    local -A commentData=([m_comment]="$comment")

    # call yoctapi
    yoctapi::put::comment commentData "$hostid"   
}

# Call main function
main
