# Electricity usage

Database schema and SQL or [PL/pgSQL][1] for analysing electricity usage data.

Create symbolic link to data directory:

    EUSAGE_DATA_DIRECTORY="../path/to/data_directory" make ln-data-directory


## Examples

### `year_month_crosstab.pgsql`

    $ psql eusage -f reports/year_month_crosstab.pgsql
     year | jan | feb | mar | apr | may | jun  | jul  | aug | sep | oct | nov | dec
    ------+-----+-----+-----+-----+-----+------+------+-----+-----+-----+-----+-----
     2015 |     |     |     |     | 176 |  865 |  890 | 853 | 694 | 386 | 211 | 217
     2016 | 498 | 432 | 533 | 633 | 614 |  889 |  945 | 632 | 861 | 717 | 566 | 233
     2017 | 515 | 473 | 595 | 866 | 836 |  675 | 1027 | 985 | 888 | 845 | 490 | 538
     2018 | 559 | 485 | 572 | 661 | 737 | 1009 |  846 | 821 | 804 | 476 | 454 | 278
     2019 | 398 | 326 | 394 | 727 | 768 |  793 |  650 | 760 | 582 | 637 | 645 | 443
     2020 | 619 |     |     |     |     |      |      |     |     |     |     |
    (6 rows)


[1]: https://www.postgresql.org/docs/10/plpgsql.html
