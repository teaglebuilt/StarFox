BROWSER?=firefox
COMMAND=bash
GRID_HOST=selenium-hub
GRID_YML=docker-compose.yml
GRID_HOST=selenium-hub
GRID_PORT=4444
GRID_SCHEME=http
GRID_TIMEOUT=30000
NETWORK=${PROJECT}_default
PROJECT=development
SCALE=1
SCALE_CHROME=${SCALE}
SCALE_FIREFOX=${SCALE}
SELENIUM_VERSION=3.8.1-dubnium

.NOTPARALLEL:


grid-up: network-up
	NETWORK=${NETWORK} \
	GRID_TIMEOUT=${GRID_TIMEOUT} \
	SELENIUM_VERSION=${SELENIUM_VERSION} \
	docker-compose -f ${GRID_YML} -p ${PROJECT} up -d --scale firefox=${SCALE_FIREFOX} --scale chrome=${SCALE_CHROME}

grid-restart:
	NETWORK=${NETWORK} \
	GRID_TIMEOUT=${GRID_TIMEOUT} \
	SELENIUM_VERSION=${SELENIUM_VERSION} \
	docker-compose -f ${GRID_YML} -p ${PROJECT} restart

grid-down:
	NETWORK=${NETWORK} \
	GRID_TIMEOUT=${GRID_TIMEOUT} \
	SELENIUM_VERSION=${SELENIUM_VERSION} \
	docker-compose -f ${GRID_YML} -p ${PROJECT} down


network-up:
	$(eval NETWORK_EXISTS=$(shell docker network inspect ${NETWORK} > /dev/null 2>&1 && echo 0 || echo 1))
	@if [ "${NETWORK_EXISTS}" = "1" ] ; then \
	    echo "Creating network: ${NETWORK}"; \
	    docker network create --driver bridge ${NETWORK} ; \
	fi;

network-down: grid-down
	$(eval NETWORK_EXISTS=$(shell docker network inspect ${NETWORK} > /dev/null 2>&1 && echo 0 || echo 1))
	@if [ "${NETWORK_EXISTS}" = "0" ] ; then \
	    for i in `docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' ${NETWORK}`; do \
	        echo "Removing container \"$${i}\" from network \"${NETWORK}\""; \
	        docker network disconnect -f ${NETWORK} $${i}; \
	    done; \
	    echo "Removing network: ${NETWORK}"; \
	    docker network rm ${NETWORK}; \
	fi;