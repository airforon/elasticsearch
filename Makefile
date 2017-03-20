.SILENT :
.PHONY : elasticsearch

elasticsearch:
	docker build -t tokyohomesoc/elasticsearch:test 5.0.0/
	docker images
    docker history tokyohomesoc/elasticsearch:test