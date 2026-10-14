bootstrap:
	@terragrunt backend --all bootstrap

plan:
	@terragrunt plan --all

apply:
	@terragrunt apply --all -auto-approve

fmt:
	@terraform fmt -recursive && terragrunt hcl fmt

system:
	@terragrunt --working-dir=./units/system run -- taint 'null_resource.setup' 2>/dev/null || true
	@terragrunt --working-dir=./units/system apply -auto-approve

k3s:
	@terragrunt --working-dir=./units/k3s apply -auto-approve

storage:
	@terragrunt --working-dir=./units/storage apply -auto-approve

idp:
	@terragrunt --working-dir=./units/idp apply -auto-approve

iam:
	@terragrunt --working-dir=./units/iam apply -auto-approve

oidc:
	@terragrunt --working-dir=./units/oidc apply -auto-approve

apps:
	@terragrunt --working-dir=./units/apps apply -auto-approve

observability:
	@terragrunt --working-dir=./units/observability apply -auto-approve

clean:
	@rm -rf .terragrunt-cache
	@rm -rf units/*/.terragrunt-cache
	@rm -rf units/*/.terraform
	@rm units/*/terraform.tfstate*

lock:
	@fd -C units --type directory --max-depth 1 --exec bash -c 'cd {}; terraform providers lock'
