#!/bin/bash
set -e

# MONGO_INITDB_ROOT_USERNAME과 MONGO_INITDB_ROOT_PASSWORD는 admin을
# 위한 값으로, 이 스크립트 실행 전에 이미 설정되어 있어야 한다.

echo ">>>>>>>> Trying to create db and users"

mongo_user_database=${MONGO_USER_DATABASE}
mongo_user_name=${MONGO_USER}
mongo_user_password=${MONGO_PASSWORD}

if [ -n "${MONGO_INITDB_ROOT_USERNAME:-}" ] && \
    [ -n "${MONGO_INITDB_ROOT_PASSWORD:-}" ] && \
    [ -n "${MONGO_USER:-}" ] && \
    [ -n "${MONGO_PASSWORD:-}" ]; then
mongo admin -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin << EOF
use ${MONGO_USER_DATABASE} ;
db.createUser({
    user: '${MONGO_USER}',
    pwd: '${MONGO_PASSWORD}',
    roles: [{
        role: 'readWrite',
        db: '${MONGO_USER_DATABASE}'
    }]
});
EOF

else
    echo "Some of environment variables are missing. DB init failed."
    exit 403
fi