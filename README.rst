=================
Electricity usage
=================

|test-status|


Database schema and SQL or `PL/pgSQL`_ for analysing electricity usage data.


Usage
-----

Create a data directory using the provided skeleton:

.. code-block::

    cp -r skel/data ../electricity-usage-data

Configure and run the Docker application:

.. code-block::

    $ cp .env.dist .env
    $ editor .env
    $ docker-compose --env-file .env up -d
    $ make import-data
    $ docker exec -it eusage psql postgres -U postgres


Examples
--------

year_month_crosstab.pgsql
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block::

    $ docker exec -it eusage psql postgres -U postgres -f /reports/year_month_crosstab.pgsql
     year | jan | feb | mar | apr | may | jun  | jul  | aug | sep | oct | nov | dec
    ------+-----+-----+-----+-----+-----+------+------+-----+-----+-----+-----+-----
     2015 |     |     |     |     | 176 |  865 |  890 | 853 | 694 | 386 | 211 | 217
     2016 | 498 | 432 | 533 | 633 | 614 |  889 |  945 | 632 | 861 | 717 | 566 | 233
     2017 | 515 | 473 | 595 | 866 | 836 |  675 | 1027 | 985 | 888 | 845 | 490 | 538
     2018 | 559 | 485 | 572 | 661 | 737 | 1009 |  846 | 821 | 804 | 476 | 454 | 278
     2019 | 398 | 326 | 394 | 727 | 768 |  793 |  650 | 760 | 582 | 637 | 645 | 443
     2020 | 619 |     |     |     |     |      |      |     |     |     |     |
    (6 rows)


.. _`PL/pgSQL`: https://www.postgresql.org/docs/10/plpgsql.html


.. |test-status| image:: https://github.com/sethfischer/electricity-usage/workflows/test/badge.svg
    :target: https://github.com/sethfischer/electricity-usage/actions?query=workflow%3Atest
    :alt: Test Status
