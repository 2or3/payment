deploy role:
		aws cloudformation deploy --stack-name payment-deploy-role \
		--region us-east-1 \
		--template aws/iam/role.yaml \
		--capabilities CAPABILITY_NAMED_IAM

build:
		docker build -t payment .

local run:
		docker run --name ocaml-web --net bridge -p 8080:8080 -it payment

deploy:
		aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 044462970062.dkr.ecr.us-east-1.amazonaws.com
		docker tag ocaml 044462970062.dkr.ecr.us-east-1.amazonaws.com/payment:latest
		docker push 044462970062.dkr.ecr.us-east-1.amazonaws.com/payment:latest
