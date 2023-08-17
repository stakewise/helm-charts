mkdir /tmp/data

while true;
do
    poetry run keystore-cli
    sync-validator-keys
    --db-url $(ESO_DB_KEYSTORE_URL)
    --output-dir /tmp/data
    --index $1
    --no-of-keys {{ .Values.validatorsNoOfKeys }}
    if ! diff /tmp/data/validator_definitions.yml /data/validator_definitions.yml; then kubectl delete pod $(POD_NAME); fi;
    sleep 60 &;
    wait $!;
done