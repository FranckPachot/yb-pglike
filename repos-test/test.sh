
run(){
mkdir -p /var/tmp/tests
(
cd /var/tmp/tests
git clone "$1"
cd "$(basename $1)"
sh
docker-compose up
)
}

run https://github.com/awslabs/aws-dataall <<'SH'
sed -e 's!context: compose/postgres!context: https://github.com/FranckPachot/yb-pglike.git!' -i docker-compose
SH

