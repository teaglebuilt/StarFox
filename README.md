# StarFox


As of right now, I am exploring creating an http module while learning mypy -> typing.

The goal is to discover custom features with request and responses to use in library discovery/development.

Thinking about....

1. Async Pytest / Robotframework
2. Datadog
3. Buildbot

Discovering ? :brain


```
from api import request


response = request('GET', 'https://jsonplaceholder.typicode.com/todos/1')
assert response.status_code == 200
print(response.body)
```