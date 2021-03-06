#! /bin/bash

# Usage: stats.sh BASE OUTPUT CONFIG

set -e

# set -x # DEBUG

OUTPUT_DIR=$1

# TODO

# -n: non-zero
if [[ -n "$SENTENCE_TABLE" && -n "$SENTENCE_TABLE_DOC_ID_COLUMN" ]]; then
	psql $DBNAME -c "
		SELECT COUNT(DISTINCT $SENTENCE_TABLE_DOC_ID_COLUMN) AS number_of_documents
		FROM $SENTENCE_TABLE;" > $OUTPUT_DIR/documents.txt

	psql $DBNAME -c "
		SELECT COUNT(*) AS number_of_sentences
		FROM $SENTENCE_TABLE;" >> $OUTPUT_DIR/documents.txt
fi

# Allow a custom script for global stats
if [[ -n "$STATS_GLOBAL_SCRIPT" ]]; then
	bash $SUPERVISION_SAMPLE_SCRIPT
fi
