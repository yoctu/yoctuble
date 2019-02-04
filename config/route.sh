ROUTE['/':'GET']="Html::print::out home.html"
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

# For Saml Auth
# Route to set for activation saml
#ROUTE['/acs':'POST']='Saml::retrieve::Identity'
#ROUTE['/acs':'GET']='Saml::retrieve::Identity'
#ROUTE['/login':'GET']='Saml::buildAuthnRequest'
#ROUTE['/logout':'POST']='Saml::Logout'
#ROUTE['/logout':'GET']='Saml::Logout'
#ROUTE['/':'GET']="Html::print::out ${html_dir}/home.html"

#AUTH['/':'GET']="connect"
#AUTH['/acs':'POST']="none"
#AUTH['/acs':'GET']="none"

#LOGIN['/':'GET']="Auth::saml::request"
