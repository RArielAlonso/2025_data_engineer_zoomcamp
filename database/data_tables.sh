#!/bin/bash
for file in /sql/*; do psql -U aalonso -d database_nyc -f "$file"; done