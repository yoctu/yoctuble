application_name="yoctuble"
html_dir="${DOCUMENT_ROOT%/}/../html"
css_dir="${DOCUMENT_ROOT%/}/../css"
js_dir="${DOCUMENT_ROOT%/}/../js"
img_dir="${DOCUMENT_ROOT%/}/../img"
fonts_dir="${DOCUMENT_ROOT%/}/../fonts"
etc_conf_dir="/etc/$application_name/"
login_method="auth::custom::request"
login_page="login"
login_unauthorized="html::print::out ${html_dir}/login.html"

appEnv="$(hostname -d)"
appEnv="${appEnv%.*}"

