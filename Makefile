deploy role:
		aws cloudformation deploy --stack-name payment-deploy-role \
		--region us-east-1 \
		--template aws/iam/role.yaml \
		--capabilities CAPABILITY_NAMED_IAM

build:
		docker build -t payment .

run:
		docker run --name ocaml-web --net bridge -p 8080:8080 -it payment
