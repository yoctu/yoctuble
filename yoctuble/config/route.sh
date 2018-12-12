ROUTE['/login':'GET']='html::print::out ${html_dir}/login.html'
ROUTE['/login':'POST']='html::print::out ${html_dir}/login.html'
ROUTE['/css/.*':'GET']='css::print::out ${uri#*/}'
ROUTE['/img/.*':'GET']='img::print::out ${uri#*/}'
ROUTE['/js/.*':'GET']='js::print::out ${uri#*/}'
ROUTE['/fonts/.*':'GET']='fonts::print::out ${uri#*/}'
ROUTE['/':'GET']="html::print::out ${html_dir}/home.html"
ROUTE['/ajaxlogout':'GET']="session::destroy"

AUTH['/':'GET']="htpasswd"
AUTH['/login':'GET']="none"
AUTH['/login':'POST']="none"
AUTH['/css/.*':'GET']="none"
AUTH['/img/.*':'GET']="none"
AUTH['/js/.*':'GET']="none"
AUTH['/fonts/.*':'GET']="none"

LOGIN['/':'GET']="auth::custom::request"
LOGIN['/':'POST']="auth::custom::request"
