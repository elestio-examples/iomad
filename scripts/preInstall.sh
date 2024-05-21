#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./moodleapp-data
mkdir -p ./mysql

chown -R 1000:1000 ./moodleapp-data
chown -R 1000:1000 ./mysql