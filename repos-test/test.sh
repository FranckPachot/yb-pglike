
img="https://github.com/FranckPachot/yb-pglike.git"
mkdir -p /var/tmp/repos-tests 

# Search repos on GitHub:
#
# path:/docker-compose* /image: postgres/ /POSTGRES_PASSWORD:/ language:YAML  NOT is:archived 
#

case $1 in 

aws-dataall) 

cd       /var/tmp/repos-tests &&
git clone https://github.com/awslabs/aws-dataall 
cd ./aws-dataall &&
sed -e 's!context: compose/postgres!context: '"${img}"'!' -i docker-compose.yaml &&
docker-compose -p aws-dataall up

;;

wiki) 

cd       /var/tmp/repos-tests &&
git clone https://github.com/requarks/wiki
cd ./wiki/dev/examples &&
sed -e 's!image: postgres.*!build: '"${img}"'!' -i docker-compose.yml &&
docker-compose -p wiki up

;;

*)

grep -A1 "^[^)*]*[)]$" $0

;;

esac

