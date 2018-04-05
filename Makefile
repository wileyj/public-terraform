ONESHELL:
SHELL := /bin/bash
.PHONY: help

validate: ## Runs `terraform validate` against all the .tf files
	@for i in $$(find -type f -name "*.tf" -exec dirname {} \;); do \
		terraform validate "$$i"; \
		if [ $$? -ne 0 ]; then \
			echo "Failed Terraform file validation on file $${i}"; \
			echo; \
			exit 1; \
		fi; \
	done

update:
	@terraform get -update=true

format:
	@terraform fmt

fmt:
	@terraform fmt

get:		## Get the terraform modules
	@terraform get

init:	## Initialize remote S3 backend.
	# @terraform init -backend=true -backend-config="bucket=target-bucket" -backend-config="key=bucket-key.tfstate" -backend-config="region=${AWS_DEFAULT_REGION}"
	@terraform init

plan:
	@terraform plan \
		-input=false \
		-refresh=true \
		-module-depth=-1

plan-target:
	@tput setaf 3; tput bold; echo -n "[INFO]   "; tput sgr0; echo "Example to type for the following question: module.rds.aws_route53_record.rds-master"
	@read -p "PLAN target: " DATA &&\
		terraform plan \
			-input=true \
			-refresh=true \
			-target=$$DATA

plan-destroy: init update ## Creates a destruction plan.
	@terraform plan \
		-input=false \
		-refresh=true \
		-module-depth=-1 \
		-destroy

show: init
	@terraform show -module-depth=-1

graph: ## Output the `dot` graph of all the built Terraform resources
	@rm -f graph.png
	@terraform graph -draw-cycles -module-depth=-1 | dot -Tpng > graph.png
	#@shotwell graph.png

apply: init update
	@terraform apply \
		-input=true \
		-refresh=true

cryptotracker-destroy: init update elasticsearch-destroy app-destroy kibana-destroy
cryptotracker-plan: init update elasticsearch-plan app-plan kibana-plan
cryptotracker: init update elasticsearch app kibana

cpt-plan: init update
	@terraform plan \
	-refresh=true \
	-target=module.crypto_pricetracker.aws_ecs_task_definition.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_ecs_service.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_cloudwatch_log_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener_rule.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_target_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker_public \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000 \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_sg \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_external


cpt-destroy: init update
	@terraform destroy \
	-refresh=true \
	-target=module.crypto_pricetracker.aws_ecs_task_definition.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_ecs_service.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_cloudwatch_log_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener_rule.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_target_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker_public \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000 \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_sg \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_external

cpt: init update
	@terraform apply \
	-refresh=true \
	-target=module.crypto_pricetracker.aws_ecs_task_definition.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_ecs_service.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_cloudwatch_log_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_listener_rule.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb_target_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_alb.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_route53_record.crypto_pricetracker_public \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker \
	-target=module.crypto_pricetracker.aws_security_group.crypto_pricetracker_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_allow_outbound_external \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000 \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_sg \
	-target=module.crypto_pricetracker.aws_security_group_rule.allow_crypto_pricetracker_5000_external

kibana-plan:  init update
	@terraform plan \
		-refresh=true \
		-target=module.cryptotracker.aws_security_group.cryptotracker \
		-target=module.cryptotracker.aws_security_group_rule.allow_outbound \
		-target=module.cryptotracker.aws_security_group_rule.allow_kibana_5601 \
		-target=module.cryptotracker.aws_security_group_rule.allow_kibana_5601_sg \
		-target=module.cryptotracker.aws_alb.cryptotracker \
		-target=module.cryptotracker.aws_alb_listener.cryptotracker_kibana \
		-target=module.cryptotracker.aws_alb_listener_rule.cryptotracker_kibana \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_kibana \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_kibana \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_kibana \
		-target=module.cryptotracker.aws_route53_record.cryptotracker

kibana-destroy:  init update
	@terraform destroy \
		-refresh=true \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_kibana \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_kibana \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_kibana \
		-target=module.cryptotracker.aws_route53_record.cryptotracker

kibana:  init update
	@terraform apply \
		-refresh=true \
		-target=module.cryptotracker.aws_security_group.cryptotracker \
		-target=module.cryptotracker.aws_security_group_rule.allow_outbound \
		-target=module.cryptotracker.aws_security_group_rule.allow_kibana_5601 \
		-target=module.cryptotracker.aws_security_group_rule.allow_kibana_5601_sg \
		-target=module.cryptotracker.aws_security_group_rule.allow_kibana_external_5601 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_external_9200 \
		-target=module.cryptotracker.aws_alb.cryptotracker \
		-target=module.cryptotracker.aws_alb_listener.cryptotracker_kibana \
		-target=module.cryptotracker.aws_alb_listener_rule.cryptotracker_kibana \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_kibana \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_kibana \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_kibana \
		-target=module.cryptotracker.aws_route53_record.cryptotracker

