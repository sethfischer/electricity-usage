psql postgres -U postgres
psql postgres -U postgres -f /data/import.psql
psql postgres -U postgres -f /reports/year_month_crosstab.pgsql
psql postgres -U postgres -A -F"," -f /reports/year_month_crosstab.pgsql
