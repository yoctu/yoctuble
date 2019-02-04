connect::auth::start(){
    if ! session::check; then
        http::send::redirect temporary /login
    else
        session::read
    fi
}