app-plan:  init update
	@terraform plan \
		-input=true \
		-refresh=true \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_app \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_app

app:  init update
	@terraform apply \
		-input=true \
		-refresh=true \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_app \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_app

elasticsearch-plan: init update
	@terraform plan \
		-input=true \
		-refresh=true \
		-target=module.cryptotracker.aws_security_group.cryptotracker \
		-target=module.cryptotracker.aws_security_group_rule.allow_outbound \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200_sg \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300_sg \
		-target=module.cryptotracker.aws_alb.cryptotracker \
		-target=module.cryptotracker.aws_alb_listener.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_listener_rule.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_route53_record.elasticsearch \
		-target=module.cryptotracker.aws_route53_record.cryptotracker \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_cloudwatch_log_group.elasticsearch

elasticsearch: init update
	@terraform apply \
		-input=true \
		-refresh=true \
		-target=module.cryptotracker.aws_security_group.cryptotracker \
		-target=module.cryptotracker.aws_security_group_rule.allow_outbound \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200_sg \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300_sg \
		-target=module.cryptotracker.aws_alb.cryptotracker \
		-target=module.cryptotracker.aws_alb_listener.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_listener_rule.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_route53_record.elasticsearch \
		-target=module.cryptotracker.aws_route53_record.cryptotracker \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_cloudwatch_log_group.elasticsearch

elasticsearch-destroy: init update
	@terraform destroy \
		-input=true \
		-refresh=true \
		-target=module.cryptotracker.aws_security_group.cryptotracker \
		-target=module.cryptotracker.aws_security_group_rule.allow_outbound \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9200_sg \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300 \
		-target=module.cryptotracker.aws_security_group_rule.allow_elasticsearch_9300_sg \
		-target=module.cryptotracker.aws_alb.cryptotracker \
		-target=module.cryptotracker.aws_alb_listener.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_listener_rule.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_alb_target_group.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_route53_record.elasticsearch \
		-target=module.cryptotracker.aws_route53_record.cryptotracker \
		-target=module.cryptotracker.aws_ecs_service.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_ecs_task_definition.cryptotracker_elasticsearch \
		-target=module.cryptotracker.aws_cloudwatch_log_group.elasticsearch

apply-target: init update ## Apply a specific resource and any chained resources.
	@tput setaf 3; tput bold; echo -n "[INFO]   "; tput sgr0; echo "Specifically APPLY a piece of Terraform data."
	@tput setaf 3; tput bold; echo -n "[INFO]   "; tput sgr0; echo "Example to type for the following question: module.rds.aws_route53_record.rds-master"
	@tput setaf 1; tput bold; echo -n "[DANGER] "; tput sgr0; echo "You are about to apply a new state."
	@tput setaf 1; tput bold; echo -n "[DANGER] "; tput sgr0; echo "This has the potential to break your infrastructure."
	@read -p "APPLY target: " DATA &&\
		terraform apply \
			-input=true \
			-refresh=true \
			-target=$$DATA

output: init update ## Display all outputs from the remote state file.
	@echo "Example to type for the module: MODULE=module.rds.aws_route53_record.rds-master"
	@echo
	@if [ -z $(MODULE) ]; then\
		terraform output;\
	 else\
		terraform output -module=$(MODULE);\
	 fi

taint: init update ## Taint a resource for destruction upon next `apply`
	@echo "Tainting involves specifying a module and a resource"
	@read -p "Module: " MODULE && \
		read -p "Resource: " RESOURCE && \
		terraform taint \
			-module=$$MODULE $$RESOURCE
	@echo "You will now want to run a plan to see what changes will take place"

destroy: init update ## Destroys everything. There is a prompt before destruction.
	@terraform destroy \
		-var-file=environments/$(ENVIRONMENT)/$(ENVIRONMENT).tfvars \
		-var-file=$(ENVIRONMENT).tfvars

destroy-target: init update ## Destroy a specific resource. Caution though, this destroys chained resources.
	@echo "Specifically destroy a piece of Terraform data."
	@echo
	@echo "Example to type for the following question: module.rds.aws_route53_record.rds-master"
	@echo
	@read -p "Destroy target: " DATA &&\
		terraform destroy \
		-var-file=environments/$(ENVIRONMENT)/$(ENVIRONMENT).tfvars \
		-var-file=$(ENVIRONMENT).tfvars \
		-target=$$DATA
