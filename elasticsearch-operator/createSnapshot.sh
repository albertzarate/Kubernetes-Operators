export POD=$(kubectl get po --selector=role=client -o jsonpath='{.items[0].metadata.name}')

kubectl port-forward $POD 9200:9200 &


curl -XPUT https://localhost:9200/_snapshot/elasticsnapshots99 -H 'Content-Type: application/json' -d'
{
"type": "s3",
"settings": {
  "bucket": "elasticsnapshots99",
  "region": "us-east-1"
}
}' -k


SNAPSHOT=`date +%Y%m%d-%H%M%S`
curl -XPUT https://localhost:9200/_snapshot/elasticsnapshots99/$SNAPSHOT\?wait_for_completion\=true -k
