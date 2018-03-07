#!/bin/bash

# File loaded from http://www.cidoc-crm.org/sites/default/files/cidoc_crm_core-2014Feb%20%283%29.rdf
#
# see
# http://docs.openlinksw.com/virtuoso/rdfperfloading/

# docker exec -it my-virtuoso bash
# isql-v -U dba -P $DBA_PASSWORD
# SQL> ld_dir('dumps', '*.nq', 'http://foo.bar');
# SQL> rdf_loader_run();
# Validate the ll_state of the load. If ll_state is 2, the load completed.
# 
# select * from DB.DBA.load_list;

# DB.DBA.RDF_LOAD_RDFXML (file_to_string_output ('file.xml'), 'base_uri', 'target_graph');

# I cd to /var/lib/docker/volumes/ibbo_virt-data/_data and manually edit virtuoso.ini to add /data to allowedDirs

docker cp cidoc_crm_core-2014Feb.rdf ibbo_virt_1:/data/dumps/cidoc_crm_core-2014Feb.rdf


# This seems to work
docker exec -it ibbo_virt_1 bash
isql-v -U dba -P dba
ld_dir('dumps', '*.rdf', 'http://www.cidoc-crm.org/');
rdf_loader_run();

# Test load OK
## http://localhost:8890/sparql?default-graph-uri=&query=select+%3Fp+%3Fo+where%0D%0A%7B%0D%0A++%3Chttp%3A%2F%2Fwww.cidoc-crm.org%2Fcidoc-crm%2FP2_has_type%3E+%3Fp+%3Fo+.%0D%0A%7D&should-sponge=&format=text%2Fhtml&timeout=0&debug=on

