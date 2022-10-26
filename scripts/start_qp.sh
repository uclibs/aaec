#!/bin/bash

if [ ! -f "$(dirname "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )" )/static/.env.production.local" ]; then
    echo "Missing updated .env.production.local file in the static directory. The server may not function properly"
else
    cp "$(dirname "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )" )/static/.env.production.local" "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"
fi

export RAILS_RELATIVE_URL_ROOT=/aaec
export RAILS_ENV=production

bin/bundle exec rake db:seed

# Check if puma is started
if ! ( [ -f /opt/webapps/aaec/current/tmp/puma/pid ] && pgrep -F /opt/webapps/aaec/current/tmp/puma/pid > /dev/null )
then
    bin/bundle exec puma -d
else
    bin/bundle exec pumactl stop
    sleep 10
    cd /opt/webapps/aaec/current
    bin/bundle exec puma -d
fi
