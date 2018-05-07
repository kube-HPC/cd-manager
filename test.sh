echo Running tests!!!
curl -k -X POST \
  https://40.69.222.75/hkube/api-server/api/v1/exec/raw \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "batch",
    "nodes": [
        {
            "nodeName": "green",
            "algorithmName": "eval-alg",
            "input": [
                "#@flowInput.files.links"
            ],
            "extraData":{
              "code":[
                    "(input) => {",
                    "const result = input[0];",
                    "return new Promise((resolve)=>{setTimeout(()=>{resolve(result)},1000)}); }"

                ]
            }
        }
    ],
    "priority": 5,
    "flowInput": {
        "files": {
            "links": [
                "links-1",
                "links-2",
                "links-1",
                "links-2"              
            ]
        }
    },
    "options": {
        "batchTolerance": 100,
        "progressVerbosityLevel": "debug"
    },
    "webhooks": {
        "progress": "http://localhost:3003/webhook/progress",
        "result": "http://localhost:3003/webhook/result"
    }
}'