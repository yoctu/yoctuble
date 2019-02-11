# ajaxcomment.sh
# This should update comment in Yoctapi

main(){

    [private] comment="${POST['comment']}"
    [private] hostid="${POST['id']}"

    # Check if valid fields are set
    Type::variable::set comment hostid || { echo "Missing madnatory fields!"; exit; }

    # Create array with importent data
    [private:assoc] commentData=([m_comment]="$comment")

    # call yoctapi
    yoctapi::put::comment commentData "$hostid"   
}

# Call main function
main
