#! /bin/bash

echo "setting env for $1"
env=$1

if [ -z "$env" ]; then
    echo "Error: No environment specified. Please provide one of: beta, gamma, prod."
    exit 1
fi

#case "$env" in beta|gamma|prod);;*)
#        echo "Error: Invalid environment '$env'. Allowed values are: beta, gamma, prod."
#        exit 1
#        ;;
#esac

export PGSSLMODE=verify-full
export PGUSER=ps_power_user
export PGPORT=5432

if [ "$env" == "beta" ]; then
    export AWS_REGION=us-west-2
    export AWS_PROFILE=2433-ps-power-user
    export PGHOST=psa2dbf7f2lq.donb2flf2lq.us-west-2.rds.amazonaws.com
    export PGDATABASE=ps_product_dev1_pse_product_staging_db
    echo "environment $1 set"
elif [ "$env" == "gamma" ]; then
    export AWS_REGION=us-west-2
    export AWS_PROFILE=2433-ps-power-user
    export PGHOST=rdsea35f773.ckm9zbffzl4g.us-west-2.rds.amazonaws.com
    export PGDATABASE=ps_product_cert_pse_publish_product_db
    echo "environment $1 set"
elif [ "$env" == "prod" ]; then
    export AWS_REGION=us-east-1
    export AWS_PROFILE=3859-ps-power-user
    export PGHOST=rds78c6de7f.ctwzhftx6p71.us-east-1.rds.amazonaws.com
    export PGDATABASE=ps_product_prod_pse_publish_product_db
    echo "environment $1 set"
else
    echo "No specific environment settings applied."
fi

echo $(aws --profile ${AWS_PROFILE} --region ${AWS_REGION} rds generate-db-auth-token --hostname ${PGHOST} --port ${PGPORT} --username ${PGUSER})
export PGPASSWORD=$(aws --profile ${AWS_PROFILE} --region ${AWS_REGION} rds generate-db-auth-token --hostname ${PGHOST} --port ${PGPORT} --username ${PGUSER})
echo ${PGPASSWORD} | pbcopy

echo "finished $1"
