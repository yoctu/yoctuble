getListProject(){
    ! [[ -z "${projectList}" ]] && Json::create projectList
}

getListEnv(){
    ! [[ -z "${projectEnv}" ]] && Json::create projectEnv
}

getListModel(){
    ! [[ -z "${projectModel}" ]] && Json::create projectModel
}

case ${GET['action']} in
    getmodel)           
        getListModel        ;;
    getenv)             
        getListEnv          ;;
    getproject)         
        getListProject      ;;
    getmodeldetail)     
        getListModel        ;;
    *)  
        { echo 'No List Provided'; exit;} ;;                
esac
