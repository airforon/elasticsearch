.SILENT :
.PHONY : elasticsearch

elasticsearch:
	docker build -t tokyohomesoc/elasticsearch:test .
	docker images
    docker history tokyohomesoc/elasticsearch:test