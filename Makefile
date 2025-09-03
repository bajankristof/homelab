apply:
	@terragrunt apply --all -auto-approve

fmt:
	@terragrunt run --all fmt

system:
	@terragrunt --working-dir=./modules/system run -- taint 'null_resource.setup' 2>/dev/null || true
	@terragrunt --working-dir=./modules/system apply -auto-approve

k3s:
	@terragrunt --working-dir=./modules/k3s apply -auto-approve

clean:
	@rm -rf .terragrunt-cache
	@rm -rf modules/*/.terragrunt-cache
	@rm -rf modules/*/.terraform
	@rm modules/*/terraform.tfstate*
