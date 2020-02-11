psql eusage
psql eusage -f data/import.psql
psql eusage -f reports/year_month_crosstab.pgsql
psql eusage -A -F"," -f reports/year_month_crosstab.pgsql
