#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./moodleapp-config
mkdir -p ./moodleapp-data

chown -R 1000:1000 ./moodleapp-config
chown -R 1000:1000 ./moodleapp-data