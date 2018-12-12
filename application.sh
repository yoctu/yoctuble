# Set default value
# env will only be used based on GET['env']
[[ -z "${GET['env']}" ]] || env="${GET['env']}"
[[ -z "${POST['env']}" ]] || env="${POST['env']}"
