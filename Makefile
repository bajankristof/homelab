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

platform:
	@terragrunt --working-dir=./units/platform apply -auto-approve

postgres:
	@terragrunt --working-dir=./units/postgres apply -auto-approve

sso:
	@terragrunt --working-dir=./units/sso apply -auto-approve

iam:
	@terragrunt --working-dir=./units/iam apply -auto-approve

media:
	@terragrunt --working-dir=./units/media apply -auto-approve

o11y:
	@terragrunt --working-dir=./units/o11y apply -auto-approve

alerts:
	@terragrunt --working-dir=./units/alerts apply -auto-approve

dashboards:
	@terragrunt --working-dir=./units/dashboards apply -auto-approve

clean:
	@rm -rf .terragrunt-cache
	@rm -rf units/*/.terragrunt-cache
	@rm -rf units/*/.terraform
	@rm units/*/terraform.tfstate*

lock:
	@fd -C units --type directory --max-depth 1 --exec bash -c 'cd {}; terraform providers lock'
