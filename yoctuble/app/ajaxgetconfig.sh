getListProject(){
    ! [[ -z "${projectList}" ]] && Json::create::simple projectList
}

getListEnv(){
    ! [[ -z "${projectEnv}" ]] && Json::create::simple projectEnv
}

getListModel(){
    ! [[ -z "${projectModel}" ]] && Json::create::simple projectModel
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
