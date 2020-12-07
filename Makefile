.PHONY: help
help: ## Display help text
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} \
	/^[a-zA-Z_-]+:.*?##/ \
	{ printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ \
	{ printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: output-directory
output-directory: ## Create output directory
	mkdir -p output

.PHONY: import-data
import-data: # Import data from CSV files into database
	docker exec -it eusage psql postgres -U postgres -f /data/import.psql

.PHONY: report-crosstab-year-month
report-crosstab-year-month: # Year month crosstab report
	docker exec -it eusage psql postgres -U postgres -f /reports/year_month_crosstab.pgsql

.PHONY: clean
clean: ## Remove output directory
	-rm -r ./output
