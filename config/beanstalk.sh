declare -A BEANSTALKD

# first key is matchin the env
BEANSTALKD['env':'host']="HOST"
BEANSTALKD['env':'port']="PORT"

# Tubes defination
BEANSTALKD['tube':'beanstalkd::machine::create']="stackstorm-worker-create"
BEANSTALKD['tube':'beanstalkd::machine::stop']="stackstorm-worker-stop"
BEANSTALKD['tube':'beanstalkd::machine::start']="stackstorm-worker-start"
BEANSTALKD['tube':'beanstalkd::machine::delete']="stackstorm-worker-delete"
BEANSTALKD['tube':'beanstalkd::machine::resize']="stackstorm-worker-resize"
